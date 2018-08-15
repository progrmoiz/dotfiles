#!/usr/bin/env bash

###
# some colorized echo helpers
# @author Abdul Moiz
###

# Colors
ESC_SEQ="\x1B["
COL_RESET=$ESC_SEQ"0m"
COL_RED=$ESC_SEQ"31m"   
COL_GREEN=$ESC_SEQ"32m"
COL_YELLOW=$ESC_SEQ"33m"
COL_BLUE=$ESC_SEQ"34m"
COL_MAGENTA=$ESC_SEQ"35m"
COL_CYAN=$ESC_SEQ"36m"

function ok() {
    echo -e "${COL_GREEN}[ok]${COL_RESET} "$1
}

function bot() {
    echo -e "\n${COL_GREEN}\[._.]/${COL_RESET} - "$1
}

function running() {
    echo -e "${COL_YELLOW} ⇒ ${COL_RESET}"$1""
}

function action() {
    echo -e "${COL_YELLOW}[action]${COL_RESET} "$@
}

function iaction() {
    echo -en "${COL_YELLOW}[action]${COL_RESET} "$@" ..."
}

function warn() {
    echo -e "${COL_YELLOW}[warning]${COL_RESET} "$1
}

function error() {
    echo -e "${COL_RED}[error]${COL_RESET} "$1
}

# ask [QUESTION] [RESPONSE_VAR]
function ask() {
  printf "$1 [y|N] "
  read -r $2
}

function sstatus() {
    if [[ $? != 0 ]]; then
        error
    else 
        ok
    fi
}

function status() {
    if [[ $? != 0 ]]; then
        printf ' error\n'
    else 
        printf ' done\n'
    fi
}

function sourceNVM(){
    export NVM_DIR=~/.nvm
    source $NVM_DIR/nvm.sh
}

function require_npm() {
    sourceNVM
    nvm use node --lts &> /dev/null
    running "npm $1"
    npm list -g --depth 0 | grep $1@ > /dev/null
    if [[ $? != 0 ]]; then
        action "npm install -g $1"
        npm install -g "$1"
        sstatus
    fi
}

function require_pip() {
    running "pip3 $1"
    if [[ $(pip3 list --local --format=columns | grep "$1" | head -1 | cut -d' ' -f1) != "$1" ]]; then
        action "pip3 install $1"
        pip3 install "$1"
        sstatus
    fi
}

function require_apt() {
    running "apt $1"
    if [[ $(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
        action "sudo apt install $1"
        sudo apt install -y -qq $1
        sstatus
    fi
}

function require_code() {
    running "code $1"
    if [[ $(code --list-extensions &> /dev/null | grep -c $1) -eq 0 ]]; then
        action "code --install-extension $1"
        code --install-extension $1 &> /dev/null
        sstatus
    fi
}

function apt_update() {
    action "sudo apt update"
    sudo apt update -q
    sstatus
}