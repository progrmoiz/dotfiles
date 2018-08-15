#!/usr/bin/env bash

source ../lib.sh

bot "Installing UNIX tools."

require_apt curl
require_apt wget

# Except intsall.sh source every file in current directory 
for file in $(ls | grep -Ev 'install'); do
    source $file
done

bot "Installing Youtube-dl"
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

bot "Installing Stow"
require_apt stow