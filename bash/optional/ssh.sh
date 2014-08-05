#!/bin/bash

# Enable Bash Completion
if [ `uname` == 'Darwin' ]; then
	# Bash Completion
	if [ -f `brew --prefix`/etc/bash_completion ]; then
		. `brew --prefix`/etc/bash_completion
	fi
fi

# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi

for p in ${PREFERRED_SSH_KEYS[@]}; do 
	ssh-add -K `eval echo $p` > /dev/null 2>&1 
done
#ls -lat ~/.ssh/ | egrep "\-rw?\-\-\-\-" | awk '{ print "'`echo ~`'/.ssh/"$9 }' | xargs -L 1 ssh-add -K > /dev/null 2>&1 

# Autocomplete Hostnames for SSH etc.
_complete_ssh () {
	COMPREPLY=()

	local cur=`_get_cword`
	local prev=${COMP_WORDS[COMP_CWORD-1]}
    	
	local user_host_list=""
	local user_arr=( 'admin' 'ec2-user' 'root' 'ubuntu' )

	case "$prev" in
		-@(i))
			local file_list=`find ~/.ssh/`
			COMPREPLY=( $( compgen -W '$file_list' -- "$cur" ) )
			return 0
			;;
	esac

	if [[ $cur == *@* ]]; then
		local host_list=`{ 
			for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config
				do [ -r $c ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' $c
			done
			for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts
				do [ -r $k ] && egrep -v '^[#\[]' $k | cut -f 1 -d ' ' | sed -e 's/[,:].*//g'
			done
			sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; } | tr ' ' '\n' | egrep -v '\n' | tr '\n' ' ' | sed -E "s/[[:space:]]+/ /g" | tr ' ' '\n'`
	
		IFS=$'\n'
		local host_array=()
		host_arr=( $host_list )

		for h in "${host_arr[@]}"; do 
			for u in "${user_arr[@]}"; do 
				user_host_list+="$u@$h"$'\n'
			done
		done
	
	else
		for u in "${user_arr[@]}"; do 
			user_host_list+="$u@"$'\n'
		done
	fi

	COMPREPLY=( $(compgen -W "${user_host_list}" -- "${cur}"))
	return 0
}
complete -o nospace -F _complete_ssh mosh
complete -o nospace -F _complete_ssh ssh


