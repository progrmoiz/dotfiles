#!/usr/bin/env bash

# Installs zsh and Oh My Zsh, registers zsh as a default shell

sudo apt-get install zsh
zsh_path=$(which zsh)
action "Making zsh the default shell"
chsh -s "$zsh_path" $USER

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
