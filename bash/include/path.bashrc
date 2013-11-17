#!/bin/bash

# Utilities for adding to the PATH variable
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathsadd() {
	IFS=':' read -a array <<< "$1"
	for element in "${array[@]}"; do
		pathadd "$element"
	done
}

# Enhance the path (mostly for MacPorts)
pathsadd "/opt/local/bin:/opt/local/sbin:/opt/local/libexec/perl5.12/sitebin"
