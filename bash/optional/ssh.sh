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
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}"
    echo "ssh-agent started with PID $SSH_AGENT_PID"

    if [[ -n $(which brew) ]]; then
        echo "Initialising keychain..."
        $(brew --prefix)/bin/keychain --timeout 120 --eval --agents ssh --inherit any _dsa _rsa
    fi
    
    echo "Adding ssh keys with no passphrases..."
    find $SSH_HOME -iregex '.*\(pem\|rsa\|dsa\)$' | xargs -L 1 $(brew --prefix)/bin/ssh-add -k 
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
