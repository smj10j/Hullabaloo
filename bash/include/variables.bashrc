#!/bin/bash

# Configuration variables used by the other .bashrc scripts


# These paths will be appended if they don't already exist to the PATH variable
PATH_ADDITION="/opt/local/bin:/opt/local/sbin:/opt/local/libexec/perl5.12/sitebin"

# If no user is provided to 's', this user will be used
DEFAULT_SSH_USER='root'

# This is the editor that will be launched by 'edit'
TEXT_EDITOR_CMD='vi'
if [ `uname` != 'Darwin' ]; then
	if [ -n `ls -la /Applications/ | grep 'BBEdit'` ]; then
		TEXT_EDITOR_CMD='open -a BBEdit'
	else
		TEXT_EDITOR_CMD='open -a TextEdit'
	fi
fi


# Screenshots will be placed in this directory instead of the Desktop
SCREENSHOT_DIR=~/Screenshots
