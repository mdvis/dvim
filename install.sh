#!/usr/bin/env bash

set -e
set -o pipefail

readonly APP_NAME="dvim"

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.$APP_NAME"
[ -z "$NVIM_PATH" ] && NVIM_PATH="$HOME/.config/nvim"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/mdvis/$APP_NAME.git"

is_debug="0"

debug() {
    if [ "$is_debug" -eq "1" ] && [ "$ret" -gt "1" ]; then
        msg "${FUNCNAME[1]}/${BASH_LINENO[1]}"
    fi
}

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

backup() {
    now=$(date +%Y%m%d_%s)
    fileName="$1"

    [ -e "$fileName" ] && mv "$fileName" "$fileName.$now"

    ret="$?"
    success "$fileName was backuped!"
    debug
}

initWorkDir() {
    dirList="$*"

    for fileName in $dirList; do
        [ -d "$fileName" ] || mkdir "$fileName"

        ret="$?"
        success "$fileName was created!"
        debug
    done
}

copyFile() {
    fileName="$1"
    sourceDir="$2"
    targetDir="$3"

    [ ! -d "$targetDir" ] && mkdir -p "$targetDir"

    cp "${sourceDir}${fileName}" "${targetDir}${fileName}"

    ret="$?"
    success "$sourceDir was copied!"
    debug
}

lnif() {
    fileName=$1
    sourceDir=$2
    targetDir=$3
    sourcePrefix=$4
    targetPrefix=$5

    sourcePath="$sourceDir/$sourcePrefix$fileName"
    targetPath="$targetDir/$targetPrefix$fileName"

    if [ -e "$sourcePath" ]; then
        ln -sf "$sourcePath" "$targetPath"
    fi

    ret="$?"
    success "$sourcePath was linked!"
    debug
}

syncRepo() {
    local repo_path="$1"
    local repo_uri="$2"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone "$repo_uri" "$repo_path"
    else
        cd "$repo_path" && git pull origin master
    fi

    ret="$?"
    success "Dvim clone done!"
    debug
}

installPlugins() {
    type nvim >/dev/null 2>&1 || local hasNvim="vim"
    local systemShell="$SHELL"

    export SHELL='/bin/sh'

    if [ "$hasNvim" = "vim" ]; then
        vim "+PlugInstall!" "+PlugClean" "+qall"
    else
        nvim "+PlugInstall!" "+PlugClean" "+qall"
    fi

    export SHELL="$systemShell"

    ret="$?"
    success "Plugins setup done!"
    debug
}

backup "$HOME/.vim"
backup "$HOME/.vimrc"
backup "$HOME/.vimrc.conf"
backup "$HOME/.vimrc.maps"
backup "$HOME/.vimrc.custom"
backup "$NVIM_PATH/init.vim"
backup "$HOME/.vimrc.plugins"

initWorkDir "$HOME/.swp" \
    "$HOME/.backup" \
    "$HOME/.undo" \
    "$NVIM_PATH" \
    "$APP_PATH"

syncRepo "$REPO_PATH" \
    "$REPO_URI"

copyFile "plug.vim" \
    "$REPO_PATH/autoload/" \
    "$APP_PATH/autoload/"

copyFile "conf.vim" \
    "$REPO_PATH/autoload/" \
    "$APP_PATH/autoload/"

copyFile "gruvbox.vim" \
    "$REPO_PATH/colors/" \
    "$APP_PATH/colors/"

lnif "vimrc" \
    "$REPO_PATH" \
    "$HOME" \
    "" \
    "."

lnif "init.vim" \
    "$REPO_PATH" \
    "$NVIM_PATH"

lnif "vimrc.conf" \
    "$REPO_PATH" \
    "$HOME" \
    "" \
    "."

lnif "vimrc.maps" \
    "$REPO_PATH" \
    "$HOME" \
    "" \
    "."

lnif "vimrc.custom" \
    "$REPO_PATH" \
    "$HOME" \
    "" \
    "."

lnif "vimrc.plugins" \
    "$REPO_PATH" \
    "$HOME" \
    "" \
    "."

installPlugins
