#!/bin/bash

_hullabaloo_get_installed_packages() {     
    FILE=/var/log/dpkg.log;      
    if [[ -f $FILE ]]; then 
        egrep -e "^.* install .*$" $FILE | awk '{print ""$1" "$2""","""$4""}' 
    fi
}

