#!/bin/bash

_HULLABALOO_BASH_PROFILE_FILES=()

#function _hullabaloo_append_profile {
#	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
#	array_push _HULLABALOO_BASH_PROFILE_FILES[@] "$1"
#}

#function _hullabaloo_prepend_profile {
#	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
#	array_shift _HULLABALOO_BASH_PROFILE_FILES[@] "$1"
#}

function _hullabaloo_load_profile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	PROFILE_PATH="$_HULLABALOO_INSTALL_DIR/bash/$1.sh"
	_hullabaloo_log "Loading '$PROFILE_PATH'"
	source $PROFILE_PATH
}

function _hullabaloo_load_profiles {
	if [ -z "$_HULLABALOO_BASH_PROFILE_FILES" ]; then echo "Usage: $FUNCNAME <array of files>"; return; fi
	for profileFile in "${_HULLABALOO_BASH_PROFILE_FILES[@]}"; do
		_hullabaloo_load_profile $profileFile
	done
}
