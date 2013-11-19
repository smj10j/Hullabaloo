#!/bin/bash

# Short-hand function for ssh connections
#TODO: add some auto-completion for users and hosts
function s {

	if [ $# -eq 1 ]; then
		local USER=$DEFAULT_SSH_USER
		local HOST=$1
	elif [ $# -eq 2 ]; then
		local USER=$1
		local HOST=$2
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
