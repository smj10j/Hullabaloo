#!/bin/bash

# Utilities for adding to the PATH variable
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:${PATH:+"$PATH"}"
    fi
}

pathsadd() {
    IF_ZSH "IFS=':' read -A array <<< '$1'" ELSE "IFS=':' read -a array <<< '$1'"
	for element in "${array[@]}"; do
		pathadd "$element"
	done
}

# Utilities for adding to the MANPATH variable
manpathadd() {
    if [ -d "$1" ] && [[ ":$MANPATH:" != *":$1:"* ]]; then
        MANPATH="$1:${MANPATH:+"$MANPATH"}"
    fi
}

manpathsadd() {
    IF_ZSH "IFS=':' read -A array <<< '$1'" ELSE "IFS=':' read -a array <<< '$1'"
	for element in "${array[@]}"; do
		manpathadd "$element"
	done
}

# Enhance the path
pathsadd $PATH_ADDITION

