#!/usr/bin/env bash
# 2017-02-12 00:50:30
. torsocks on

# setting up pgp 
gpg --card-status
gpg --import ~/keys/orangeatff4500dotred.asc
cd keys
gpg -d payload.gpg > payload.tar
tar -xf payload.tar 
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
for r in $(git remote); do git pull $r master; done
for r in $(git remote); do git push $r master; done
cd

# Other
gpg -d ~/payload.gpg > ~/payload.sh
chmod +x ~/payload.sh
bash ~/payload.sh
rm ~/payload.sh
