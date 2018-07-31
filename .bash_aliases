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

get_docker(){
    # First we try detect the archtecture to add the right repo
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
    echo "docker-ce" >> ~/.packages
}

build_ddk(){
    # Is docker installed? if not then install it
    if ! $(grep -q "docker-ce" ~/.packages); then
        get_docker
    fi

    mkdir -p ~/Projects/ddk/ 
    pushd ~/Projects/ddk
        # Just git setup
        git init
        git remote add origin http://github.com/ixt/DroidDestructionKit
        git pull origin master

        # Build
        sudo docker build -t ddk . 
    popd
    echo "ddk" >> ~/.packages
}

run_ddk(){
    if ! $(grep -q "ddk" ~/.packages); then
        build_ddk
    fi
    docker run --rm \
        --name ddk \
        -p 8080:8080 \
        -p 8000:8000 \
        -p 7000:7000 \
        ddk
}

import_ssh_key(){
    mkdir -p ~/.ssh
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpFfukcwGwd7S2GC4/zwJzDF3KEFhkXzIgb3uFNfEaKthowUD6tZjIC0frmJTWmvIR9k2P6aQP05xR8o6k2DNEEyXl33lEoma7PVEP+Rl4CvpqDrFyijOAx144pkA/WFAJfZUi6Cfm19CgtLasijCnfItGVLvOCwHcxRDVj+W3hbAlAF/cdJ+9Oo1C+ENvmi3fCdBlsTIg1gz9vliKplsHP5PSQ6xdnQShKfj83nM693yGkukCQIbLdoJNiBaWv3eaSnM9Ol+6oHTYTYhoprZrWArSqQHt+p18b790eRsVBaVpOqwuAztQoxUnc0dy2dpvVrrKuw7haZ4IF10m12Y2lwh6un/xRW86P1Iit1YY1W30AJ/X++xUCowbJJhSXwQk8Jlf9FimF1PuGWUeSMS1A/AZjqr88prmjPGcGuNPHAY/9viSYfK3pszeyqHgBrlp9iOaIJyQuE4EEDOhKSYNEdBTu9RCEbXeQpkxs/69pR96+syj4+h51mAjNGaSg7Wat7oXEesb2vmVAkFVjE6MP20MFaf8wS+28BivM/2QXbwFqSUT/Iy5wfBEYgOOvoc+pJJg6Wjzj4fxYepYdVIFcWYFaC4+SQ26jcWymE2L36TNesI13XTID+mfcIXqOg3YHBSqrTCj/2KXIe25uFxos5DxfUQEWssGOnTK+lw7mw== " >> .ssh/authorized_keys
    echo "ssh-key-added" >> ~/.packages
}

turn_on_ssh(){
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
}
