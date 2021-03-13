# Dotfile Installation

1. ./brew.sh
2. ./install-oh-my-zsh.sh
3. ./link-dotfiles.sh
4. ./install-fonts.sh


## Vim

    mkdir ~/.vim

Install Vundler

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Colour Scheme

    mkdir ~/.vim/colors
    (cd ~/.vim/colors && curl -O https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim)
