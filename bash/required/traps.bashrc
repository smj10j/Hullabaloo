#!/bin/bash

# Catches errors within bash and outputs them
function _smj_devenv_trap_error_handler {
	MYSELF="$0"					# equals to my script name
	LASTLINE="$1"				# argument 1: last line of error occurence
	LASTERR="$2"				# argument 2: error code of last command
	
	# clear
	echo ""
	echo "------------- ERROR -------------"
	echo "${MYSELF}: line ${LASTLINE}: exit status of last command: ${LASTERR}"
	echo "---------------------------------"
	echo ""

}

trap '_smj_devenv_trap_error_handler ${LINENO} $?' ERR
