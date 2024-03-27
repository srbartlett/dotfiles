#!/usr/bin/env bash

#Check if Homebrew is installed
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo 'Please install Homebrew before running this script'
    exit -1
else
    brew update
fi

#Upgrade installed formulae
brew upgrade

#Tools
brew install ack
brew install tree
brew install fzf
brew install git
brew install zsh
brew install vim
brew install postgres
brew install nvm
brew install rbenv ruby-build rbenv-default-gems rbenv-gemset
brew install heroku/brew/heroku
brew install pass
brew install shared-mime-info # rails eependency
brew install cfn-lint
brew install imagemagick
brew install aws/tap/copilot-cli
brew install awslog
brew install python

#Apps
brew install --cask firefox
brew install --cask google-chrome
brew install --cask brave-browser
brew install --cask iterm2
brew install --cask slack
brew install --cask clipy
brew install --cask gpg-suite

# Quick look plugins
brew install --cask qlmarkdown \
  quicklook-csv \
  qlmarkdown \
  qlstephen \
  quicklook-json

# Remove outdated versions from the cellar.
brew cleanup
