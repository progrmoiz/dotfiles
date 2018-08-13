#!/bin/sh -e
#
# dotfiles installation script
#
# Author: Abdul Moiz
# https://github.com/progrmoiz/dotfiles
#
# Install by running either command:
# curl -fsSL get.darryl.sh | sh
# wget -qO- get.darryl.sh | sh

# Exit if a dotfiles directory already exists
if [ -d "$HOME/dotfiles" ]; then
  printf "\\033[31mERROR:\\033[0m dotfiles is already installed on this system.\\n" >&2
  exit 1
fi

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

# Display warning and prompt user to confirm before proceeding
printf "\\n\\033[1mDOTFILES\\033[0m\\n"
printf "\\n\\033[31mWARNING:\\033[0m This will install new files and may overwrite\\nsome existing files in your home directory.\\n"
printf "\\nContinue? (y/n)\\n"
read -r response
if [[ $response =~ (yes|y|Y) ]];then
  printf "\\nInstalling dotfiles...\\n"
else
  printf "\\nProcess terminated by user.\\n" >&2
  exit 1
fi

# Ask for the administrator password upfront
if ! sudo grep -q "%wheel		ALL=(ALL) NOPASSWD: ALL #atomantic/dotfiles" "/etc/sudoers"; then

  # Ask for the administrator password upfront
  bot "I need you to enter your sudo password so I can install some things:"
  sudo -v

  # Keep-alive: update existing sudo time stamp until the script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # TODO: sudo passwordless
  # bot "Do you want me to setup this machine to allow you to run sudo without a password?\nPlease read here to see what I am doing:\nhttp://wiki.summercode.com/sudo_without_a_password_in_mac_os_x \n"

  # printf "Make sudo passwordless? [y|N] "
  # read -r response

  # if [[ $response =~ (yes|y|Y) ]];then
  #     sudo cp /etc/sudoers /etc/sudoers.back
  #     echo '%wheel		ALL=(ALL) NOPASSWD: ALL #atomantic/dotfiles' | sudo tee -a /etc/sudoers > /dev/null
  #     sudo dscl . append /Groups/wheel GroupMembership $(whoami)
  #     bot "You can now run sudo commands without password!"
  # fi
fi

# /etc/hosts
read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? (from ./configs/hosts file) [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
    action "cp /etc/hosts /etc/hosts.backup"
    sudo cp /etc/hosts /etc/hosts.backup
    ok
    action "cp ./configs/hosts /etc/hosts"
    sudo cp ./configs/hosts /etc/hosts
    ok
    bot "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
fi

# Clone the dotfiles repository from GitHub and cd into it
git clone --recursive https://github.com/rootbeersoup/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles" || exit 1


