#!/bin/bash

# Short-hand function for ssh connections
#TODO: add some auto-completion for users and hosts
function s {

	if [ $# -eq 1 ]; then
		USER=$DEFAULT_SSH_USER
		HOST=$1
	elif [ $# -eq 2 ]; then
		USER=$1
		HOST=$2
	else 
		echo "Usage: s <user> HOST"
		return
	fi
	
	# echo "HOST: $HOST, USER: $USER";
	ssh $USER@$HOST
}

# SSH Agent
if [ `ps aux | grep ssh-agent -c` -eq 1 ]; then
	eval $(ssh-agent)
	lso ~/.ssh/ | egrep "\-rw?\-\-\-\-" | awk '{print $3}' | xargs -L 1 ssh-add 
fi
