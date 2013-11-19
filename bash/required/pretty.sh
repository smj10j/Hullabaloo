#!/bin/bash

#TODO: implement _bold and _normal
function _bold {
	
	local BOLD=`tput bold`
	local NORMAL=`tput sgr0`

	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <msg>"; return; fi
	return "this is ${bold}bold${normal} but this isn't"
}




