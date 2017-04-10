#!/bin/bash


##########################################
############# Global Variables ###########
##########################################





##########################################
############## Other Cleanup #############
##########################################

# Pretty-up the PATH
if [ -x /usr/libexec/path_helper ]; then
    export MANPATH
    export PATH
    eval "$(/usr/libexec/path_helper -s)"
fi




##########################################
################ Bootstrap ###############
##########################################

# Catches script errors and outputs them
# shellcheck source=/dev/null
source "$_HULLABALOO_INSTALL_DIR/bash/required/traps.sh"

# Bash profile loading functions
# shellcheck source=/dev/null
source "$_HULLABALOO_INSTALL_DIR/bash/required/profiles.sh"

# Logging functions
# shellcheck source=/dev/null
source "$_HULLABALOO_INSTALL_DIR/bash/required/logging.sh"




##########################################
###### Load our required libraries #######
##########################################

# Allows function arguments to be passed by reference
# _hullabaloo_load_profile 'required/upvars'

# Array convenience methods like push, pop, shift, and unshift
_hullabaloo_load_profile 'required/arrays'

# _hullabaloo_* functions used throughout
_hullabaloo_load_profile 'required/functions'

# Pretty printing
_hullabaloo_load_profile 'required/pretty'
