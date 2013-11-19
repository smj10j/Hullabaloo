#!/bin/bash

### Idea from: http://pastebin.com/S1bi8UX5

function arr_push {
	arr=("${arr[@]}" "$1")
}

function arr_pop {
	i=$(expr ${#arr[@]} - 1)
	placeholder=${arr[$i]}
	unset arr[$i]
	arr=("${arr[@]}")
}

function arr_shift {
	arr=("$1" "${arr[@]}")
}

function arr_unshift {
	placeholder=${arr[0]}
	unset arr[0]
	arr=("${arr[@]}")
}

#################################
############ Examples ###########
#################################

function _smj_devenv_arr_examples {
	
	echo ''
	echo '#####################################################'
	echo '############## Array Function Examples ##############'
	echo '#####################################################'
	echo ''
	
	echo '$> arr=("one" "two" "three")'
	arr=("one" "two" "three") 	
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '$> arr_shift "zero"'
	arr_shift "zero"
	echo '${arr[@]}: '${arr[@]}
	echo ''
	
	echo '$> arr_push "four"'
	arr_push "four"
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '$> arr_unshift echo ${arr[@]}'
	arr_unshift echo ${arr[@]}
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '$> arr_unshift echo ${arr[@]}'
	arr_unshift echo ${arr[@]}
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '$> arr_pop echo ${arr[@]}'
	arr_pop echo ${arr[@]}
	echo '${arr[@]}: '${arr[@]}
	echo ''

	echo '$> arr_pop echo ${arr[@]}'
	arr_pop echo ${arr[@]}
	echo '${arr[@]}: '${arr[@]}
	echo ''
	
	echo '#####################################################'
	echo ''
}