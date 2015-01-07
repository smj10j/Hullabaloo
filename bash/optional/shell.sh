#!/bin/bash

# Enable Bash Completion support on zsh
IF_ZSH 'autoload bashcompinit; bashcompinit' 

# Enable Bash Completion
if [[ -z "$(which complete)" ]] && [[ $(uname) == 'Darwin' ]]; then
	# Bash Completion
	if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
		bash $(brew --prefix)/etc/bash_completion
	fi
fi

# Store much more bash history (default is 500)
export HISTFILESIZE=10000

# Ignore duplicate lines
export HISTCONTROL=erasedups

if [[ "$0" =~ bash$ ]]; then

    # Ignore case when doing bash completion
    bind "set completion-ignore-case"

    # Auto-append the history on shell exit
    shopt -s histappend

    # Try and keep multi-line commands in good shape in the history
    shopt -s lithist
    shopt -s cmdhist

    # Auto correct simple misspellings
    shopt -s cdspell
    #shopt -s dirspell

    # Complete hostname when typing
    shopt -s hostcomplete
fi

# Easier process search
alias au='ps aux | grep '

# Follow symlinks
ff() {
	LINK=$(readlink -f $(which $1))
	LINK_PWD=$(dirname $LINK)
	pushd $LINK_PWD
}

function _du() {
    ${1?"_du dir [depth=1]"}
    DEPTH=''
    if [[ ! -z $2 ]]; then 
        DEPTH=$(printf '/**%.0s' $(eval "echo {1.."$(($2))"}");)
    fi
    du -hs $1$DEPTH/* | sort -h
}

function _memtop() {
    watch '\
        exec bash -c "\
            echo '\''stats'\'' | nc -U /tmp/memcached.sock | \
            tee >(awk '\''/get/ {print \$3}'\'' | tac | \
            sed -n '\''1p;\$p'\'' | cat -v | tr -d '\''\n'\'' | sed '\''s/\^M/\//g'\'' | \
            xargs -IX echo '\''100*(1-(X1))'\'' | tee >/dev/null >(bc -l | cut -c1-5) | xargs echo '\''Cache Hit Rate (%):'\'') \
        "\
    '
}

# Show the commands you use most (http://lifehacker.com/202712/review-your-most-oft-used-unix-commands)
_hullabaloo_history_ranked() {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
}



