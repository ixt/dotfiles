#!/bin/bash

printf "This is a work in progress do not use\n"
exit 0
sudo apt install -y jq screen htop screenfetch make cmake       \
    vim vim-youcompleteme ycmd python3 python3-pip python3-dev  \
    git figlet caca-utils imagemagick ffmpeg ranger newsbeuter  \
    lynx w3m wget curl ruby ruby-gem ruby-dev

# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +qa

vam install youcompleteme

sudo pip install -y youtube-dl

sudo gem install jekyll
    
[[ $DISPLAY ]] && \
    sudo apt install -y i3 suckless-tools firefox firefox-esr   \
        seahorse gnome-disks rxvt-unicode vlc mpv 
