#!/bin/bash

# clone
cd /var/tmp
git clone https://github.com/powerline/fonts.git --depth=1

# install
cd fonts
./install.sh

# clean up
cd ..
rm -rf fonts
