#!/bin/bash

# shell env
rm ~/.bash_profile
rm ~/.vimrc

touch ~/.bash_profile
touch ~/.vimrc

cp .bash_profile ~/.bash_profile
cp .vimrc ~/.vimrc

source ~/.bash_profile


# applications

