#!/usr/bin/env bash

# Installs zsh and Oh My Zsh, registers zsh as a default shell

bot "Installing ZSH"
require_apt zsh

zsh_path=$(which zsh)

bot "Making zsh as default shell"

action "chsh -s \"$zsh_path\" $USER"
chsh -s "$zsh_path" $USER
sstatus

bot "Installing OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

bot "Installing ZSH Plugins"

# zsh-autosuggestions
action "git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sstatus

# zsh-syntax-highlighting
action "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sstatus

bot "Installing Powerlevel9k theme for ZSH"
action "git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
sstatus