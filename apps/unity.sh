#!/usr/bin/env bash

# Installing Unity Desktop

ask "Do you want to install Unity Desktop?" response
if [[ $response =~ ^(yes|y|Y) ]];then
    bot "Installing Unity Desktop"
    require_apt ubuntu-unity-desktop

    bot "Installing Unity Tweak Tool"
    require_apt unity-tweak-tool

    bot "Installing Numix Gtk Theme"
    require_apt numix-gtk-theme

    bot "Installing Paper Font"
    
    action "sudo add-apt-repository ppa:snwh/ppa"
    sudo add-apt-repository ppa:snwh/ppa -y
    sstatus
    
    require_apt paper-icon-theme
else
    bot "Installing Gnome Tweak Tool"
    require_apt gnome-tweak-tool
fi

