#!/bin/bash

function array_push {
	# Input
	local el=$2
	local _array=("${!1}")
	local _array_name="${1%\[@\]*}"

	# Push
	_array=("${_array[@]}" "$el")

	# Return
	upvar "$_array_name" "${_array[@]}"
}

function array_pop {
	# Input
	local _el_name=$2
	local _array=("${!1}")
	local _array_name=${1%\[@\]*}

	# Pop
	i=$(expr ${#_array[@]} - 1)
	local _el=${_array[$i]}
	unset _array[$i]
	_array=("${_array[@]}")

	# Return
	upvar "$_array_name" "${_array[@]}"
	if [ -n "$_el_name" ]; then
		upvar "$_el_name" "$_el"
	fi
}

function array_shift {
	# Input
	local el=$2
	local _array=("${!1}")
	local _array_name=${1%\[@\]*}

	# Shift
	_array=("$el" "${_array[@]}")

	# Return
	upvar "$_array_name" "${_array[@]}"
}

function array_unshift {
	# Input
	local _el_name=$2
	local _array=("${!1}")
	local _array_name=${1%\[@\]*}

	# Unshift
	local _el=${_array[0]}
	unset _array[0]
	_array=("${_array[@]}")

	# Return
	upvar "$_array_name" "${_array[@]}"
	if [ -n "$_el_name" ]; then
		upvar "$_el_name" "$_el"
	fi
}

#################################
############ Examples ###########
#################################

function _array_function_examples {

	echo ''
	echo '#####################################################'
	echo '############## Array Function Examples ##############'
	echo '#####################################################'
	echo ''

	echo "# Array instantiation"
	echo '>> arr=("one" "two" "three")'
	arr=("one" "two" "three")
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo "# Push an element onto the front of the array"
	echo '>> array_shift arr[@] "zero"'
	array_shift arr[@] "zero"
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo "# Push an element onto the end of the array"
	echo '>> array_push arr[@] "four"'
	array_push arr[@] "four"
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo "# Unshift elements off the front of the array"
	echo '>> array_unshift arr[@]'
	array_unshift arr[@]
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '>> array_unshift arr[@]'
	array_unshift arr[@]
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo "# Pop elements off the end of the array"
	echo '>> array_pop arr[@]'
	array_pop arr[@]
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo "# Popped an element off the end of the array and store in popped_el"
	echo '>> array_pop arr[@] popped_el'
	array_pop arr[@] popped_el
	echo '${arr[@]}: '${arr[@]}
	echo '$popped_el: '$popped_el
	echo ''

	echo '#####################################################'
	echo ''
}
