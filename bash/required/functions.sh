#!/bin/bash


# Gets the location of the script that will bootstrap this whole installation
function _hullabaloo_bashrc_file {

	local BASHRC_FILE=~/.bashrc
	local BASH_PROFILE_FILE=~/.bash_profile

	if [[ ! -e $BASH_PROFILE_FILE ]]; then
		cp "$_HULLABALOO_INSTALL_DIR/bash/templates/.bash_profile" $BASH_PROFILE_FILE
	fi

	echo $BASHRC_FILE
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

	if [[ -z "$_HULLABALOO_INSTALL_DIR" ]]; then
		if [[ -e "$DEFAULT_INSTALL_DIR" ]]; then
			echo ""
			echo "Found Hullabaloo at $DEFAULT_INSTALL_DIR..."
			echo ""
			export _HULLABALOO_INSTALL_DIR="$DEFAULT_INSTALL_DIR"
		else
			if [[ -z "$_HULLABALOO_INSTALL_DIR" ]]; then
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

	local BASHRC_FILE=$(source $(_hullabaloo_bashrc_file))
	local BASH_PATH=$(which bash)
	local TERMINAL_PROFILE_PATH="$_HULLABALOO_INSTALL_DIR/osx/hullabaloo.terminal"

#
#     # This is how the 'read' command works with zsh
#     # https://superuser.com/questions/555874/zsh-read-command-fails-within-bash-function-read1-p-no-coprocess
#
#     read "brave?Here be dragons. Continue?"
#     if [[ "$brave" =~ ^[Yy]$ ]]; then
#     
#     fi
#

	if [[ $(uname) == 'Darwin' ]]; then
		if [[ -f "$TERMINAL_PROFILE_PATH" ]]; then
			echo ""
			echo "Installing new Terminal profile and opening a new shell so the changes take effect immediately..."
			echo ""
			open "$TERMINAL_PROFILE_PATH"
			osascript -e 'tell application "Terminal"
                tell first window
                    set ProfileSettings to (current settings of front tab )
                end tell
                set default settings to ProfileSettings
                set startup settings to ProfileSettings
            end tell'
            exit 0
		else
			$BASH_PATH -l && exit 0
		fi
	else
		$BASH_PATH -l && exit 0
	fi
}

function _hullabaloo_uninstall {

	if [[ -z "$_HULLABALOO_INSTALL_DIR" ]]; then
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
	
	local BASHRC_FILE=$(source _hullabaloo_bashrc_file)
	local BASHRC_INCLUDE_START='############## Begin Hullabaloo Bash Profile.*'
	local BASHRC_INCLUDE_END='################ End Hullabaloo Bash Profile.*'

	if [ -n "$BASHRC_FILE" ]; then 
		echo "Removing entry from $BASHRC_FILE..."
	
		if [ $(uname) == 'Darwin' ]; then
			sed -i '' "/$BASHRC_INCLUDE_START/,/$BASHRC_INCLUDE_END/d" $BASHRC_FILE
		else
			sed -i "/$BASHRC_INCLUDE_START/,/$BASHRC_INCLUDE_END/d" $BASHRC_FILE
		fi
	else
		echo "Unable to location your bash profile - not modifying"	
	fi
	echo ""

	echo "Uninstall complete!"
	echo ""

	_hullabaloo_reload
}

