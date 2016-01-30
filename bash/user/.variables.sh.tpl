#!/bin/bash

# Configuration variables used by the other .bashrc scripts


# These paths will be appended if they don't already exist to the PATH variable
PATH_ADDITION=""



# This is the editor that will be launched by 'edit'
#TODO: install a better default text editor if BBEdit not available
TEXT_EDITOR_CMD='vi'
if [ `uname` == 'Darwin' ]; then
	if [ -n "`ls -la /Applications/ | grep 'BBEdit'`" ]; then
		TEXT_EDITOR_CMD='open -a BBEdit'
	else
		TEXT_EDITOR_CMD='open -a TextEdit'
	fi
fi

# Screenshots will be placed in this directory instead of the Desktop
SCREENSHOT_DIR=~/Dropbox/Screenshots

#TODO: sensible defaults
# Any periodic backups will be written here
BACKUPS_DIR=~/Dropbox
if [ ! -e $BACKUPS_DIR ]; then
	return _hullabaloo_notify "Backup directory '$BACKUPS_DIR' does not exist"
fi
