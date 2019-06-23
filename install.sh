#!/usr/bin/env bash

set -e
set -o pipefail

readonly APP_NAME="dvim"
readonly PLUGINS_MANAGER_PATH="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.$APP_NAME"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/manjuist/$APP_NAME.git"
[ ! -d "~/.backup" ] && mkdir ~/.backup
[ ! -d "~/.swp" ] && mkdir ~/.swp
[ ! -d "~/.undo" ] && mkdir ~/.undo

is_debug="0"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq "0" ]; then
        msg "\033[32m[✔]\033[0m ${1}${2}"
    fi
}

error() {
    msg "\033[31m[✘]\033[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$is_debug" -eq "1" ] && [ "$ret" -gt "1" ]; then
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
        if [ -e "$i" ]; then
            backup $i
        fi
    done
    ret="$?"
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
    lnif "$source_path/.vimrc.plugins" "$target_path/.vimrc.plugins"
    lnif "$source_path/.vimrc.custom" "$target_path/.vimrc.custom"
    ret="$?"
    success "Link complete!"
    debug
}

setInstallPlug(){
    [ ! -d "$APP_PATH/autoload" ] && mkdir -p "$APP_PATH/autoload"
    [ -d "$APP_PATH/autoload" ] && curl -sSL "$PLUGINS_MANAGER_PATH" -o "$APP_PATH/autoload/${2}"
    ret="$?"
    success "Vim-plug install!"
    debug
}

copyColors(){
    [ ! -d "$APP_PATH/colors" ] && mkdir -p "$APP_PATH/colors"
    [ -d "$APP_PATH/colors" ] && cp "$REPO_PATH${1}${2}" "$APP_PATH/colors/${2}"
    ret="$?"
    success "$2 Color install!"
    debug
}

hasCommand(){
	for m in $@; do
		type $m>/dev/null 2>&1 || error "$m was not installed!"
	done
}

hasCommand      node \
                flake8 \
                pylint \
                autopep8 \
                isort \
                yapf


exiseBackup     "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.vimrc.plugins" \
                "$HOME/.vimrc.custom"

syncRepo        "$REPO_PATH" \
                "$REPO_URI"

createSymlinks  "$REPO_PATH" \
                "$HOME"

setInstallPlug  "/vim-plug/" \
                "plug.vim"

copyColors      "/colors/" \
                "gruvbox.vim"

installPlugins
