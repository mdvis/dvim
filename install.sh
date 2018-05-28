#!/usr/bin/env bash

APP_NAME="dvim"

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.$APP_NAME"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/manjuist/$APP_NAME.git"
[ -z "$PLUGINS_MANAGER_PATH" ] && PLUGINS_MANAGER_PATH="$APP_PATH/vim-plug"
[ -z "$PLUGINS_MANAGER_URI" ] && PLUGINS_MANAGER_URI="https://github.com/junegunn/vim-plug.git"

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
}

backup(){
    now=`date +%Y%m%d_%s`
    mv "$1" "$1.$now"
}

exiseBackup(){
    for i in $@
    do
        if [[ -e "$i" ]]; then
            backup $i
        fi
    done
 }

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone "$repo_uri" "$repo_path"
        ret="$?"
    else
        cd "$repo_path" && git pull origin master
        ret="$?"
    fi
    success "Download success!"
}

install_plugins() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'
    vim "+PlugInstall!" "+PlugClean" "+qall"
    export SHELL="$system_shell"
    ret="$?"
    success "Install plugins complete!"
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"
    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    lnif "$source_path/.vimrc.plugins" "$target_path/.vimrc.plugins"
    ret="$?"
    success "Link complete!"
}

copy_plug(){
    [ ! -d "$APP_PATH/autoload" ] && mkdir -p "$APP_PATH/autoload" 
    [ -d "$APP_PATH/autoload" ] && cp "$APP_PATH${1}${2}" "$APP_PATH/autoload/${2}" 
    ret="$?"
    success "Vim-plug install!"
}

copy_colors(){
    [ ! -d "$APP_PATH/colors" ] && mkdir -p "$APP_PATH/colors" 
    [ -d "$APP_PATH/colors" ] && cp "$APP_PATH${1}${2}" "$APP_PATH/colors/${2}" 
    ret="$?"
    success "Color install!"
}

exiseBackup     "$HOME/.vim" \
                "$HOME/.vimrc"

sync_repo       "$REPO_PATH" \
                "$REPO_URI"

sync_repo       "$PLUGINS_MANAGER_PATH" \
                "$PLUGINS_MANAGER_URI"

create_symlinks "$REPO_PATH" \
                "$HOME"

copy_plug       "/vim-plug/" \
                "plug.vim"

install_plugins

copy_colors     "/plugged/vim-distinguished/colors/" \
                "distinguished.vim"

copy_colors     "/plugged/molokai/colors/" \
                "molokai.vim"
