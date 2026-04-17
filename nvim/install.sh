#!/usr/bin/env bash

# ------
# name: install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

readonly REPO_NVIM_CONFIG_PATH="$REPO_PATH/nvim"

readonly APP_NVIM_CONFIG_PATH="$HOME/.config/nvim"

lnif "${REPO_NVIM_CONFIG_PATH}" "${APP_NVIM_CONFIG_PATH}"

installPlugins
