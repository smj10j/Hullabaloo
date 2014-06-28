#!/bin/bash


# Enable Bash Completion
if [ $(uname) == 'Darwin' ]; then
	# Bash Completion
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
fi

# Ignore case when doing bash completion
bind "set completion-ignore-case"

# Store much more bash history (default is 500)
export HISTFILESIZE=10000

# Ignore duplicate lines
export HISTCONTROL=erasedups

# Auto-append the history on shell exit
shopt -s histappend

# Try and keep multi-line commands in good shape in the history
shopt -s lithist
shopt -s cmdhist

# Auto correct simple misspellings
shopt -s cdspell
shopt -s dirspell

# Complete hostname when typing
shopt -s hostcomplete

# Follow symlinks
ff() {
	LINK=$(readlink -f $(which $1))
	LINK_PWD=$(dirname $LINK)
	pushd $LINK_PWD
}

# Show the commands you use most (http://lifehacker.com/202712/review-your-most-oft-used-unix-commands)
_hullabaloo_history_ranked() {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
}



