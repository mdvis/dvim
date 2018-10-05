# Path to your oh-my-zsh installation.
#export ZSH=/home/deve/.oh-my-zsh
export ZSH=/Users/deve/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=26

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git brew gulp man npm osx tmux python sudo yarn)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias -s {js,html,py,sh,css,scss,xml,vue}=vim

alias c='clear'
alias rm="rm -i"
alias mv="mv -i"
alias l='ls -F'
alias ll='ls -lF'
alias la='ls -AF'
alias lla='ls -lAF'
alias lo="ls -lF | awk '{if (NR > 1) {print \$9}}'"
alias glog='git log --date=format:'%Y-%m-%d-%H:%M' --pretty="%C(bold yellow)%h %C(red)%ad %C(blue)%cn %C(reset)%s"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

export CDPATH=.:~:~/Desktop
