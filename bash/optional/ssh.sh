#!/bin/bash

# SSH Agent
# http://www.gilluminate.com/2013/04/04/ubuntu-ssh-agent-and-you/
SSH_HOME="$HOME/.ssh"
SSH_ENV="$SSH_HOME/environment"

# Setup needed ssh environment
source "${SSH_ENV}"
mkdir -p "$SSH_HOME/connections"
chmod 700 "$SSH_HOME/connections"


# ssh-askpass
export SSH_ASKPASS="/usr/local/bin/ssh-askpass"

# Set the environment variables used by ssh-agent 
function start_agent {
    if [[ -n $(which brew) ]]; then
        echo "Initialising ssh-agent and gpg-agent via keychain..."
        $(brew --prefix)/bin/keychain --quiet \
            --timeout 720 --eval --agents ssh --inherit local-once \
            steve@inora.01j.me \
            steve@huggableharry.smj10j.net \
            aws-norcal-1.pem \
            ovh-statstrasbourg > "${SSH_ENV}"
        chmod 600 "${SSH_ENV}"
        source "${SSH_ENV}"
        echo "ssh-agent started with PID $SSH_AGENT_PID"
    fi
    
    #echo "Adding ssh keys with no passphrases..."
    #find $SSH_HOME -iregex '.*\(pem\|rsa\|dsa\)$' | xargs -L 1 $(brew --prefix)/bin/ssh-add -k 
}

# Source SSH settings, if applicable
if [[ -f "${SSH_ENV}" ]]; then
    source "${SSH_ENV}"
    kill -9 ${SSH_AGENT_PID} 2>/dev/null || start_agent 
else
    start_agent
fi
