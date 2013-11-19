#!/bin/bash

# Get a reference to the directory this script is in
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DevEnvironment tools will be loaded from $SCRIPT_DIR"

BASH_PROFILE_FILES=()

# Very specific
BASH_PROFILE_FILES+=("include/variables")

# Likely helpful for all
BASH_PROFILE_FILES+=("include/path")
BASH_PROFILE_FILES+=("include/file")
BASH_PROFILE_FILES+=("include/git")
BASH_PROFILE_FILES+=("include/ssh")

# More specific
BASH_PROFILE_FILES+=("include/daemons")
BASH_PROFILE_FILES+=("include/osx")

# Very specific
BASH_PROFILE_FILES+=("include/shortcuts")





# Load 'em in!
for profileFile in "${BASH_PROFILE_FILES[@]}"; do 
	profileFilePath="$SCRIPT_DIR/$profileFile.bashrc"
	echo "Loading '$profileFilePath'"
	source $profileFilePath
done




function updateDevEnvironment {
	echo ""
	echo "Updating DevEnvironment..."
	echo ""
	
	cd $DEV_ENVIRONMENT_INSTALL_DIR
	git pull
	
	echo ""
	echo "Update complete!"
	echo "Now installing a new Terminal profile and opening a new shell so the changes take effect immediately..."
	echo ""

	open osx/smj10j.terminal && exit 0
}