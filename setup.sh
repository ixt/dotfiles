#!/usr/bin/env bash

. torsocks on
# Vundle
git submodule init && git submodule update
vim -c":PluginInstall"

# Git details
gpg --import publickey.asc
git config --global user.name "NfN Orange"
git config --global user.email "orange@ff4500.red"
git config --global user.signingkey "6B35D47864E747E3" 
git config --global commit.gpgsign true

# I am awake I am alive I am orange setup
mkdir ~/Projects
git clone git@github.com:ixt/I-am-awake-I-am-alive-I-am-orange ~/Projects/I-am-awake-I-am-alive-I-am-orange
sudo apt update
sudo apt install ruby gem ruby-dev ruby-twitter

