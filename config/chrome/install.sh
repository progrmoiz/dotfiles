#!/usr/bin/env bash

bot "Installing Google Chrome policy config."
warn "It will disable incognito, force youtube restricted mode and enable safe search."

google-chrome --version &> /dev/null

if [[ $? -eq 0 ]];then
    ask "Do you want to really want chrome policy configs?" response
    if [[ $response =~ ^(yes|y|Y) ]];then
        if [[ -e /etc/opt/chrome/policies/managed/test_policy.json ]]; then
            iaction "cp /etc/opt/chrome/policies/managed/test_policy.json /etc/opt/chrome/policies/managed/test_policy.backup.json"
            sudo cp /etc/opt/chrome/policies/managed/test_policy.json /etc/opt/chrome/policies/managed/test_policy.backup.json
            status
        fi

        iaction "cp $DOTFILES_DIR/config/chrome/policy.json /etc/opt/chrome/policies/managed/test_policy.json"
        sudo cp $DOTFILES_DIR/config/chrome/policy.json /etc/opt/chrome/policies/managed/test_policy.json
        status

        bot "New policy config has been written. Please restart your Chrome."
        info "For more information on chrome policies. Visit here: https://www.chromium.org/administrators/policy-list-3"
    else
        ok "Skipping user config overwriting.";
    fi

else
    error "It looks like the command 'google-chrome' isn't accessible."
    error "Please make sure you have Google Chrome installed"
    error "Visit here: https://www.google.com/chrome/"
fi