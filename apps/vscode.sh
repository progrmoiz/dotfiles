#!/usr/bin/env bash

# Installs vscode

bot "Installing & Configuring Visual Studio Code"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

apt_update
require_apt code

bot "Making Visual Studio Code as default text editor"

action "xdg-mime default code.desktop text/plain"
xdg-mime default code.desktop text/plain
status

action "sudo update-alternatives --set editor /usr/bin/code"
sudo update-alternatives --set editor /usr/bin/code
status

source ../config/vscode/install.sh