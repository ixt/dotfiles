if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\ \D{%F %T}\$ '
else
    PS1='🔸@ \[\033[01;34m\]\W\[\033[00m\] \D{%T}\$ '
fi
alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
export EDITOR=vim
export GOPATH=~/.go
export PATH=$PATH:~/.go/bin

figtimer (){
    for i in $(seq 0 $1 | tac); do sleep 1s; clear; figlet -ct "$i"; done && echo -en "\007"
}
