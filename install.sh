#!/usr/bin/env bash

readonly APP_NAME="dvim"

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.$APP_NAME"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/manjuist/$APP_NAME.git"
#[ -z "$PLUGINS_MANAGER_PATH" ] && PLUGINS_MANAGER_PATH="$APP_PATH/vim-plug"
[ -z "$PLUGINS_MANAGER_URI" ] && PLUGINS_MANAGER_URI="https://github.com/junegunn/vim-plug.git"
readonly PLUGINS_MANAGER_PATH="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [[ "$ret" -gt "1" ]]; then
        msg "$FUNCNAME/$BASH_LINENO"
    fi
}

backup(){
    now=`date +%Y%m%d_%s`
    mv "$1" "$1.$now"
    debug
}

exiseBackup(){
    for i in $@; do
        if [[ -e "$i" ]]; then
            backup $i
        fi
    done
    debug
 }

syncRepo() {
    local repo_path="$1"
    local repo_uri="$2"
    local

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone "$repo_uri" "$repo_path"
        ret="$?"
    else
        cd "$repo_path" && git pull origin master
        ret="$?"
    fi
    success "Download success!"
    debug
}

installPlugins() {
    local systemShell="$SHELL"
    export SHELL='/bin/sh'
    vim "+PlugInstall!" "+PlugClean" "+qall"
    export SHELL="$systemShell"
    ret="$?"
    success "Install plugins complete!"
    debug
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

createSymlinks() {
    local source_path="$1"
    local target_path="$2"
    local

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    lnif "$source_path/.gvimrc"         "$target_path/.gvimrc"
    lnif "$source_path/.vimrc.plugins" "$target_path/.vimrc.plugins"
    ret="$?"
    success "Link complete!"
    debug
}

installPlug(){
    [ ! -d "$APP_PATH/autoload" ] && mkdir -p "$APP_PATH/autoload" 
    [ -d "$APP_PATH/autoload" ] && curl -sSL "$PLUGINS_MANAGER_PATH" -o "$APP_PATH/autoload/${2}" 
    ret="$?"
    success "Vim-plug install!"
    debug
}

copyColors(){
    [ ! -d "$APP_PATH/colors" ] && mkdir -p "$APP_PATH/colors" 
    [ -d "$APP_PATH/colors" ] && cp "$APP_PATH${1}${2}" "$APP_PATH/colors/${2}" 
    ret="$?"
    success "$2 Color install!"
    debug
}

exiseBackup     "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.vimrc.plugins"

syncRepo        "$REPO_PATH" \
                "$REPO_URI"

#syncRepo        "$PLUGINS_MANAGER_PATH" \
                #"$PLUGINS_MANAGER_URI"

createSymlinks "$REPO_PATH" \
                "$HOME"

installPlug       "/vim-plug/" \
                "plug.vim"

installPlugins

copyColors     "/plugged/solarized/vim-colors-solarized/colors/" \
                "solarized.vim"
