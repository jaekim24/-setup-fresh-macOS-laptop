#!/bin/bash

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

# shell env
cp .bash_profile ~/.bash_profile
cp .vimrc ~/.vimrc

source ~/.bash_profile

# git 
brew install git 
ssh-keygen -t rsa -C "jaekim24@github"
print '\n\n'
cat ~/.ssh/id_rsa.pub
print '\n\n'
echo 'copy the key from ~/.ssh/id_rsa.pub onto ssh keys in the github settings'
read -n 1 -s -r -p "press any key once you have copied the key"

# applications

