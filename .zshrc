# Path to your oh-my-zsh installation.
system="$(uname -s)"
if [[ $system = 'Darwin' ]];then
    export ZSH=/Users/deve/.oh-my-zsh
else
    export ZSH=/home/deve/.oh-my-zsh
fi

ZSH_THEME="robbyrussell"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=26

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew gulp man npm osx tmux python sudo yarn)

source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
export LANG=en_US.UTF-8

alias c='clear'
alias rm="rm -i"
alias mv="mv -i"
alias l='ls -F'
alias ll='ls -lF'
alias la='ls -AF'
alias lla='ls -lAF'
alias lo="ls -lF | awk '{if (NR > 1) {print \$9}}'"
alias code="cd /home/deve/Desktop/Comp/"
alias glog='git log --date=format:'%Y-%m-%d-%H:%M' --pretty="%C(bold yellow)%h %C(red)%ad %C(blue)%cn %C(reset)%s"'
alias -s {js,html,py,sh,css,scss,xml,vue}=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

export CDPATH=.:~:~/Desktop
