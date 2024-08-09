export BASH_SILENCE_DEPRECATION_WARNING=1

# battery stat
function bat(){
	pmset -g batt
}


# clear terminal
function c(){
	clear "$@"
}


# open curr dir in finder
function f(){
	open -a Finder ./ "$@"
}

# git add, commit, push one liner
function gitlazy(){
	git add .
	git commit -a -m "$1"
	git push 
}

# git add, and commit one liner
function gitsave(){
	git add . 
	git commit -m "$1"
}

export PATH=/opt/homebrew/bin:$PATH'
