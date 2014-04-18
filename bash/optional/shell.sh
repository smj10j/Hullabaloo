#!/bin/bash


# Enable Bash Completion
if [ `uname` == 'Darwin' ]; then
	# Bash Completion
	if [ -f `brew --prefix`/etc/bash_completion ]; then
		. `brew --prefix`/etc/bash_completion
	fi
fi

# Ignore case when doing bash completion
bind "set completion-ignore-case"

# Store much more bash history (default is 500)
HISTFILESIZE=5000


#TODO: add push/pop for CD



