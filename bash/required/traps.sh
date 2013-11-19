#!/bin/bash

# Prints a nice stack trace (http://stackoverflow.com/a/17734099/1730485)
function _smj_devenv_get_stack_trace () {
	local STACK=()
	local OFFSET=${1:-1}
	local ROOT_DIR=${2:-}
	
	# to avoid noise we start with 1 to skip get_stack itself
	local i
	local stack_size=${#FUNCNAME[$OFFSET]}
	local BASH_INTERNAL_STR="(Internal Bash Function)"
		
	for (( i=1; i<$stack_size ; i++ )); do	
		# Function
		local func="${FUNCNAME[$i]}"
		[ x$func = x ] && func=MAIN
		
		# Filename
		local src="${BASH_SOURCE[$i]}"
		[ x"$src" = x ] && src="$BASH_INTERNAL_STR"
		src=${src#$ROOT_DIR/}

		# Line number
		local lineNumber="${BASH_LINENO[(( i - 1 ))]}"

		# Break after we hit our first "non file source"
		if [ "$src" == "$BASH_INTERNAL_STR" ]; then
			break;
		fi

		# Add to array
		STACK+=("$src [line $lineNumber] - $func()")
	done

	for stackItem in "${STACK[@]}"; do 
		echo "${stackItem[@]}"
	done

}

# Catches errors within bash and outputs them
function _smj_devenv_trap_error_handler {
	
	local MYSELF="$0"					# equals to my script name when in a file
	local SCRIPT_NAME="$1"			# argument 1: script name
	local LASTLINE="$2"				# argument 2: last line of error occurrence
	local LASTERR="$3"				# argument 3: error code of last command
	
	local HEADER="#################### ERROR $MYSELF ####################"
	local FOOTER=`for i in $(seq 1 ${#HEADER}); do echo -n "#"; done`
	
	echo ""
	echo $HEADER
	echo ""
	
# 	echo "== Stacktrace =="
# 	local frame=0
# 	while caller $frame; do
# 		((frame++));
# 	done
	
	echo "== Stacktrace =="
	_smj_devenv_get_stack_trace 1 "$SCRIPT_BASE_DIR"
	echo ""
	
	echo "${SCRIPT_NAME} [line ${LASTLINE}]: exit status of last command: ${LASTERR}"
	
	echo ""
	echo $FOOTER
	echo ""
}

# Clear error traps
trap ERR

# Add our new one
trap '_smj_devenv_trap_error_handler "${BASH_SOURCE#*\./}" ${LINENO} $?' ERR
