#!/bin/sh -e
#
# dotfiles installation script
#
# Author: Abdul Moiz
# https://github.com/progrmoiz/dotfiles

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DOTFILES_DIR/lib.sh

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
ask "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? (from ./configs/hosts file)" response
if [[ $response =~ ^(yes|y|Y) ]];then
    action "cp /etc/hosts /etc/hosts.backup"
    sudo cp /etc/hosts /etc/hosts.backup
    ok
    action "cp ./configs/hosts /etc/hosts"
    sudo cp ./configs/hosts /etc/hosts
    ok
    bot "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
fi

# ~/.config/autostart
ask "Do you want to setup startup application?" response
if [[ $response =~ ^(yes|y|Y) ]]; then
  mkdir -p "$HOME/.config/autostart"
  for file in ./config/autostart/*; do
    action "cp $file $HOME/.config/autostart/"${file##*/}
    cp $file "$HOME/.config/autostart/"${file##*/}
    ok
  done
  bot "You startup application has been setup. Restart to take effect."
fi


DIRS="cli apps fonts"

for dir in $DIRS; do
  cd "$DOTFILES_DIR/$dir/"
  source install.sh
  cd $DOTFILES_DIR
done

TODO: stow bash -t ~/