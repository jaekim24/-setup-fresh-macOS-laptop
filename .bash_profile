


export BASH_SILENCE_DEPRECATION_WARNING = 1

# open curr dir in finder
f(){
	open -a Finder ./ "$@"
}

# git add, commit, push one liner
getlazy(){
	git add .
	git commit -a -m "$1"
	git push 
}

# git add, and commit one liner
getsave(){
	git add . 
	git commit -m "$1"
}

