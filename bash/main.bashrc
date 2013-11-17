#!/bin/bash

# Get a reference to the directory this script is in
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "smj10j DevEnvironment tools will be loaded from $SCRIPT_DIR"

BASH_PROFILE_FILES=()
BASH_PROFILE_FILES+=("include/path")
BASH_PROFILE_FILES+=("include/git")
BASH_PROFILE_FILES+=("include/file")
BASH_PROFILE_FILES+=("include/daemons")
BASH_PROFILE_FILES+=("include/ssh")
BASH_PROFILE_FILES+=("include/osx")

for profileFile in "${BASH_PROFILE_FILES[@]}"; do 
	profileFilePath="$SCRIPT_DIR/$profileFile.bashrc"
	echo "Loading bash profile at '$profileFilePath'"
	#source $profileFilePath
done




