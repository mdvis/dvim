#!/usr/bin/env bash

set -e
set -o pipefail

readonly APP_NAME="dvim"
readonly NVIM_PATH="$HOME/.config/nvim"
readonly PLUGINS_MANAGER_PATH="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.$APP_NAME"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/mdvis/$APP_NAME.git"

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
        msg "${FUNCNAME[1]}/${BASH_LINENO[1]}"
    fi
}

backup() {
    now=$(date +%Y%m%d_%s)
    mv "$1" "$1.$now"
    debug
}

exiseBackup() {
    for i in "$@"; do
        if [ -e "$i" ]; then
            backup "$i"
        fi
    done
    ret="$?"
    debug
}

syncRepo() {
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
    debug
}

installPlugins() {
    type nvim >/dev/null 2>&1 || local hasNvim="vim"
    local systemShell="$SHELL"
    local

    export SHELL='/bin/sh'

    if [ "$hasNvim" = "vim" ]; then
        vim "+PlugInstall!" "+PlugClean" "+qall"
    else
        nvim "+PlugInstall!" "+PlugClean" "+qall"
    fi

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
    local index=1

    for linkName in "$@"; do
        [ $index -eq 1 ] && local source_path=$linkName
        [ $index -eq 2 ] && local target_path=$linkName
        [ $index -ge 3 ] && lnif "$source_path/$linkName" "$target_path/$linkName"
        index=$((index + 1))
    done
    ret="$?"
    success "Link complete!"
    debug
}

setInstallPlug() {
    [ ! -d "$APP_PATH/autoload" ] && mkdir -p "$APP_PATH/autoload"
    [ -d "$APP_PATH/autoload" ] && curl -sSL "$PLUGINS_MANAGER_PATH" -o "$APP_PATH/autoload/${2}"
    ret="$?"
    success "Vim-plug install!"
    debug
}

copyColors() {
    [ ! -d "$APP_PATH/colors" ] && mkdir -p "$APP_PATH/colors"
    [ -d "$APP_PATH/colors" ] && cp "$REPO_PATH${1}${2}" "$APP_PATH/colors/${2}"
    ret="$?"
    success "$2 Color install!"
    debug
}

nvmConf() {
    [ ! -d "$NVIM_PATH" ] && mkdir -p "$NVIM_PATH"
    [ -d "$NVIM_PATH" ] && ln -sf "$REPO_PATH/init.vim" "$NVIM_PATH/init.vim"
}

exiseBackup "$HOME/.vim" \
    "$HOME/.vimrc" \
    "$HOME/.vimrc.conf" \
    "$HOME/.vimrc.maps" \
    "$HOME/.vimrc.plugins" \
    "$HOME/.vimrc.custom" \
    "$NVIM_PATH/init.vim"

syncRepo "$REPO_PATH" \
    "$REPO_URI"

nvmConf

createSymlinks "$REPO_PATH" \
    "$HOME" \
    ".vimrc" \
    ".vimrc.conf" \
    ".vimrc.maps" \
    ".vimrc.plugins" \
    ".vimrc.custom"

setInstallPlug "/vim-plug/" \
    "plug.vim"

copyColors "/colors/" \
    "gruvbox.vim"

installPlugins
