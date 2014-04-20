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
HISTFILESIZE=10000

# Show the commands you use most (http://lifehacker.com/202712/review-your-most-oft-used-unix-commands)
_hullabaloo_history_ranked() {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
}

#TODO: add push/pop for CD



