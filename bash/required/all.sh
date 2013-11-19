#!/bin/bash

##########################################
################ Bootstrap ###############
##########################################

source "$SCRIPT_BASE_DIR/required/profiles.sh"

##########################################
###### Load our required libraries #######
##########################################

# Array convenience methods like push, pop, shift, and unshift
_smj_devenv_load_profile 'required/arrays'

# Catches script errors and outputs them
_smj_devenv_load_profile 'required/traps'

# Allows function arguments to be passed by reference
_smj_devenv_load_profile 'required/upvars'

# _smj_devenv_* functions used throughout
_smj_devenv_load_profile 'required/functions'

# Pretty printing
_smj_devenv_load_profile 'required/pretty'
