export BASH_SILENCE_DEPRECATION_WARNING=1

# battery stat
function bat(){
	pmset -g batt
}


# clear terminal
function c(){
	clear "$@"
}

# find a file in all directory
function findf(){
	#find / -iname "$1" 2>/dev/null
	find / -type d -print0 2>/dev/null | parallel -0 -j+0 "find {} -maxdepth 1 -type f -iname \"$1\" 2>/dev/null"

}

# find a folder in all diretories
function findd(){
	find / -type d -iname "$1" 2>/dev/null
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

export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"


