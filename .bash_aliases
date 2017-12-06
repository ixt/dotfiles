if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\ \D{%F %T}\$ '
else
    PS1='orange@\w \D{%T} \$ '
fi
unset color_prompt force_color_prompt
alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
alias shortdate='date -u +%Y-%m-%d-%H-%M-%S'
export TERM=xterm-256color
export EDITOR=vim
