#!/bin/bash

# 
function s {

	if [ $# -eq 1 ]; then
		$USER = 'root'
		$HOST = $1
	elif [ $# -eq 2 ]; then
		$USER = $1
		$HOST = $2
	else 
		echo "Usage: $0 <user> HOST"
		exit 1
	fi
	
	echo "HOST: $HOST, USER: $USER";
#	ssh -i ~/.ssh/id_rsa-extrabux-keypair ubuntu@$1
}


## SSH Agent
if [ `ps aux | grep ssh-agent -c` -eq 1 ]; then
	eval $(ssh-agent)
	lso ~/.ssh/ | egrep "\-rw?\-\-\-\-" | awk '{print $3}' | xargs -L 1 ssh-add 
fi
