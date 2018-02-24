#!/usr/bin/env bash

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"

[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.d-vim"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/manjuist/d-vim.git"

[ -z "$VIMPLUG_PATH" ] && VIMPLUG_PATH="$HOME/.vim/plugged/vim-plug"
[ -z "$VIMPLUG_URI" ] && VIMPLUG_URI="https://github.com/junegunn/vim-plug.git"

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

sync_repo() {
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
    success "${3}.Download success!"
}

install_plugins() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'
    vim "+PlugInstall!" "+PlugClean" "+qall"
    export SHELL="$system_shell"
    ret="$?"
    success "${1}.Install plugins complete!"
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
    success "${3}.Link complete!"
}

copy_plug(){
    [ ! -d "$APP_PATH/autoload" ] && mkdir -p "$APP_PATH/autoload" 
    [ -d "$APP_PATH/autoload" ] && cp "$APP_PATH${1}${2}" "$APP_PATH/autoload/${2}" 
    ret="$?"
    success "${3}.Vim-plug install!"
}

copy_colors(){
    [ ! -d "$APP_PATH/colors" ] && mkdir -p "$APP_PATH/colors" 
    [ -d "$APP_PATH/colors" ] && cp "$APP_PATH${1}${2}" "$APP_PATH/colors/${2}" 
    ret="$?"
    success "${3}.Color install!"
}

sync_repo "$REPO_PATH" "$REPO_URI" "1"
sync_repo "$VIMPLUG_PATH" "$VIMPLUG_URI" "2"
create_symlinks "$REPO_PATH" "$HOME" "3"
copy_plug "/plugged/vim-plug/" "plug.vim" "4"
install_plugins "5"
copy_colors "/plugged/vim-distinguished/colors/" "distinguished.vim" "6"
copy_colors "/plugged/molokai/colors/" "molokai.vim" "7"
