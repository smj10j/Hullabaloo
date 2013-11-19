#!/bin/bash

_SMJ_DEVENV_BASH_PROFILE_FILES=()

function _smj_devenv_append_profile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	array_push _SMJ_DEVENV_BASH_PROFILE_FILES[@] "$1"
}

function _smj_devenv_prepend_profile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	array_shift _SMJ_DEVENV_BASH_PROFILE_FILES[@] "$1"
}

function _smj_devenv_load_profile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	local PROFILE_PATH="$SCRIPT_BASE_DIR/$1.sh"
	_smj_devenv_log "Loading '$PROFILE_PATH'"
	source $PROFILE_PATH
}

function _smj_devenv_load_profiles {
	if [ -z "$_SMJ_DEVENV_BASH_PROFILE_FILES" ]; then echo "Usage: $FUNCNAME <array of files>"; return; fi
	for profileFile in "${_SMJ_DEVENV_BASH_PROFILE_FILES[@]}"; do 
		_smj_devenv_load_profile $profileFile
	done
}
