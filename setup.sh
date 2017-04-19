#!/usr/bin/env bash
# 2017-04-19 14:30:47
. torsocks on

# setting up pgp 
gpg --card-status
gpg --import ~amnesia/keys/orangeatff4500dotred.asc
gpg -d ~amnesia/payload.gpg | bash

# I am awake I am alive I am orange setup
mkdir ~amnesia/Projects/I-am-awake-I-am-alive-I-am-orange -p
cd ~amnesia/Projects/I-am-awake-I-am-alive-I-am-orange 
git init
git remote add origin git-mandarin:x/I-am-awake-I-am-alive-I-am-orange
git remote add github github:ixt/I-am-awake-I-am-alive-I-am-orange
for r in $(git remote); do git pull $r master; done
for r in $(git remote); do git push $r master; done
cd

echo ". ~/.bash_aliases" >> ~amnesia/.bashrc
. ~amnesia/.bash_aliases
