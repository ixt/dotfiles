#!/usr/bin/env bash
git submodule init && git submodule update
vim -c":PluginInstall"

git config --global user.name "NfN Orange"
git config --global user.email "orange@ff4500.red"
git config --global user.signingkey "6B35D47864E747E3" 
git config --global commit.gpgsign true

mkdir ~/Projects
git clone http://github.com/ixt/I-am-awake-I-am-alive-I-am-orange ~/Projects/I-am-awake-I-am-alive-I-am-orange

