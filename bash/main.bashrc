#!/bin/bash

##########################################
############# Parse Options ##############
##########################################

while getopts ":v" o; do
	case "${o}" in
		v) VERBOSE='-v'; ;;
		*) ;;
	esac
done
shift $(($OPTIND - 1))

VERBOSE=${VERBOSE:-''}



##########################################
##### Required by this installation ######
##########################################

# Catches script errors and outputs them
_smj_devenv_loadprofile 'required/traps'

# Array convenience methods like push, pop, shift, and unshift
_smj_devenv_loadprofile 'required/arrays'

# _smj_devenv_* functions used throughout
_smj_devenv_loadprofile 'required/functions'

# Pretty printing
_smj_devenv_loadprofile 'required/pretty'



##########################################
############## Configurable ##############
##########################################

# Variables used throughout the optional profiles
_smj_devenv_appendprofile "user/variables"

# Any custom extensions can go here to keep things clean
_smj_devenv_appendprofile "user/custom"



##########################################
############# Globally Useful ############
##########################################

# Adds PATH modification functions
_smj_devenv_appendprofile "optional/path"

# Add functions that make working with files within the shell easier
_smj_devenv_appendprofile "optional/file"

# Tools for making work within the shell easier (cd enhancements, bash completion, etc.)
_smj_devenv_appendprofile "optional/shell"

# SSH enhancements and shortcuts
_smj_devenv_appendprofile "optional/ssh"

# Git tools and aliases
_smj_devenv_appendprofile "optional/git"



##########################################
########### Use-case dependent ###########
##########################################

# Nginx, MySQL, PHP-FPM, and other daemons
_smj_devenv_appendprofile "optional/daemons"

# OSX-specific configurations
_smj_devenv_appendprofile "optional/osx"



##########################################
############### Execution! ###############
##########################################

# Debug 
_smj_devenv_log "DevEnvironment tools will be loaded from $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load 'em in!
_smj_devenv_loadprofiles
