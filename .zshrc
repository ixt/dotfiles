export ZSH=/home/orange/.oh-my-zsh
ZSH_THEME="darkblood"
plugins=(git)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
source $ZSH/oh-my-zsh.sh

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias la='ls -A'
