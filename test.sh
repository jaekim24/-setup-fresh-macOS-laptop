
# non app store applications to application folder
non_app_store_applications_to_app_folder=(
	hammerspoon 		# powerful macOS automation tol
	visual-studio-code 	# text editor
	brave-browser@beta 	# browser
	kicad			# design schematics and pcb boards
	menumeters		# displays computer stats (ram usage, cpu temp)
)

# non app store application to not application folder
non_app_store_applications=(
	arduino-cli		# command line interface for arduino ide
	python
	bclm			# battery control level managment
	mas			# cli for mac app store
)


softwareupdate --install-rosetta # need this to run ardunio-cli on apple silicon 
brew install --cask --appdir "/Applications" ${non_app_store_applications_to_app_folder[@]}
brew install ${non_app_store_applications[@]}


# app store applications
app_store_applications=(
	869223134 # kakao
)

mas install ${app_store_applications[@]} # installing mac app store applications


