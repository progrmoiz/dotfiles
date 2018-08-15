#!/usr/bin/env bash

# Installing GUI Tools

source $DOTFILES_DIR/lib.sh

bot "Installing GUI Tools."

# Except intsall.sh source every file in current directory 
for file in $(ls | grep -Ev 'install'); do
    source $file
done

bot "Installing Dropdown Shell Guake"
require_apt guake
