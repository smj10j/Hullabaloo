#!/bin/bash


# Enable Bash Completion
if [ `uname` == 'Darwin' ]; then
	if [ -e /opt/local/bin/bash ]; then 
		if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
			. /opt/local/etc/profile.d/bash_completion.sh
		fi
	else
		local MSG="Not enabling bash-completion because the bash shell for it is not installed\n"
		MSG+="Install bash-completion with 'sudo port install bash-completion'" 
		_smj_devenv_notify "$MSG"
	fi
fi

# Ignore case when doing bash completion
bind "set completion-ignore-case"



#TODO: add push/pop for CD