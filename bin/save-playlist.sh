#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# save-playlist: Batch-save all transcripts from a YouTube playlist
#
# Uses yt-dlp for reliable playlist listing, then TranscriptAPI (via
# save-video) for transcript extraction.
#
# Usage:
#   save-playlist <playlist_url> [tag1,tag2,...]
#
# Examples:
#   save-playlist "https://youtube.com/playlist?list=PLesQsnCiRuVQ..." "ai,agents"
#   DRY_RUN=1 save-playlist "https://youtube.com/playlist?list=PL..."
#   MAX_VIDEOS=5 save-playlist "https://youtube.com/playlist?list=PL..." "test"
#
# Options (via environment):
#   TRANSCRIPTAPI_KEY  - Required. API key for save-video
#   KNOWLEDGE_DIR      - Output directory (default: ~/knowledge/youtube)
#   SAVE_VIDEO_CMD     - Path to save-video script (default: ~/scripts/save-video.sh)
#   DELAY              - Seconds between transcript fetches (default: 2)
#   DRY_RUN            - Set to 1 to list videos without fetching (default: 0)
#   MAX_VIDEOS         - Limit number of videos to process (default: unlimited)
#   SKIP_EXISTING      - Set to 1 to skip already-saved videos (default: 1)
#
# Dependencies: yt-dlp, curl, jq, save-video script
# ============================================================================

KNOWLEDGE_DIR="${KNOWLEDGE_DIR:-$HOME/knowledge/youtube}"
SAVE_VIDEO_CMD="${SAVE_VIDEO_CMD:-$HOME/dev/dotfiles/bin/save-video.sh}"
DELAY="${DELAY:-2}"
DRY_RUN="${DRY_RUN:-0}"
MAX_VIDEOS="${MAX_VIDEOS:-0}"
SKIP_EXISTING="${SKIP_EXISTING:-1}"

# --- Validation ---

if [[ $# -lt 1 ]]; then
  echo "Usage: save-playlist <playlist_url> [tag1,tag2,...]"
  echo ""
  echo "Options (environment variables):"
  echo "  DELAY=5              Seconds between fetches (default: 2)"
  echo "  DRY_RUN=1            List videos without downloading"
  echo "  MAX_VIDEOS=10        Limit number of videos to process"
  echo "  SKIP_EXISTING=0      Re-download already saved videos"
  echo "  SAVE_VIDEO_CMD=path  Path to save-video script"
  exit 1
fi

if [[ -z "${TRANSCRIPTAPI_KEY:-}" ]]; then
  echo "Error: TRANSCRIPTAPI_KEY is not set."
  exit 1
fi

if ! command -v yt-dlp &>/dev/null; then
  echo "Error: yt-dlp is not installed. Run: brew install yt-dlp"
  echo "       (Used only for listing playlist contents, not for transcripts)"
  exit 1
fi

if [[ ! -x "$SAVE_VIDEO_CMD" ]]; then
  echo "Error: save-video script not found at $SAVE_VIDEO_CMD"
  echo "Set SAVE_VIDEO_CMD to the correct path."
  exit 1
fi

PLAYLIST_URL="$1"
TAGS="${2:-}"

# --- List all videos in the playlist via yt-dlp ---

echo "📋 Fetching playlist contents via yt-dlp..."

# --flat-playlist skips downloading, just lists metadata
# Output format: video_id<TAB>title
PLAYLIST_DATA=$(yt-dlp \
  --flat-playlist \
  --print "%(id)s	%(title)s" \
  --no-warnings \
  "$PLAYLIST_URL" 2>/dev/null) || {
  echo "Error: Failed to fetch playlist. Check the URL is correct and public."
  exit 1
}

if [[ -z "$PLAYLIST_DATA" ]]; then
  echo "Error: No videos found in playlist."
  exit 1
fi

# Parse into arrays
VIDEO_IDS=()
VIDEO_TITLES=()
while IFS=$'\t' read -r vid title; do
  VIDEO_IDS+=("$vid")
  VIDEO_TITLES+=("${title:-Untitled}")
done <<<"$PLAYLIST_DATA"

TOTAL_VIDEOS=${#VIDEO_IDS[@]}
echo "📺 Found $TOTAL_VIDEOS videos in playlist"

# --- Apply MAX_VIDEOS limit ---

if [[ "$MAX_VIDEOS" -gt 0 ]] && [[ "$TOTAL_VIDEOS" -gt "$MAX_VIDEOS" ]]; then
  echo "🔢 Limiting to first $MAX_VIDEOS videos (of $TOTAL_VIDEOS)"
  TOTAL_VIDEOS=$MAX_VIDEOS
fi

# --- Check for already-saved videos ---

mkdir -p "$KNOWLEDGE_DIR"
SKIP_COUNT=0
EXISTING_IDS=""

if [[ "$SKIP_EXISTING" == "1" ]]; then
  EXISTING_IDS=$(grep -rh "^video_id:" "$KNOWLEDGE_DIR"/*.md 2>/dev/null |
    sed 's/video_id: //' | sort -u || true)
fi

# --- Display plan ---

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

for i in $(seq 0 $((TOTAL_VIDEOS - 1))); do
  VID="${VIDEO_IDS[$i]}"
  TITLE="${VIDEO_TITLES[$i]}"

  SKIP=""
  if [[ "$SKIP_EXISTING" == "1" ]] && echo "$EXISTING_IDS" | grep -q "^${VID}$" 2>/dev/null; then
    SKIP=" [SKIP - already saved]"
    SKIP_COUNT=$((SKIP_COUNT + 1))
  fi

  printf "  %3d. %-60s %s\n" "$((i + 1))" "${TITLE:0:60}" "$SKIP"
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PROCESS_COUNT=$((TOTAL_VIDEOS - SKIP_COUNT))

echo ""
echo "📊 Plan: $PROCESS_COUNT to fetch, $SKIP_COUNT to skip"
echo "💳 Estimated credits: ~$PROCESS_COUNT (1 per transcript)"

if [[ "$DRY_RUN" == "1" ]]; then
  echo ""
  echo "🏁 Dry run complete. Remove DRY_RUN=1 to fetch transcripts."
  exit 0
fi

if [[ "$PROCESS_COUNT" -eq 0 ]]; then
  echo ""
  echo "✅ All videos already saved. Nothing to do."
  exit 0
fi

echo ""
read -r -p "Proceed? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

# --- Process each video ---

echo ""
SUCCESS=0
FAILED=0
SKIPPED=0
FAILED_LIST=""

for i in $(seq 0 $((TOTAL_VIDEOS - 1))); do
  VID="${VIDEO_IDS[$i]}"
  TITLE="${VIDEO_TITLES[$i]}"

  echo ""
  echo "━━━ [$((i + 1))/$TOTAL_VIDEOS] $TITLE ━━━"

  # Skip if already saved
  if [[ "$SKIP_EXISTING" == "1" ]] && echo "$EXISTING_IDS" | grep -q "^${VID}$" 2>/dev/null; then
    echo "⏭  Already saved, skipping."
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  # Skip if no video ID
  if [[ -z "$VID" ]]; then
    echo "⚠️  No video ID, skipping."
    FAILED=$((FAILED + 1))
    continue
  fi

  # Call save-video (pipe yes to auto-confirm any overwrite prompts)
  if yes n 2>/dev/null | "$SAVE_VIDEO_CMD" "$VID" "$TAGS"; then
    SUCCESS=$((SUCCESS + 1))
  else
    FAILED=$((FAILED + 1))
    FAILED_LIST="${FAILED_LIST}\n  - ${TITLE} (${VID})"
  fi

  # Rate limit between requests
  if [[ $i -lt $((TOTAL_VIDEOS - 1)) ]]; then
    sleep "$DELAY"
  fi
done

# --- Summary ---

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Playlist batch complete"
echo "   ✅ Saved:   $SUCCESS"
echo "   ⏭  Skipped: $SKIPPED"
echo "   ❌ Failed:  $FAILED"

if [[ -n "$FAILED_LIST" ]]; then
  echo ""
  echo "Failed videos:"
  echo -e "$FAILED_LIST"
fi

# Knowledge base totals
TOTAL_WORDS=$(cat "$KNOWLEDGE_DIR"/*.md 2>/dev/null | wc -w | tr -d ' ')
FILE_COUNT=$(find "$KNOWLEDGE_DIR" -name "*.md" | wc -l | tr -d ' ')
echo ""
echo "📚 Knowledge base: ${FILE_COUNT} videos, ~${TOTAL_WORDS} total words"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
