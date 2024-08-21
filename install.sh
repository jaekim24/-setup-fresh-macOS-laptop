#!/bin/bash

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# applications
brew install --cask --appdir="/Applications" hammerspoon
cp init.lua ~/.hammerspoon/init.lua

brew install --cask --appdir="/Applications" visual-studio-code
brew install --cask --appdir="/Applications" brave-browser@beta 
brew install --cask --appdir="/Applications" menumeters
brew install --cask --appdir="/Applications" kicad
brew install python
softwareupdate --install-rosetta  # need this to run ardunio-cli on apple silicon

brew install arduino-cli


# shell env
cp .bash_profile ~/.bash_profile
cp .vimrc ~/.vimrc
cp settings.json ~/Library/Application\ Support/Code/User/settings.json
source ~/.bash_profile


# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES

# enable repeating key while holding
defaults write -g ApplePressAndHoldEnabled -bool false

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


