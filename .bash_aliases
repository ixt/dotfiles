if [ "$color_prompt" = yes ]; then
    PS1='orange@\[\033[01;34m\]\w\[\033[00m\]\ \D{%F %T}\$ '
else
    PS1='🔸@ \[\033[01;34m\]\W\[\033[00m\] \D{%T}\$ '
fi

alias nicedate='date -u +%Y-%m-%d\ %H-%M-%S'
alias hugos='hugo server --renderToDisk -p 4000'
export EDITOR=vim
export GOPATH=~/.go
export PATH=$PATH:~/.go/bin:/snap/bin:~/.local/bin

# Set chromeOS vim runtime
[[ "$USER" == "chronos" ]] && export VIMRUNTIME="/usr/local/share/vim/vim81/"

# GPG SSH Agent setup
if $(grep -q "gpg-connect-agent" ~/.packages); then
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# Move back to present working dir if bashrc changes it for screen
[[ "$TERM" == "screen" ]] && cd - >/dev/null

figtimer (){
    for i in $(seq 0 $1 | tac); do sleep 1s; clear; figlet -ct "$i"; done && echo -en "\007"
}

enable_gpgssh(){
    cat > ~/.gnupg/gpg-agent.conf <<EOF
enable-ssh-support
pinentry-program /usr/bin/pinentry-curses
default-cache-ttl 60
max-cache-ttl 120
EOF
echo "gpg-connect-agent" >> ~/.packages
}

get_docker(){
    # First we try detect the archtecture to add the right repo
    CURRENTUSER=$USER
    UNAMEMACHINE=$(uname -m) 
    case $UNAMEMACHINE in 
        aarch64)
            arch="arm64"
            ;;
        amd64)
            arch="amd64"
            ;;
        *)
            arch="amd64"
    esac
    sudo apt update
    # Grab some needed stuff from apt
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common
    # Add the docker siging key
    curl -fsSL https://download.docker.com/linux/debian/gpg \
        | sudo apt-key add -
    # Add the repository 
    sudo add-apt-repository \
           "deb [arch=$arch] https://download.docker.com/linux/debian \
              $(lsb_release -cs) \
                 stable"
    # Update & Install 
    sudo apt update 
    sudo apt install -y \
        docker-ce 
    # Add to the packages file to stop the script installing more in
    # other scripts 
    # Add user to docker group
    sudo usermod -a -G $CURRENTUSER
    echo "docker-ce" >> ~/.packages
}

import_ssh_key(){
    mkdir -p ~/.ssh
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpFfukcwGwd7S2GC4/zwJzDF3KEFhkXzIgb3uFNfEaKthowUD6tZjIC0frmJTWmvIR9k2P6aQP05xR8o6k2DNEEyXl33lEoma7PVEP+Rl4CvpqDrFyijOAx144pkA/WFAJfZUi6Cfm19CgtLasijCnfItGVLvOCwHcxRDVj+W3hbAlAF/cdJ+9Oo1C+ENvmi3fCdBlsTIg1gz9vliKplsHP5PSQ6xdnQShKfj83nM693yGkukCQIbLdoJNiBaWv3eaSnM9Ol+6oHTYTYhoprZrWArSqQHt+p18b790eRsVBaVpOqwuAztQoxUnc0dy2dpvVrrKuw7haZ4IF10m12Y2lwh6un/xRW86P1Iit1YY1W30AJ/X++xUCowbJJhSXwQk8Jlf9FimF1PuGWUeSMS1A/AZjqr88prmjPGcGuNPHAY/9viSYfK3pszeyqHgBrlp9iOaIJyQuE4EEDOhKSYNEdBTu9RCEbXeQpkxs/69pR96+syj4+h51mAjNGaSg7Wat7oXEesb2vmVAkFVjE6MP20MFaf8wS+28BivM/2QXbwFqSUT/Iy5wfBEYgOOvoc+pJJg6Wjzj4fxYepYdVIFcWYFaC4+SQ26jcWymE2L36TNesI13XTID+mfcIXqOg3YHBSqrTCj/2KXIe25uFxos5DxfUQEWssGOnTK+lw7mw== " >> ~/.ssh/authorized_keys
    echo "ssh-key-added" >> ~/.packages
}

enable_ssh(){
    sudo tee -a /etc/ssh/sshd_config > /dev/null <<EOF
Port 22
HostKey /etc/ssh/ssh_host_ed25519_key
PasswordAuthentication no
EOF
    sudo rm /etc/ssh/sshd_not_to_be_run 
    sudo systemctl enable ssh
    sudo systemctl start ssh
    if ! $(grep -q "ssh-key-added" ~/.packages); then
        import_ssh_key
    fi
    ip addr | grep "inet"
}

get_status(){
    cat ~/.packages
    ip addr | grep inet
}

get_jekyll(){
    sudo apt install ruby-dev ruby build-essential -y
    sudo gem install jekyll jekyll-redirect-from
}

get_notify(){
    pushd ~
    curl "https://chromium.googlesource.com/apps/libapps/+/refs/heads/master/hterm/etc/hterm-notify.sh?format=TEXT" \
        | base64 -d \
        > hterm-notify.sh
    chmod +x ./hterm-notify.sh
    sudo mv hterm-notify.sh /usr/local/bin/
    popd
}

setup_showfile(){
    pushd ~
    curl "https://chromium.googlesource.com/apps/libapps/+/refs/heads/master/hterm/etc/hterm-show-file.sh?format=TEXT" \
        | base64 -d \
        > hterm-show-file.sh
    chmod +x ./hterm-show-file.sh
    sudo mv hterm-show-file.sh /usr/local/bin/
    popd
}

setup_currentProjects(){
    mkdir ~/Projects >/dev/null
    pushd ~/Projects >/dev/null
        while read project; do
            git clone git@github.com:$project
        done < ~/.currentProjects
    popd
}

# Incorporate this function into your .bash_profile (.bashrc, .zshrc, or whatever you use...)
# Run `mov2frames name-of-mov.mov` to extract frames from the movie file
# Run `mov2frames name-of-mov.mov 300` to extract frames from the movie file at a maximum width of 300 pixels
# Frames will be exported into a `frames/` folder
# NOTE: if the frames folder exists and contains files that match the filename `frame_%03d.png`, no frames will be generated
mov2frames() {
    if [ ! -z "$2" ]
    then
      size=$2
    else
      size=-1
    fi

    tmp_dir="./frames"
    mkdir $tmp_dir

    echo "\033[33m Extract frames $1 ($2px wide)"
    echo "\033[32m ## Extracting frames..."

    # Assumes video with 30 fps
    ffmpeg -i $1 -vf scale=$size:-1 -r 30 $tmp_dir/frame_%03d.png
}
