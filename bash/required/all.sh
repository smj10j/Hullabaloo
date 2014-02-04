#!/bin/bash


##########################################
############# Global Variables ###########
##########################################

export PATH=/usr/local/bin:/usr/local/sbin:$PATH






##########################################
################ Bootstrap ###############
##########################################

# Catches script errors and outputs them
source "$SCRIPT_BASE_DIR/required/traps.sh"

# Bash profile loading functions
source "$SCRIPT_BASE_DIR/required/profiles.sh"

# Logging functions
source "$SCRIPT_BASE_DIR/required/logging.sh"




##########################################
###### Load our required libraries #######
##########################################

# Allows function arguments to be passed by reference
_smj_devenv_load_profile 'required/upvars'

# Array convenience methods like push, pop, shift, and unshift
_smj_devenv_load_profile 'required/arrays'

# _smj_devenv_* functions used throughout
_smj_devenv_load_profile 'required/functions'

# Pretty printing
_smj_devenv_load_profile 'required/pretty'
