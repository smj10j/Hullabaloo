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

IS_ZSH=$([[ -z $BASH ]] && echo 'yes')
# Usage: IF_ZSH 'some zsh stuff' ELSE 'some non-zsh stuff'
function IF_ZSH() {
    if [[ -n "$IS_ZSH" ]]; then
    	eval $1    	
    elif [[ -n "$3" ]]; then
    	eval $3
    fi
}


##########################################
##### Required by this installation ######
##########################################

# Loads all of our required libraries
source "$_HULLABALOO_INSTALL_DIR/bash/required/all.sh"



##########################################
############## Configurable ##############
##########################################

# Variables used throughout the optional profiles
_hullabaloo_load_profile "user/variables"

# Any custom extensions can go here to keep things clean
_hullabaloo_load_profile "user/custom"



##########################################
############# Globally Useful ############
##########################################

# Adds PATH modification functions
_hullabaloo_load_profile "optional/path"

# Add functions that make working with files within the shell easier
_hullabaloo_load_profile "optional/file"

# Tools for making work within the shell easier (cd enhancements, bash completion, etc.)
_hullabaloo_load_profile "optional/shell"

# SSH enhancements and shortcuts
_hullabaloo_load_profile "optional/ssh"

# Git tools and aliases
_hullabaloo_load_profile "optional/git"



##########################################
########### Use-case dependent ###########
##########################################

# OSX-specific configurations
_hullabaloo_load_profile "optional/osx"




##########################################
################# Cleanup ################
##########################################

# Do any final maintenance tasks
#_hullabaloo_load_profile 'required/cleanup'



##########################################
############### Execution! ###############
##########################################

# Load in our optional and user profiles
# _hullabaloo_load_profiles



