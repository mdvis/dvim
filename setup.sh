#!/usr/bin/env bash

# ------
# name: setup.sh
# author: Deve
# date: 2022-02-25
# ------

set -e
set -o pipefail

error() {
    msg "\033[31m[✘]\033[0m ${1}${2}"
    exit 1
}

hasCmd() {
    type "$1" >/dev/null 2>&1 || error "\"no $1\""
}

hasCmd npm
npm i -g jsonlint prettier stylelint stylelint-config-standard neovim

hasCmd pip3
pip3 install pynvim neovim jedi yapf isort flake8 pylint autopep8 vim-vint
