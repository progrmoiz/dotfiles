#!/usr/bin/env bash

# Install Fonts

bot "Installing Font"
require_apt fonts-firacode

mkdir -p "$HOME/.fonts"
cp *.otf "$HOME/.fonts"

fc-cache -f -v