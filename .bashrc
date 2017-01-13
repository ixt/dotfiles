# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='orange@\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
export TERM=xterm-256color

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

export GPG_TTY=$(tty)
alias gkill='pkill gpg-agent 2>/dev/null'
alias ssh='gkill; gpg-agent --enable-ssh-support --daemon ssh "$@"'
alias rsync='gkill; gpg-agent --enable-ssh-support --daemon rsync "$@"'
alias scp='gkill; gpg-agent --enable-ssh-support --daemon scp "$@"'
alias git='gkill; gpg-agent --enable-ssh-support --daemon git "$@"'

# Check for changes in verification repo
checkFor24HourPassing(){
    cd ~/Projects/I-am-awake-I-am-alive-I-am-orange
    local currentTimeStamp=$(git show | head -3 | tail -1 | sed -e 's/Date:   //g;s/+0000//g')
    local twentyFourHoursPast=$(date -d "$currentTimeStamp + 24 hours" +%s)
    local currentTime=$(date +%s)
    if [[ $currentTime -gt $twentyFourHoursPast ]]; then
        echo "Go post the verification you're still alive"
    fi
    cd
}
checkFor24HourPassing 2>/dev/null
