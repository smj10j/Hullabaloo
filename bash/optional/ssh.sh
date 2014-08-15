#!/bin/bash

SSH_ENV="$HOME/.ssh/environment"

# SSH Agent
# http://www.gilluminate.com/2013/04/04/ubuntu-ssh-agent-and-you/
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet  ls ~/.ssh/* | awk "/(pem)|(rsa)/") && ssh'
alias git='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet  ls ~/.ssh/* | awk "/(pem)|(rsa)/") && git'

# Set the environment variables used by ssh-agent 
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi



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


