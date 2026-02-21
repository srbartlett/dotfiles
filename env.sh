#!/bin/zsh

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias grep='grep --color=auto'

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias fm='foreman start'
alias vi='nvim'

alias gad='git add -u'

alias claude-skip='claude --allow-dangerously-skip-permissions'

export KNOWLEDGE_DIR="${KNOWLEDGE_DIR:-$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/knowledge/youtube}"
alias save-playlist='~/dev/dotfiles/bin/save-playlist.sh'
save-video() {
  "$HOME/dev/dotfiles/bin/save-video.sh" "$@"
}

export EDITOR=vim

unalias g
function g()
{
  if [ "$#" = '0' ]; then
    git status
   else
    git "$@"
  fi
}

function f() { find . -iname "*$1*" ${@:2} }

function options() {
    PLUGIN_PATH="$HOME/.oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}
eval "$(rbenv init -)"


#export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
#alias java11='export JAVA_HOME=$JAVA_11_HOME'

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# postgres
alias startpostgres="pg_ctl -D /usr/local/var/postgres start"
alias stoppostgres="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias startpostgresm1="pg_ctl -D /opt/homebrew/var/postgresql@9.6 start"
alias stoppostgresm1="pg_ctl -D /opt/homebrew/var/postgresql@9.6 stop -s -m fast"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias d="cd ~/dev"

# Downloads a .mp3 file
function dlmp3 () {
  youtube-dl --extract-audio --audio-format mp3 $1
}

function dlmp4 () {
  youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $1
}


function dockerclean() {
  # remove exited containers:
  docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v

  # remove unused images:
  docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs docker rmi

  # remove unused volumes:
  docker volume ls -qf dangling=true | xargs docker volume rm
}


function backup() {

  host=$(hostname)
  log="/tmp/backup.log"
  src=$HOME
  dest=/Volumes/Station

  echo "++ START BACKUP $(date)" > $log
  echo "" >> $log
  echo "host: $(hostname -f)" >> $log
  echo "" >> $log

  rsync -a -R -r --stats --progress --files-from=/Users/stephen/dev/dotfiles/backup_include --exclude-from=/Users/stephen/dev/dotfiles/backup_exclude /Users/stephen/ $dest/$host/ >> $log

  echo "" >> $log
  echo "-- END BACKUP $(date)" >> $log

}

#postgres
export PATH="$PATH:/usr/local/opt/postgresql@9.6/bin"
export PATH="$PATH:/opt/homebrew/opt/postgresql@9.6/bin" # M1


# heroku
alias h='heroku'
alias hl='heroku list'
alias hi='heroku info'
alias ho='heroku open'

# dynos and workers
alias hd='heroku dynos'
alias hw='heroku workers'

# rake console
alias hr='heroku run rake'
alias hcon='heroku run rails console'

# new and restart
alias hnew='heroku create'
alias hrestart='heroku restart'

# logs
alias hlog='heroku logs'
alias hlogs='heroku logs'

# maint
alias hon='heroku maintenance:on'
alias hoff='heroku maintenance:off'

# heroku configs
alias hc='heroku config'
alias hca='heroku config:add'
alias hcr='heroku config:remove'
alias hcc='heroku config:clear'

alias hh="git push heroku master"

heroku-help () {
  echo "Heroku Aliases Usage"
  echo
  echo "  h           = heroku"
  echo "  hl          = heroku list"
  echo "  hi          = heroku info"
  echo "  ho          = heroku open"
  echo "  hd          = heroku dynos"
  echo "  hw          = heroku workers"
  echo "  hr          = heroku run rake"
  echo "  hcon        = heroku run rail console"
  echo "  hnew        = heroku create"
  echo "  hrestart    = heroku restart"
  echo "  hlog        = heroku logs"
  echo "  hon         = heroku maintenance:on"
  echo "  hoff        = heroku maintenance:off"
  echo "  hc          = heroku config"
  echo "  hca         = heroku config:add"
  echo "  hcr         = heroku config:remove"
  echo "  hcc         = heroku config:clear"
  echo
}

alias c='copilot'
alias rcp='c svc exec --env us-prod --name app  --command "./config/docker/run_console.sh"'

# Source secrets from external file which is not version controlled
source ~/dev/dotfiles/secrets.env

function commitmsg() {
  rbenv version 3.2
  lc issue list $1 --full | ~/dev/chatgpt.sh -i "You are a software developer with expert skills in writing a git commit message. Write a one line Git commit message for this issue.  Prefix with feat: fix: chore: refactor: depending on the change and also include the linear issue number"
}

function prmsg() {
  rbenv version 3.2
  lc issue list $1 --full | ~/dev/chatgpt.sh -i "You are a software developer with expert skills in writing a PR description. Write one or two sentences to describe a PR description for this issue  line Git commit message for this issue: "
}

function prdesc() {
  # gh pr diff
  git diff origin/main | ~/dev/chatgpt.sh -m gpt-4o --max-tokens 1000 -i "Please write a pull request for the code supplied using the following structure:  Overview and Implemenation. And also the short PR title"
}

function prtestpilot() {
  gh pr diff | ~/dev/chatgpt.sh -m gpt-4o --max-tokens 800 -i "Please can you help me write a test strategy for this feature, giving preference to testing the application in a web browser"
}

export OPENAI_API_KEY=$OPENAI_KEY
alias pip='pip3'
alias python='python'
alias run_sidekiq="rails runner 'Sidekiq.redis { |conn| conn.flushdb }' && bundle exec sidekiq --config ./config/sidekiq.yml"

export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
