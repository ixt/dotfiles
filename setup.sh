#!/usr/bin/env bash
# 2017-12-27 20:56:29

# setting up pgp 
gpg --card-status
gpg --import ~/Keys/orangeatff4500dotred.asc

echo ". ~/.bash_aliases" >> ~/.bashrc
. ~/.bash_aliases
