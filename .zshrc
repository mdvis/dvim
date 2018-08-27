# Path to your oh-my-zsh installation.
export ZSH=/home/deve/.oh-my-zsh

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
alias l='ls -F --color=auto'
alias ll='ls -lF --color=auto'
alias lo="ls -lF --color=auto | awk '{print $9}'"
alias la='ls -AF --color=auto'
alias lla='ls -lAF --color=auto'
alias code="cd /home/deve/Desktop/Comp/"
alias glog='git log --date=format:'%Y-%m-%d-%H:%M' --pretty="%C(bold yellow)%h %C(red)%ad %C(blue)%cn %C(reset)%s"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.iterm2_shell_integration.zsh

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

export CDPATH=.:~:~/Desktop
