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



##########################################
############ Script Globals ##############
##########################################

VERBOSE=${VERBOSE:-''}
SCRIPT_BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_BASE_DIR=`dirname $SCRIPT_BASE_DIR`



##########################################
##### Required by this installation ######
##########################################

# Loads all of our required libraries
source "$SCRIPT_BASE_DIR/required/all.sh"



##########################################
############## Configurable ##############
##########################################

# Variables used throughout the optional profiles
_smj_devenv_append_profile "user/variables"

# Any custom extensions can go here to keep things clean
_smj_devenv_append_profile "user/custom"



##########################################
############# Globally Useful ############
##########################################

# Adds PATH modification functions
_smj_devenv_append_profile "optional/path"

# Add functions that make working with files within the shell easier
_smj_devenv_append_profile "optional/file"

# Tools for making work within the shell easier (cd enhancements, bash completion, etc.)
_smj_devenv_append_profile "optional/shell"

# SSH enhancements and shortcuts
_smj_devenv_append_profile "optional/ssh"

# Git tools and aliases
_smj_devenv_append_profile "optional/git"



##########################################
########### Use-case dependent ###########
##########################################

# Nginx, MySQL, PHP-FPM, and other daemons
_smj_devenv_append_profile "optional/daemons"

# OSX-specific configurations
_smj_devenv_append_profile "optional/osx"



##########################################
############### Execution! ###############
##########################################

# Do any final maintenance tasks
_smj_devenv_append_profile 'required/cleanup'

# Load 'em in!
_smj_devenv_load_profiles





