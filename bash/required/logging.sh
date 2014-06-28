#!/bin/bash

#TODO: make _hullabaloo_notify use pretty printing
function _hullabaloo_notify {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi

	local CATEGORY=${BASH_SOURCE[1]}'::'${FUNCNAME[1]}'()'
	CATEGORY=${CATEGORY#$SCRIPT_BASE_DIR/}

	echo ""
	echo `_hullabaloo_bold "#######################################################"`
	echo "$CATEGORY: $1"
	echo `_hullabaloo_bold "#######################################################"`
	echo ""
}

function _hullabaloo_log {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi
	#TODO: should use a better SCRIPT_NAME (currently will be this file!)
	if [ -n "$VERBOSE" ]; then
		local CATEGORY=${BASH_SOURCE[1]}'::'${FUNCNAME[1]}'()'
		CATEGORY=${CATEGORY#$SCRIPT_BASE_DIR/}
		echo "$CATEGORY: $1"
	fi
}

