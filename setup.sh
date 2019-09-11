#!/bin/bash

printf "This is a work in progress do not use\n"
exit 0

printf "[*] Typical tools \n"
sudo apt install -y jq screen htop screenfetch make cmake tor   \
    vim vim-youcompleteme ycmd python3 python3-pip python3-dev  \
    git figlet caca-utils imagemagick ffmpeg ranger newsbeuter  \
    lynx w3m wget curl ruby gem ruby-dev tree python3-venv nmap \
    torsocks

printf "[*] Vim-plug \n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +qa

printf "[*] Vim-YouCompleteMe \n"
vam install youcompleteme

printf "[*] Django Autocompletion \n"
wget -O ~/.django_bash_completion.sh \
    https://raw.github.com/django/django/master/extras/django_bash_completion

printf "[*] Youtube-dl \n"
yes | sudo pip3 install youtube-dl

printf "[*] Jekyll \n"
yes | sudo gem install jekyll
    
[[ $DISPLAY ]] && \
    printf "[*] GUI Tools \n" && \
    sudo apt install -y i3 suckless-tools firefox-esr       \
        seahorse gnome-disks rxvt-unicode vlc mpv scribus inkscape  \
        gimp surf kdeconnect keepassxc
