#!/bin/bash

# Convenient directory navigation
alias eba='cd ~/Code/Ebates/'
alias exo='cd ~/Code/Exosphere/'
alias smj='cd ~/Code/smj10j/'

# Octal permissions ls
function lso {
	ls -lA $1 | awk '{print $9}' | grep -v "^$" | xargs -n 1 -I FILE stat -f '%Sp %p %N' $1'FILE' | rev | sed -E 's/^([^[:space:]]+)[[:space:]]([[:digit:]]{4})[^[:space:]]*[[:space:]]([^[:space:]]+)/\1 \2 \3/' | rev
}

# Convenient editing
function edit {
	echo "Opening $1..."
    if [ ! -e $1 ]; then 
        touch $1
    fi
    open -a BBEdit $1
}
