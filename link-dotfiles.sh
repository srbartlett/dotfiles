#!/bin/bash

echo "Creating symlinks for dotfiles to $HOME"

for f in dotfiles/\.[^.]*; do
  FILE="$(basename $f)"
  ln -sf "$PWD/dotfiles/$FILE" "$HOME"
done
