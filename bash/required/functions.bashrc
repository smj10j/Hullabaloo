#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_SMJ_DEVENV_BASH_PROFILE_FILES=()

function _smj_devenv_appendprofile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	_SMJ_DEVENV_BASH_PROFILE_FILES+=($1)
}

function _smj_devenv_prependprofile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi

}

function _smj_devenv_loadprofiles {
	if [ -z "$_SMJ_DEVENV_BASH_PROFILE_FILES" ]; then echo "Usage: $FUNCNAME <array of files>"; return; fi
	for profileFile in "${_SMJ_DEVENV_BASH_PROFILE_FILES[@]}"; do 
		_smj_devenv_loadprofile $profileFile
	done
}

function _smj_devenv_loadprofile {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <file>"; return; fi
	PROFILE_PATH="$SCRIPT_DIR/$1.bashrc"
	echo "Loading '$PROFILE_PATH'"
	source $PROFILE_PATH
}

#TODO: make _smj_devenv_notify use pretty printing
function _smj_devenv_notify {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi
	SCRIPT_NAME=${BASH_SOURCE#*\./}
	echo ""
	echo "#######################################################"
	echo "$SCRIPT_NAME: $1"
	echo "#######################################################"
	echo ""
}

function _smj_devenv_log {
	if [ -z "$1" ]; then echo "Usage: $FUNCNAME <message>"; return; fi
	if [ -n "$VERBOSE" ]; then
		SCRIPT_NAME=${BASH_SOURCE#*\./}
		echo "$SCRIPT_NAME: $1"
	fi
}

# Gets the location of the script that will bootstrap this whole installation
function _smj_devenv_bash_profile_file {
	
	if [ `uname` == 'Darwin' ]; then
		BASH_PROFILE_FILE=~/.bash_profile
	else
		BASH_PROFILE_FILE=~/.bashrc
	fi
	
	if [ ! -e $BASH_PROFILE_FILE ]; then
		touch $BASH_PROFILE_FILE
	fi
	
	echo $BASH_PROFILE_FILE
}

function _smj_devenv_update {
	
	echo ""
	echo "Updating DevEnvironment..."
	cd $_SMJ_DEVENV_INSTALL_DIR
	git pull --rebase
	git submodule update
	echo ""
	
	echo ""
	echo "Update complete!"
	echo "Now installing a new Terminal profile and opening a new shell so the changes take effect immediately..."
	echo ""

	if [ `uname` == 'Darwin' ]; then
		open $_SMJ_DEVENV_INSTALL_DIR/osx/smj10j.terminal && exit 0
	fi
}

function _smj_devenv_reload {
	if [ `uname` == 'Darwin' ]; then
		read -n1 -r -p "Press any key to open the new terminal..." key
		open osx/smj10j.terminal && exit 0
	else 
		read -n1 -r -p "Press any key to open the new shell..." key
		/bin/bash -l && exit 0
	fi
}

function _smj_devenv_uninstall {

	if [ -z "$_SMJ_DEVENV_INSTALL_DIR" ]; then 
		MSG="Installation directory unknown... automatic uninstall aborted!\n"
		MSG+="My best guess to the location of this installation is: $SCRIPT_DIR"
		
		_smj_devenv_notify "$MSG"
		return
	fi

	echo ""
	echo "Removing $_SMJ_DEVENV_INSTALL_DIR..."
	rm -rf $_SMJ_DEVENV_INSTALL_DIR
	echo ""
	
	echo ""
	echo "Removing ~/.vim_runtime symlink"
	rm -rf ~/.vim_runtime
	echo ""
	
	
	echo ""
	echo "Removing entry from $BASH_PROFILE_FILE..."
	BASH_PROFILE_FILE=`_smj_devenv_bash_profile_file`
	BASH_PROFILE_INCLUDE_START='############## Begin smj10j Bash Profile.*'
	BASH_PROFILE_INCLUDE_END='################ End smj10j Bash Profile.*'
	sed "/$BASH_PROFILE_INCLUDE_START/,/$BASH_PROFILE_INCLUDE_END/d" $BASH_PROFILE_FILE
	echo ""

	echo ""
	echo "Uninstall complete!"
	echo ""

	_smj_devenv_reload	
}







