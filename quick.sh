#!/bin/sh -e
#
# dotfiles installation script
#
# Author: Abdul Moiz
# https://github.com/progrmoiz/dotfiles

# Exit if a dotfiles directory already exists
if [ -d "$HOME/dotfiles" ]; then
  printf "\\033[31mERROR:\\033[0m dotfiles is already installed on this system.\\n" >&2
  exit 1
fi

# Display warning and prompt user to confirm before proceeding
printf "\\n\\033[1mDOTFILES\\033[0m\\n"
printf "\\n\\033[31mWARNING:\\033[0m This will install new files and may overwrite\\nsome existing files in your home directory.\\n"
printf "\\nContinue? (y/n)\\n"
read -r REPLY
if [ "$REPLY" = Y ] || [ "$REPLY" = y ]; then
  printf "\\nInstalling dotfiles...\\n"
else
  printf "\\nProcess terminated by user.\\n" >&2
  exit 1
fi

# Install git if not already installed
if ! [ -x "$(command -v git)" ]; then
    sudo apt install git -y
fi

# Clone the dotfiles repository from GitHub and invoke the Makefile
git clone --recursive https://github.com/progrmoiz/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
source ./install.sh