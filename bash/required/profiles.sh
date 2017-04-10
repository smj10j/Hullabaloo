#!/bin/bash

_HULLABALOO_BASH_PROFILE_FILES=()

# function _hullabaloo_append_profile {
# 	FUNCTION_NAME=${FUNCNAME[0]:-$funcstack[1]}
# 	if [ -z "$1" ]; then echo "Usage: ${FUNCTION_NAME} <file>"; return; fi
# 	array_push _HULLABALOO_BASH_PROFILE_FILES[@] "$1"
# }
#
# function _hullabaloo_prepend_profile {
# 	FUNCTION_NAME=${FUNCNAME[0]:-$funcstack[1]}
# 	if [ -z "$1" ]; then echo "Usage: ${FUNCTION_NAME} <file>"; return; fi
# 	array_shift _HULLABALOO_BASH_PROFILE_FILES[@] "$1"
# }

function _hullabaloo_load_profile {
	FUNCTION_NAME=${FUNCNAME[0]:-$funcstack[1]}
	if [ -z "$1" ]; then echo "Usage: ${FUNCTION_NAME} <file>"; return; fi
	PROFILE_PATH="$_HULLABALOO_INSTALL_DIR/bash/$1.sh"
	_hullabaloo_log "Loading '$PROFILE_PATH'"
	# shellcheck source=/dev/null
	source $PROFILE_PATH
}

function _hullabaloo_load_profiles {
	FUNCTION_NAME=${FUNCNAME[0]:-$funcstack[1]}
	if [ -z "${_HULLABALOO_BASH_PROFILE_FILES[*]}" ]; then echo "Usage: ${FUNCTION_NAME} <array of files>"; return; fi
	for profileFile in "${_HULLABALOO_BASH_PROFILE_FILES[@]}"; do
		_hullabaloo_load_profile "$profileFile"
	done
}
