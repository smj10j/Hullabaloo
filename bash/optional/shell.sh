#!/bin/bash


# Enable Bash Completion
if [ `uname` == 'Darwin' ]; then
	if [ -e /opt/local/bin/bash ]; then 
		if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
			. /opt/local/etc/profile.d/bash_completion.sh
		fi
	else
		local MSG=$'Not enabling bash-completion because the bash shell for it is not installed\n'
		MSG+="Install bash-completion with 'sudo port install bash-completion'" 
		_smj_devenv_notify "$MSG"
	fi
fi

# Ignore case when doing bash completion
bind "set completion-ignore-case"

# Autocompletion for SSH
function _smj_devenv_ssh_known_hosts_completion {
	cur=${COMP_WORDS[COMP_CWORD]}
	if [[ "$cur" == *@* ]]; then
		# Username entered
		user=${cur%@*}
		hostPrefix=${cur#*@}
		host=`cat ~/.ssh/known_hosts | awk '{print $1}' | awk 'BEGIN { FS = "," } ; {print $1}' | tr "=" "\n" | egrep "^$hostPrefix"`
		if [ -n "$host" ]; then 
			use="$user@$host"
		fi
	else
		# No username yet
		case "$cur" in
			a*) use="admin@" ;;
			e*) use="ec2-user@" ;;
			r*) use="root@" ;;
			u*) use="ubuntu@" ;;
		esac
	fi
	COMPREPLY=( $( compgen -W "$use" -- $cur ) )
}
complete -o default -o nospace -F _smj_devenv_ssh_known_hosts_completion ssh


#TODO: add push/pop for CD

