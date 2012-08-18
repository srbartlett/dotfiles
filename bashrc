# See following for more information: http://www.infinitered.com/blog/?p=19


# Ruby
export RUBYOPT=rubygems

export R_HOME=/Library/Frameworks/R.framework/Resources


# Path ------------------------------------------------------------
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [ -d ~/bin ]; then
	export PATH=:~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi

# Colors ----------------------------------------------------------
export TERM=xterm-color

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

export CLICOLOR=1

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
#alias ls='ls --color=auto' # For linux, etc

# ls colors, see: http://www.linux-sxs.org/housekeeping/lscolors.html
#export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'  #LS_COLORS is not supported by the default ls command in OS-X

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # Lists all the colors, uses vars in .bashrc_non-interactive


# Misc -------------------------------------------------------------
export HISTCONTROL=ignoredups
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Prompts ----------------------------------------------------------
if [ -f /usr/local/bin/git-completion.bash ]; then source /usr/local/bin/git-completion.bash; fi # for Git completion
#export PS1="\[${COLOR_GREEN}\]\w > \[${COLOR_NC}\]"  # Primary prompt with only a path
# export PS1="\[${COLOR_GRAY}\]\u@\h \[${COLOR_GREEN}\]\w > \[${COLOR_NC}\]"  # Primary prompt with user, host, and path
export PS1="\[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \" (%s)\") \[\033[01;36m\]\$\[\033[00m\] "

# This runs before the prompt and sets the title of the xterm* window.  If you set the title in the prompt
# weird wrapping errors occur on some systems, so this method is superior
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"'  # user@host path

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

function xtitle {  # change the title of your xterm* window
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007"
}



# Navigation -------------------------------------------------------
alias ..='cd ..'
alias ...='cd .. ; cd ..'

# I got the following from, and mod'd it: http://www.macosxhints.com/article.php?story=20020716005123797
#    The following aliases (save & show) are for saving frequently used directories
#    You can save a directory using an abbreviation of your choosing. Eg. save ms
#    You can subsequently move to one of the saved directories by using cd with
#    the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
	touch ~/.dirs
fi

alias show='cat ~/.dirs'
save (){
	command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility



# Other aliases ----------------------------------------------------
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Misc
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias m='more'
alias df='df -h'

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias r="rvm use 1.8.7 && /Users/stephen/work/rea/rea-env/bin/rea-env"
alias r_up="cd /Users/stephen/work/rea/rea-env; g pull"

# Editors ----------------------------------------------------------
export EDITOR='mvim'

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi

      # Add the following to your ~/.bashrc or ~/.zshrc
      hitch() {
        command hitch "$@"
        if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
      }
      alias unhitch='hitch -u'
      # Uncomment to persist pair info between terminal instances
      # hitch


alias b="bundle"
#alias bi="b install --path vendor"
alias bi="b install"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# rails
alias rc='./script/rails c $@'
alias rs='./script/rails s $@'
alias rg='./script/rails g $@'

# alias 'g' to git. If no args supplied, do "git status"
function g
{
  if [ "$#" = '0' ]; then
    git status
   else
    git "$@"
  fi
}

alias ec2_work="source $HOME/.ec2/rea/env"
alias ec2_pers="source $HOME/.ec2/pers/env"

# use vi bindings
# set -o vi
#
#
#ORACLE
export DYLD_LIBRARY_PATH=/Users/stephen/work/dius/oracle/instantclient_10_2
