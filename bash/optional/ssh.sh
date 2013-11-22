#!/bin/bash


# SSH Agent
if [ `ps aux | grep ssh-agent -c` -eq 1 ]; then
	eval $(ssh-agent)
fi
lso ~/.ssh/ | egrep "\-rw?\-\-\-\-" | awk '{print $3}' | xargs -L 1 ssh-add > /dev/null 2>&1 

# Autocomplete Hostnames for SSH etc.
_complete_ssh () {
	COMPREPLY=()

	local cur=`_get_cword`
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    	
	local user_host_list=""
	local user_arr=('admin' 'ec2-user' 'root' 'ubuntu')

	case "$prev" in
    -@(i))
    	local file_list=`ls ~/.ssh/ | awk '{print "~/.ssh/"$1}'`
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
complete -o nospace -F _complete_ssh ssh


