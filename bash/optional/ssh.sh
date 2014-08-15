#!/bin/bash

# SSH Agent
# http://www.gilluminate.com/2013/04/04/ubuntu-ssh-agent-and-you/
SSH_HOME="$HOME/.ssh"
SSH_ENV="$SSH_HOME/environment"

# Setup needed ssh environment
source "${SSH_ENV}"
mkdir -p "$SSH_HOME/connections"
chmod 700 "$SSH_HOME/connections"


# Set the environment variables used by ssh-agent 
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}"
    echo "ssh-agent started with PID $SSH_AGENT_PID"
    if [[ -n $(which brew) ]]; then
        $(brew --prefix)/bin/keychain --agents ssh -Q --quiet
    fi
    
    echo "Adding ssh keys to ssh-agent with passphrases from keychain..."
    ssh-add -A 
    
    echo "Adding ssh keys with no passphrases..."
    #find -E $SSH_HOME -iregex '.*(pem|rsa|dsa)$' | xargs -L 1 ssh-add -K 

}

# Source SSH settings, if applicable
if [[ -f "${SSH_ENV}" ]]; then
    source "${SSH_ENV}"
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || { 
        start_agent 
    }
else
    start_agent
fi




# Autocomplete Hostnames for SSH etc.
_complete_ssh () {
	COMPREPLY=()

	cur=${COMP_WORDS[1]}
	prev=${COMP_WORDS[COMP_CWORD-1]}

	user_host_list=""
	user_arr=( 'admin' 'ec2-user' 'root' 'ubuntu' )

	case "$prev" in
		-i)
			file_list=$(find -E "$SSH_HOME" -iregex '.*(pem|rsa|dsa)$')
			COMPREPLY=( $( compgen -W "${file_list}" -- "${cur}" ) )
			return 0
			;;
	esac

#	if [[ "$cur" =~ @ ]]; then

		host_list=$({ 
#			for c in /etc/ssh_config /etc/ssh/ssh_config "$SSH_HOME/config"
#				do [ -r $c ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' $c
#			done
			for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts "$SSH_HOME/known_hosts"
				do [ -r $k ] && egrep -v '^[#\[]' $k | cut -f 1 -d ' ' | sed -e 's/[,:].*//g'
			done
			sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; 
		} | tr ' ' '\n' | egrep -v '\n' | tr '\n' ' ' | sed -E "s/[[:space:]]+/ /g" | tr ' ' '\n')
	
		IFS=$'\n'
		host_array=()
		host_arr=( $host_list )
		
		for h in "${host_arr[@]}"; do 
			user_host_list+="$h"$'\n'
			for u in "${user_arr[@]}"; do 
				user_host_list+="$u@$h"$'\n'
			done
		done
	
# 	else
# 		for u in "${user_arr[@]}"; do 
# 			user_host_list+="$u@"$'\n'
# 		done
# 	fi

	COMPREPLY=( $(compgen -W "${user_host_list}" -- "${cur}"))
	return 0
}
complete -o nospace -F _complete_ssh mosh
complete -o nospace -F _complete_ssh ssh


