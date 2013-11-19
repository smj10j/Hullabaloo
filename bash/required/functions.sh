#!/bin/bash


# Gets the location of the script that will bootstrap this whole installation
function _smj_devenv_bash_profile_file {
	
	if [ `uname` == 'Darwin' ]; then
		local BASH_PROFILE_FILE=~/.bash_profile
	else
		local BASH_PROFILE_FILE=~/.bashrc
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
		if [ -e osx/smj10j.terminal ]; then
			open osx/smj10j.terminal && exit 0
		else
			/bin/bash -l && exit 0	
		fi
	else 
		read -n1 -r -p "Press any key to open the new shell..." key
		/bin/bash -l && exit 0
	fi
}

function _smj_devenv_uninstall {

	if [ -z "$_SMJ_DEVENV_INSTALL_DIR" ]; then 
		local MSG=$'\nInstallation directory unknown... automatic uninstall aborted!\n'
		MSG+="My best guess to the location of this installation is: $INSTALL_BASE_DIR"
		
		_smj_devenv_notify "$MSG"
		return
	fi

	echo ""
	echo "Removing $_SMJ_DEVENV_INSTALL_DIR..."
	rm -rf $_SMJ_DEVENV_INSTALL_DIR
	echo ""
	
	echo "Removing ~/.vim_runtime symlink"
	rm -rf ~/.vim_runtime
	echo ""
	
	local BASH_PROFILE_FILE=`_smj_devenv_bash_profile_file`
	local BASH_PROFILE_INCLUDE_START='############## Begin smj10j Bash Profile.*'
	local BASH_PROFILE_INCLUDE_END='################ End smj10j Bash Profile.*'

	if [ -n "$BASH_PROFILE_FILE" ]; then 
		echo "Removing entry from $BASH_PROFILE_FILE..."
	
		if [ `uname` == 'Darwin' ]; then
			sed -i '' "/$BASH_PROFILE_INCLUDE_START/,/$BASH_PROFILE_INCLUDE_END/d" $BASH_PROFILE_FILE
		else
			sed -i "/$BASH_PROFILE_INCLUDE_START/,/$BASH_PROFILE_INCLUDE_END/d" $BASH_PROFILE_FILE
		fi
	else
		echo "Unable to location your bash profile - not modifying"	
	fi
	echo ""

	echo "Uninstall complete!"
	echo ""

	_smj_devenv_reload	
}







