#!/bin/bash

function _smj_devenv_bold {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <msg>"; return; fi
	
	local BOLD=`tput bold`
	local NORMAL=`tput sgr0`

	echo "${BOLD}$1${NORMAL}"
}




