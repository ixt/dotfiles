#!/usr/bin/env bash

. torsocks on
# Vundle
git submodule init && git submodule update
vim -c":PluginInstall"

# setting up pgp 
gpg --card-status
gpg --import ~/keys/orangeatff4500dotred.asc
cd keys
gpg -d ~/payload.gpg > ~/payload.tar
tar -xf ~/payload.tar 
gpg --import *.asc
rm *
git checkout -- "*"
cd ..
echo ". ~/.bash_aliases" >> ~/.bashrc
. ~/.bash_aliases

# Git details
git config --global user.name "NfN Orange"
git config --global user.email "orange@ff4500.red"
git config --global user.signingkey "6B35D47864E747E3" 
git config --global commit.gpgsign true

# I am awake I am alive I am orange setup
mkdir ~/Projects/I-am-awake-I-am-alive-I-am-orange -p
cd ~/Projects/I-am-awake-I-am-alive-I-am-orange 
git init
git remote add origin git@gitmousemobotn64.onion:x/I-am-awake-I-am-alive-I-am-orange
git remote add github git@github.com:ixt/I-am-awake-I-am-alive-I-am-orange
git pull origin master
git pull github master

# Other stuff
gpg -d ~/payload.gpg > ~/payload.sh
bash ~/payload.sh
echo " " > ~/payload.sh
