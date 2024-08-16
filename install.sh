#!/bin/bash

# shell env
cp .bash_profile ~/.bash_profile
cp .vimrc ~/.vimrc

source ~/.bash_profile

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# applications
brew install --cask --appdir="/Applications" hammerspoon
cp init.lua ~/.hammerspoon/init.lua

brew install --cask --appdir="/Applications" visual-studio-code
brew install --cask --appdir="/Applications" brave-browser@beta 
brew install --cask --appdir="/Applications" menumeters
brew install --cask --appdir="/Applications" arduino-ide

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES

# Screenshot location idk if this works
mkdir ~/Downloads/screenshots

defaults write com.apple.screencapture location ~/Downloads/screenshots
killall SystemUIServer


# git 
brew install git 
ssh-keygen -t rsa -C "jaekim24@github"
print '\n\n'
cat ~/.ssh/id_rsa.pub
print '\n\n'
echo 'copy the key from ~/.ssh/id_rsa.pub onto ssh keys in the github settings'
read -n 1 -s -r -p "press any key once you have copied the key"


