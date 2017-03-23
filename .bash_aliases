if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='orange@\w\$ '
fi
unset color_prompt force_color_prompt
alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
export TERM=xterm-256color
export EDITOR=vim
export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh

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
