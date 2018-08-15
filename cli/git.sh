#!/usr/bin/env bash

# Installing Git

bot "Installing Git"

require_apt git-all

git config --global core.excludesfile "$HOME/.gitignore_global"