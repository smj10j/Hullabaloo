#!/bin/bash


# SSH Agent
if [ `ps aux | grep ssh-agent -c` -eq 1 ]; then
	eval $(ssh-agent)
	lso ~/.ssh/ | egrep "\-rw?\-\-\-\-" | awk '{print $3}' | xargs -L 1 ssh-add 
fi
