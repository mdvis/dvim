#!/usr/bin/env bash

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.vim"
[ -z "$REPO_PATH" ] && REPO_PATH="$HOME/.Dvim"
[ -z "$REPO_URI" ] && REPO_URI="https://github.com/manjuist/Dvim.git"
[ -z "$VUNDLE_PATH" ] && VUNDLE_PATH="$HOME/.vim/bundle/Vundle.vim"
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/VundleVim/Vundle.vim.git"
[ -z "$FONT_PATH" ] && FONT_PATH="$HOME/.font"

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
        mkdir -p "repo_path"
        git clone "$repo_uri" "$repo_path"
        ret="$?"
    else
        cd "$repo_path" && git pull origin master
        ret="$?"
    fi

    debug
}

install_plugins() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'

    vim "+BundleInstall!" "+BundleClean" "+qall"

    export SHELL="$system_shell"
}

copy_font() {
    local source_font_path="$1"
    local target_font_path="$2"

    cp "$source_font_path" "$target_path"
}


lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

install_font(){
    local font_path="$1"
    cd font_path && mkfontscale && mkfontdir && fc-cache
}

sync_repo "$REPO_PATH" "$REPO_URI"
sync_repo "$VUNDLE_PATH" "$VUNDLE_URI"
copy_font "$REPO_PATH/*.ttf" "$FONT_PATH"
install_plugins

#create_symlinks() {
#    local source_path="$1"
#    local target_path="$2"
#
#    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
#    lnif "$source_path/.vimrc.bundles" "$target_path/.vimrc.bundles"
#    lnif "$source_path/.vimrc.before"  "$target_path/.vimrc.before"
#    lnif "$source_path/.vim"           "$target_path/.vim"
#
#    if program_exists "nvim"; then
#        lnif "$source_path/.vim"       "$target_path/.config/nvim"
#        lnif "$source_path/.vimrc"     "$target_path/.config/nvim/init.vim"
#    fi
#
#    touch  "$target_path/.vimrc.local"
#
#    ret="$?"
#    success "Setting up vim symlinks."
#    debug
#}
#
#create_symlinks "$APP_PATH" \
#                "$HOME"
