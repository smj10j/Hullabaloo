#!/bin/bash


# Gets the location of the script that will bootstrap this whole installation
function _hullabaloo_bash_profile_file {

	local BASH_PROFILE_FILE=~/.bash_profile

	if [ $(uname) == 'Darwin' ]; then
		local BASH_PROFILE_FILE=~/.bash_profile
	else
		local BASH_PROFILE_FILE=~/.bashrc
	fi
	
	if [ ! -e $BASH_PROFILE_FILE ]; then
		touch $BASH_PROFILE_FILE
	fi
	
	echo $BASH_PROFILE_FILE
}

function _hullabaloo_update {
	
	echo ""
	echo "Updating Hullabaloo..."
	cd "$_HULLABALOO_INSTALL_DIR"
	git pull --rebase
	git submodule update
	echo ""

	echo ""
	echo "Update complete!"
	echo ""

	_hullabaloo_reload
}

function _hullabaloo_repair {

	echo ""
	echo "Repairing your Hullabaloo installation..."
	echo "You may be asked for your computer password"
	echo ""

	local USER=$(whoami)
	local GROUP=$(groups | awk {'print $1'})
	DEFAULT_INSTALL_DIR=$(echo ~/.hullabaloo)

	if [ -z "$_HULLABALOO_INSTALL_DIR" ]; then
		if [[ -e "$DEFAULT_INSTALL_DIR" ]]; then
			echo ""
			echo "Found Hullabaloo at $DEFAULT_INSTALL_DIR..."
			echo ""
			export _HULLABALOO_INSTALL_DIR="$DEFAULT_INSTALL_DIR"
		else
			if [ -z "$_HULLABALOO_INSTALL_DIR" ]; then
				local MSG=$'\nInstallation directory unknown... repair aborted!\n'
				_hullabaloo_notify "$MSG"
				return
			fi
		fi
	fi

	echo ""
	echo "Setting owner of $_HULLABALOO_INSTALL_DIR to $USER:$GROUP..."
	sudo chown -R $USER:$GROUP $_HULLABALOO_INSTALL_DIR

	
	echo ""
	echo "Repair complete!"
	echo ""

	_hullabaloo_reload
}

function _hullabaloo_reload {

	local BASH_PROFILE_FILE=$(_hullabaloo_bash_profile_file)
	local BASH_PATH=$(which bash)
	local TERMINAL_PROFILE_PATH="$_HULLABALOO_INSTALL_DIR/osx/hullabaloo.terminal"

	read -e -p "Press enter to reload..." key
	$BASH_PATH -l && exit 0

#	if [ $(uname) == 'Darwin' ]; then
#		if [ -e "$TERMINAL_PROFILE_PATH" ]; then
#			echo ""
#			echo "Installing new Terminal profile and opening a new shell so the changes take effect immediately..."
#			echo ""
#			open "$TERMINAL_PROFILE_PATH" && exit 0
#		else
#			$BASH_PATH -l && exit 0
#		fi
#	else
#		$BASH_PATH -l && exit 0
#	fi
}

function _hullabaloo_uninstall {

	if [ -z "$_HULLABALOO_INSTALL_DIR" ]; then
		local MSG=$'\nInstallation directory unknown... automatic uninstall aborted!\n'
		MSG+="My best guess to the location of this installation is: $INSTALL_BASE_DIR"
		
		_hullabaloo_notify "$MSG"
		return
	fi

	echo ""
	echo "Removing $_HULLABALOO_INSTALL_DIR..."
	rm -rf $_HULLABALOO_INSTALL_DIR
	echo ""
	
	echo "Removing ~/.vim_runtime symlink"
	rm -rf ~/.vim_runtime
	echo ""
	
	local BASH_PROFILE_FILE=$(_hullabaloo_bash_profile_file)
	local BASH_PROFILE_INCLUDE_START='############## Begin Hullabaloo Bash Profile.*'
	local BASH_PROFILE_INCLUDE_END='################ End Hullabaloo Bash Profile.*'

	if [ -n "$BASH_PROFILE_FILE" ]; then 
		echo "Removing entry from $BASH_PROFILE_FILE..."
	
		if [ $(uname) == 'Darwin' ]; then
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

	_hullabaloo_reload
}

