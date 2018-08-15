#!/usr/bin/env bash

sourceNVM

# Ideally should check if command is already available
# require_curl [COMMAND] [URL]
function require_curl() {
    running "curl $1"
    curl --output /dev/null --silent --head --fail "$2"
    if [[ $? -eq 0 ]]; then
        action "curl $2 | bash"
        curl -o- "$2" --silent | sh
        ok "Close and reopen your terminal to start using nvm"
    else 
        error "Could not install $1"
    fi
}

bot "Installing Node Version Manager (NVM)"
require_curl nvm https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh

bot "Installing latest Node Release"
action "nvm install node"
nvm install node
sstatus

iaction "nvm use node"
nvm use node &> /dev/null
status

bot "Installing latest Node LTS Release"
action "nvm install node --lts"
nvm install node --lts
sstatus

bot "Installing latest NPM"
action "nvm install-latest-npm"
nvm install-latest-npm
sstatus

bot "Installing Node Packages"
# TODO: npm list -g --depth 0 | grep @ | cut -c 11- | cut -f 1 -d '@' | xargs -L 1 echo require_npm