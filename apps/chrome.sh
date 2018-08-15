#!/usr/bin/env bash

# Installing Chrome

bot "Installing Google Chrome"

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

apt_update

require_apt google-chrome-stable

bot "Making Google Chrome as default browser"

action "xdg-settings set default-web-browser google-chrome.desktop"
xdg-settings set default-web-browser google-chrome.desktop
status