#!/usr/bin/env bash

# ------
# name: install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

readonly APP_NAME="dvim"
readonly APP_SETUP_NAME=".vim"
readonly REPO_PATH="$HOME/$APP_SETUP_NAME"
readonly CONFIG_PATH="$HOME/$APP_SETUP_NAME/config"
readonly NVIM_PATH="$HOME/.config/nvim"
readonly REPO_URI="https://github.com/mdvis/$APP_NAME.git"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "\033[32m[✔]\033[0m ${1}${2}"
}

error() {
    msg "\033[31m[✘]\033[0m ${1}${2}"
    exit 1
}

initWorkDir() {
    dirList="$*"

    for fileName in $dirList; do
        [ -d "$fileName" ] || mkdir -p "$fileName"

        success "$fileName was created!"
    done

    success "Init dir done!"
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

syncRepo() {
    local repo_path="$1"
    local repo_uri="$2"

    if [ ! -e "$repo_path" ]; then
        # mkdir -p "$repo_path"
        git clone --depth 1 "$repo_uri" "$repo_path"
    else
        cd "$repo_path" && git pull origin main
    fi

    name=$(basename "${repo_uri%.git}")

    success "Clone $name done!"
}

installPlugins() {
    echo "install plugins ..."
    type nvim >/dev/null 2>&1 || local hasNvim="vim"
    local systemShell="$SHELL"

    export SHELL='/bin/sh'

    if [ "$hasNvim" = "vim" ]; then
        vim "+PlugInstall!" "+PlugClean" "+qall"
    else
        nvim "+PlugInstall!" "+PlugClean" "+qall"
    fi

    export SHELL="$systemShell"

    success "Plugins setup done!"
}

getFile() {
    local dir_name=$1
    # dir_list=$(/usr/bin/find "${dir_name}" -maxdepth 1)
    dir_list=$(ls "${dir_name}")
}

backup() {
    list="$*"
    time=$(date +%s)
    for i in $list; do
        [[ -d "${i}" ]] && mv "${i}" "${i}"."${time}"

        success "Buckup $i success!"
    done
}

handler() {
    local file
    local path_name="$1"
    local target_dir="$2"
    getFile "${path_name}"
    for i in ${dir_list}; do
        file=$(basename "$i")
        backup "${target_dir}${file%.sh}"
        [[ ! "$i" =~ "init" ]] && lnif "${path_name}/${file}" "${target_dir}${file%.sh}"
        success "Link $file!"
    done

    success "Link done!"
}

initWorkDir "$HOME/.swp" \
    "$HOME/.backup" \
    "$HOME/.undo" \
    "$NVIM_PATH"

syncRepo "$REPO_PATH" "$REPO_URI"

lnif "${CONFIG_PATH}/init.vim" "${NVIM_PATH}/init.vim"

handler "${CONFIG_PATH}" "$HOME/."

installPlugins
