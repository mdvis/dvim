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

#
#
############################# SETUP FUNCTIONS
#
#do_backup() {
#    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
#        msg "Attempting to back up your original vim configuration."
#        today=`date +%Y%m%d_%s`
#        for i in "$1" "$2" "$3"; do
#            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
#        done
#        ret="$?"
#        success "Your original vim configuration has been backed up."
#        debug
#   fi
#}
#
#sync_repo() {
#    local repo_path="$1"
#    local repo_uri="$2"
#    local repo_branch="$3"
#    local repo_name="$4"
#
#    msg "Trying to update $repo_name"
#
#    if [ ! -e "$repo_path" ]; then
#        mkdir -p "$repo_path"
#        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
#        ret="$?"
#        success "Successfully cloned $repo_name."
#    else
#        cd "$repo_path" && git pull origin "$repo_branch"
#        ret="$?"
#        success "Successfully updated $repo_name"
#    fi
#
#    debug
#}
#
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
#setup_fork_mode() {
#    local source_path="$2"
#    local target_path="$3"
#
#    if [ "$1" -eq '1' ]; then
#        touch "$target_path/.vimrc.fork"
#        touch "$target_path/.vimrc.bundles.fork"
#        touch "$target_path/.vimrc.before.fork"
#
#        lnif "$source_path/.vimrc.fork"         "$target_path/.vimrc.fork"
#        lnif "$source_path/.vimrc.bundles.fork" "$target_path/.vimrc.bundles.fork"
#        lnif "$source_path/.vimrc.before.fork"  "$target_path/.vimrc.before.fork"
#
#        ret="$?"
#        success "Created fork maintainer files."
#        debug
#    fi
#}
#
#setup_vundle() {
#    local system_shell="$SHELL"
#    export SHELL='/bin/sh'
#
#    vim \
#        -u "$1" \
#        "+set nomore" \
#        "+BundleInstall!" \
#        "+BundleClean" \
#        "+qall"
#
#    local system_shell="$SHELL"
#    export SHELL='/bin/sh'
#    export SHELL="$system_shell"
#
#    success "Now updating/installing plugins using Vundle"
#    debug
#}
#
############################# MAIN()
#variable_set "$HOME"
#program_must_exist "vim"
#program_must_exist "git"
#
#do_backup       "$HOME/.vim" \
#                "$HOME/.vimrc" \
#                "$HOME/.gvimrc"
#
#sync_repo       "$APP_PATH" \
#                "$REPO_URI" \
#                "$REPO_BRANCH" \
#                "$app_name"
#
#create_symlinks "$APP_PATH" \
#                "$HOME"
#
#setup_fork_mode "$fork_maintainer" \
#                "$APP_PATH" \
#                "$HOME"
#
#sync_repo       "$HOME/.vim/bundle/vundle" \
#                "$VUNDLE_URI" \
#                "master" \
#                "vundle"
#
#setup_vundle    "$APP_PATH/.vimrc.bundles.default"
#
#msg             "\nThanks for installing $app_name."
#msg             "© `date +%Y` http://vim.spf13.com/"
