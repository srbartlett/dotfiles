#!/bin/zsh

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias fm='foreman start'

alias gad='git add -u'

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


export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

eval "$(direnv hook zsh)"

alias ap-run-core='BYPASS_CHECKS=true  ./gradlew --parallel --max-workers=10 :admin-api:run :api:run :portal-api:run :merchant-portal-api:run :pos-api:run :loadtesting:stubs:run'
