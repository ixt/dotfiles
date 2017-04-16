#!/usr/bin/env bash
# 2017-04-16 14:20:06
. torsocks on

# setting up pgp 
gpg --card-status
gpg --import ~amnesia/keys/orangeatff4500dotred.asc

echo ". ~/.bash_aliases" >> ~amnesia/.bashrc
. ~amnesia/.bash_aliases

# I am awake I am alive I am orange setup
mkdir ~amnesia/Projects/I-am-awake-I-am-alive-I-am-orange -p
cd ~amnesia/Projects/I-am-awake-I-am-alive-I-am-orange 
git init
git remote add origin git@gitmousemobotn64.onion:x/I-am-awake-I-am-alive-I-am-orange
git remote add github git@github.com:ixt/I-am-awake-I-am-alive-I-am-orange
for r in $(git remote); do git pull $r master; done
for r in $(git remote); do git push $r master; done
cd

# Other
gpg -d ~amnesia/payload.gpg > ~amnesia/payload.sh
chmod +x ~amnesia/payload.sh
bash ~amnesia/payload.sh
rm ~amnesia/payload.sh
