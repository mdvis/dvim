#!/usr/bin/env bash

# ------
# name: install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

readonly REPO_VIM_CONFIG_PATH="$REPO_PATH/vim"

readonly APP_VIM_CONFIG_PATH="$HOME/.vim"
readonly APP_VIM_CONFIG_FILE_PATH="$HOME/."

lnif "${REPO_VIM_CONFIG_PATH}" "${APP_VIM_CONFIG_PATH}"

handler "${APP_VIM_CONFIG_PATH}/config" "$HOME/."

installPlugins
