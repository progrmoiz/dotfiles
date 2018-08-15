#!/usr/bin/env bash
source $DOTFILES_DIR/lib.sh

bot "Installing UNIX tools."

require_apt curl
require_apt wget

# Except intsall.sh source every file in current directory 
for file in $(ls | grep -Ev 'install'); do
    source $file
done

bot "Installing Stow"
require_apt stow