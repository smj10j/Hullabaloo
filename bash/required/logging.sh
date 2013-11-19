#!/bin/bash

#TODO: make _smj_devenv_notify use pretty printing
function _smj_devenv_notify {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi
	local SCRIPT_NAME=${BASH_SOURCE#*\./}
	echo ""
	echo "#######################################################"
	echo "$SCRIPT_NAME: $1"
	echo "#######################################################"
	echo ""
}

function _smj_devenv_log {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi
	if [ -n "$VERBOSE" ]; then
		local SCRIPT_NAME=${BASH_SOURCE#*\./}
		SCRIPT_NAME=${SCRIPT_NAME#$SCRIPT_BASE_DIR/}
		echo "$SCRIPT_NAME: $1"
	fi
}