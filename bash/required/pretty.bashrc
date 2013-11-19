#!/bin/bash

_SMJ_DEVENV_TEXT_BOLD=`tput bold`
_SMJ_DEVENV_TEXT_NORMAL=`tput sgr0`

#TODO: implement _bold and _normal
function _bold {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <msg>"; return; fi
	return "this is ${bold}bold${normal} but this isn't"
}




