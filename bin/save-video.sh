#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# save-video: Extract and save a single YouTube transcript via TranscriptAPI
#
# Usage:
#   save-video <youtube_url> [tag1,tag2,...]
#
# Examples:
#   save-video "https://www.youtube.com/watch?v=abc123"
#   save-video "https://youtu.be/abc123" "ai,agents,orchestration"
#   save-video "dQw4w9WgXcQ" "music,memes"
#
# Environment:
#   TRANSCRIPTAPI_KEY  - Required. https://transcriptapi.com/dashboard/api-keys
#   KNOWLEDGE_DIR      - Optional. Defaults to ~/knowledge/youtube
#
# Dependencies: curl, jq (brew install jq)
# ============================================================================

KNOWLEDGE_DIR="${KNOWLEDGE_DIR:-$HOME/knowledge/youtube}"
API_BASE="https://transcriptapi.com/api/v2"
MAX_RETRIES=3

# --- Validation ---

if [[ $# -lt 1 ]]; then
  echo "Usage: save-video <youtube_url> [tag1,tag2,...]"
  exit 1
fi

if [[ -z "${TRANSCRIPTAPI_KEY:-}" ]]; then
  echo "Error: TRANSCRIPTAPI_KEY is not set."
  echo "Get your API key from: https://transcriptapi.com/dashboard/api-keys"
  echo "Then: export TRANSCRIPTAPI_KEY=sk_your_key_here"
  exit 1
fi

for cmd in curl jq; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is not installed. Run: brew install $cmd"
    exit 1
  fi
done

URL="$1"
TAGS="${2:-}"

# --- API request with retry + exponential backoff ---

api_request() {
  local endpoint="$1"
  shift
  local params="$*"
  local attempt=0
  local response http_code body

  while [[ $attempt -lt $MAX_RETRIES ]]; do
    response=$(curl -s -w "\n%{http_code}" \
      -H "Authorization: Bearer ${TRANSCRIPTAPI_KEY}" \
      "${API_BASE}${endpoint}?${params}")

    http_code=$(echo "$response" | tail -1)
    body=$(echo "$response" | sed '$d')

    case "$http_code" in
    200)
      echo "$body"
      return 0
      ;;
    408 | 429 | 503)
      attempt=$((attempt + 1))
      local wait=$((2 ** attempt))
      echo "⏳ Retryable error ($http_code), waiting ${wait}s... (attempt $attempt/$MAX_RETRIES)" >&2
      sleep "$wait"
      ;;
    401)
      echo "Error: Invalid API key. Check TRANSCRIPTAPI_KEY." >&2
      return 1
      ;;
    402)
      echo "Error: No credits remaining. Visit https://transcriptapi.com/billing" >&2
      return 1
      ;;
    404)
      echo "Error: Video not found or transcript unavailable." >&2
      return 1
      ;;
    422)
      echo "Error: Invalid YouTube URL or video ID." >&2
      return 1
      ;;
    *)
      echo "Error: Unexpected response ($http_code)" >&2
      echo "$body" >&2
      return 1
      ;;
    esac
  done

  echo "Error: Max retries exceeded." >&2
  return 1
}

# --- Fetch transcript with metadata ---

echo "📥 Fetching transcript and metadata..."

JSON_RESPONSE=$(api_request "/youtube/transcript" \
  "video_url=${URL}&format=json&include_timestamp=true&send_metadata=true") || exit 1

# --- Parse response ---

VIDEO_ID=$(echo "$JSON_RESPONSE" | jq -r '.video_id // "unknown"')
LANGUAGE=$(echo "$JSON_RESPONSE" | jq -r '.language // "en"')
TITLE=$(echo "$JSON_RESPONSE" | jq -r '.metadata.title // "Untitled"')
CHANNEL=$(echo "$JSON_RESPONSE" | jq -r '.metadata.author_name // "Unknown"')
CHANNEL_URL=$(echo "$JSON_RESPONSE" | jq -r '.metadata.author_url // ""')

echo "📺 Title:   $TITLE"
echo "📡 Channel: $CHANNEL"
echo "🆔 Video:   $VIDEO_ID"

# --- Build clean transcript text ---

TRANSCRIPT_TEXT=$(echo "$JSON_RESPONSE" | jq -r '
  [.transcript[] | .text] |
  [range(0; length; 5) as $i | .[($i):($i+5)] | join(" ")] |
  join("\n\n")
')

TRANSCRIPT_TIMESTAMPED=$(echo "$JSON_RESPONSE" | jq -r '
  .transcript[] |
  "[\(.start | tostring | split(".") | .[0])s] \(.text)"
')

# --- Compute stats ---

WORD_COUNT=$(echo "$TRANSCRIPT_TEXT" | wc -w | tr -d ' ')

DURATION_SECS=$(echo "$JSON_RESPONSE" | jq '
  (.transcript[-1].start + (.transcript[-1].duration // 0)) | floor
')
if [[ "$DURATION_SECS" -ge 3600 ]]; then
  DURATION="$((DURATION_SECS / 3600))h$(((DURATION_SECS % 3600) / 60))m"
elif [[ "$DURATION_SECS" -gt 0 ]]; then
  DURATION="$((DURATION_SECS / 60))m$((DURATION_SECS % 60))s"
else
  DURATION="unknown"
fi

echo "⏱  Duration: $DURATION"
echo "📝 Words:    $WORD_COUNT"

# --- Sanitise title for filename ---

SAFE_TITLE=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' |
  sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//' |
  cut -c1-80)
DATE_TODAY=$(date +%Y-%m-%d)
FILENAME="${DATE_TODAY}_${SAFE_TITLE}.md"

# --- Check for duplicates ---

mkdir -p "$KNOWLEDGE_DIR"
EXISTING=$(find "$KNOWLEDGE_DIR" -name "*.md" -exec grep -l "video_id: ${VIDEO_ID}" {} \; 2>/dev/null | head -1 || true)

if [[ -n "$EXISTING" ]]; then
  echo ""
  echo "⚠️  This video already exists: $EXISTING"
  read -r -p "   Overwrite? [y/N] " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Skipped."
    exit 0
  fi
fi

# --- Write output ---

OUTPUT_FILE="$KNOWLEDGE_DIR/$FILENAME"

cat >"$OUTPUT_FILE" <<MDEOF
---
title: "${TITLE}"
channel: "${CHANNEL}"
channel_url: ${CHANNEL_URL}
video_id: ${VIDEO_ID}
url: https://www.youtube.com/watch?v=${VIDEO_ID}
saved_date: ${DATE_TODAY}
duration: ${DURATION}
word_count: ${WORD_COUNT}
language: ${LANGUAGE}
tags: [${TAGS}]
---

# ${TITLE}

**Channel:** [${CHANNEL}](${CHANNEL_URL})
**Duration:** ${DURATION} | **Words:** ${WORD_COUNT} | **Language:** ${LANGUAGE}
**Source:** https://www.youtube.com/watch?v=${VIDEO_ID}

## Transcript

${TRANSCRIPT_TEXT}

## Timestamped Reference

<details>
<summary>Click to expand timestamped transcript</summary>

${TRANSCRIPT_TIMESTAMPED}

</details>
MDEOF

echo ""
echo "✅ Saved to: $OUTPUT_FILE"

# --- Knowledge base stats ---

TOTAL_WORDS=$(cat "$KNOWLEDGE_DIR"/*.md 2>/dev/null | wc -w | tr -d ' ')
FILE_COUNT=$(find "$KNOWLEDGE_DIR" -name "*.md" | wc -l | tr -d ' ')
echo "📚 Knowledge base: ${FILE_COUNT} videos, ~${TOTAL_WORDS} total words"

if [[ "$TOTAL_WORDS" -gt 100000 ]]; then
  echo "⚠️  Getting large — consider summarising older transcripts before uploading to Claude Projects"
fi
