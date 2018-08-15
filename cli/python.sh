#!/usr/bin/env bash

# Installs zsh and Oh My Zsh, registers zsh as a default shell

bot "Installing Python"
sudo add-apt-repository ppa:deadsnakes/ppa -y &> /dev/null

apt_update

require_apt software-properties-common
require_apt python3.6
require_apt python3-pip
require_apt build-essential
require_apt libssl-dev
require_apt libffi-dev
require_apt python3-dev

bot "Installing Python packages"
require_pip ipython
require_pip youtube_dl