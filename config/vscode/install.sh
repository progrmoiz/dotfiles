#!/usr/bin/env bash

bot "Installing Visual Studio Code extensions and config."

code -v > /dev/null

if [[ $? -eq 0 ]];then
    ask "Do you want to install VSC extensions?" response
    if [[ $response =~ ^(yes|y|Y) ]];then
        running "Installing extensions please wait..."
        # TODO: code --list-extensions | xargs -L 1 echo require_code

        bot "Extensions for VSC have been installed. Please restart your VSC."
    else
        ok "Skipping extension install.";
    fi

    ask "Do you want to overwrite user config?" response
    if [[ $response =~ ^(yes|y|Y) ]];then
        action "cp .config/Code/User/settings.json .config/Code/User/settings.backup.json"    
        cp .config/Code/User/settings.json .config/Code/User/settings.backup.json
        ok

        action "cp .config/Code/User/settings.json .config/Code/User/settings.backup.json"    
        cp ./settings.json .config/Code/User/settings.json
        ok

        bot "New user config has been written. Please restart your VSC."
    else
        ok "Skipping user config overwriting.";
    fi

else
    error "It looks like the command 'code' isn't accessible."
    error "Please make sure you have Visual Studio Code installed"
    error "And that you executed this procedure: https://code.visualstudio.com/docs/setup/mac"
fi
