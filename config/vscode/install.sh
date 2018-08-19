#!/usr/bin/env bash

bot "Installing Visual Studio Code extensions and config."

code -v > /dev/null

if [[ $? -eq 0 ]];then
    ask "Do you want to install VSC extensions?" response
    if [[ $response =~ ^(yes|y|Y) ]];then
        running "Installing extensions please wait..."
        # NOTE: code --list-extensions | xargs -L 1 echo require_code

        require_code 2gua.rainbow-brackets
        require_code abusaidm.html-snippets
        require_code alefragnani.project-manager
        require_code be5invis.vscode-custom-css
        require_code brpaz.file-templates
        require_code christian-kohler.npm-intellisense
        require_code christian-kohler.path-intellisense
        require_code dbaeumer.vscode-eslint
        require_code dbalage.vscode-stylesheet-formatter
        require_code donjayamanne.githistory
        require_code dsznajder.es7-react-js-snippets
        require_code dzannotti.vscode-babel-coloring
        require_code eamodio.gitlens
        require_code ecmel.vscode-html-css
        require_code EditorConfig.EditorConfig
        require_code EQuimper.react-native-react-redux
        require_code esbenp.prettier-vscode
        require_code felipecaputo.git-project-manager
        require_code formulahendry.auto-close-tag
        require_code formulahendry.auto-rename-tag
        require_code gamunu.vscode-yarn
        require_code hnw.vscode-auto-open-markdown-preview
        require_code humao.rest-client
        require_code jpoissonnier.vscode-styled-components
        require_code kumar-harsh.graphql-for-vscode
        require_code leizongmin.node-module-intellisense
        require_code lextudio.restructuredtext
        require_code mechatroner.rainbow-csv
        require_code mgmcdermott.vscode-language-babel
        require_code michelemelluso.code-beautifier
        require_code mrmlnc.vscode-scss
        require_code ms-python.python
        require_code ms-vscode.cpptools
        require_code ms-vscode.sublime-keybindings
        require_code msjsdiag.debugger-for-chrome
        require_code naumovs.color-highlight
        require_code quicktype.quicktype
        require_code robertohuertasm.vscode-icons
        require_code shardulm94.trailing-spaces
        require_code spywhere.guides
        require_code streetsidesoftware.code-spell-checker
        require_code tht13.rst-vscode
        require_code wayou.vscode-todo-highlight
        require_code xabikos.JavaScriptSnippets
        require_code xabikos.ReactSnippets
        require_code yzhang.markdown-all-in-one
        require_code Zignd.html-css-class-completion

        bot "Extensions for VSC have been installed. Please restart your VSC."
    else
        ok "Skipping extension install.";
    fi

    ask "Do you want to overwrite user config?" response
    if [[ $response =~ ^(yes|y|Y) ]];then
        if [[ -e ~/.config/Code/User/settings.json ]]; then
            iaction "cp ~/.config/Code/User/settings.json ~/.config/Code/User/settings.backup.json"    
            cp ~/.config/Code/User/settings.json ~/.config/Code/User/settings.backup.json
            status
        fi

        iaction "cp $DOTFILES_DIR/config/settings.json ~/.config/Code/User/settings.json"    
        cp $DOTFILES_DIR/config/vscode/settings.json ~/.config/Code/User/settings.json
        status

        bot "New user config has been written. Please restart your VSC."
    else
        ok "Skipping user config overwriting.";
    fi

else
    error "It looks like the command 'code' isn't accessible."
    error "Please make sure you have Visual Studio Code installed"
    error "And that you executed this procedure: https://code.visualstudio.com/docs/setup/linux"
fi
