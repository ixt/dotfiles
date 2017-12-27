if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\ \D{%F %T}\$ '
else
    PS1='🔸@ \[\033[01;34m\]\W\[\033[00m\] \D{%T}\$ '
fi
alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
alias shortdate='date -u +%Y-%m-%d-%H-%M-%S'
export EDITOR=vim
