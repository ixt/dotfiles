#!/usr/bin/env bash
# 2017-05-21 21:57:19
. torsocks on

# setting up pgp 
gpg --card-status
gpg --import ~/keys/orangeatff4500dotred.asc
gpg -d ~/payload.gpg | bash

# I am awake I am alive I am orange setup
mkdir ~/Projects/I-am-awake-I-am-alive-I-am-orange -p
cd ~/Projects/I-am-awake-I-am-alive-I-am-orange 
git init
git remote add origin git-mandarin:x/I-am-awake-I-am-alive-I-am-orange
git remote add github github:ixt/I-am-awake-I-am-alive-I-am-orange
for r in $(git remote); do git pull $r master; done
for r in $(git remote); do git push $r master; done
cd

echo ". ~/.bash_aliases" >> ~/.bashrc
. ~/.bash_aliases
