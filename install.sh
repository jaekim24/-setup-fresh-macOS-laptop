#!/bin/bash

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# only shows active apps on  
defaults write com.apple.dock static-only -bool TRUE; killall Dock


# brew install --cask --appdir "/Applications"
# non app store applications to application folder
non_app_store_applications_to_app_folder=(
	hammerspoon 		# powerful macOS automation tool
	visual-studio-code 	# text editor
	brave-browser@beta 	# browser
	kicad			# design schematics and pcb boards
	menumeters		# displays computer stats (ram usage, cpu temp)
	audacity		# audio editior
)


# brew install 
# non app store application to not application folder
non_app_store_applications=(
	arduino-cli		# command line interface for arduino ide
	python
	bclm			# battery control level managment
	mas			# cli for mac app store
	notion			# note taking app
	ffmpeg			# everything about editing video, audio,and images
	parallel		# bash parallel processing
	qt			# need for labelImg
	libxml2  		# need for labelImg				
	ultralytics		# yolov8 model
)

# To resolve issues related to Python environments being externally managed, because of homebrew installed python version, execute below commmand.
rm ./Frameworks/Python.framework/Versions/3.12/lib/python3.12/EXTERNALLY-MANAGED


softwareupdate --install-rosetta # need this to run ardunio-cli on apple silicon 
brew install --cask --appdir "/Applications" ${non_app_store_applications_to_app_folder[@]}
brew install ${non_app_store_applications[@]}


# app store applications
app_store_applications=(
	869223134 	# kakao
	1484801884	# pomodoro timer
	1044549675	# media player

)

# mas can only download app store applications you've downloaded before with your icloud account
mas install ${app_store_applications[@]} # installing mac app store applications

pip3_libraries=(
	trimmer		# downloads and trimms youtube url to mp3 
)

pip3 install ${pip3_libraries[@]}


# shell env
cp init.lua ~/.hammerspoon/init.lua
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


