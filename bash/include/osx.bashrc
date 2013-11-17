#!/bin/bash

# Change the screenshot directory
function setScreenshotDirectory {
	if [ `defaults read com.apple.screencapture location` != "$1" ]; then
		echo "Changing the screenshot directory from `defaults read com.apple.screencapture location` to $1..."
		mkdir -p $1
		defaults write com.apple.screencapture location $1
		sudo killall SystemUIServer
	fi
}
setScreenshotDirectory ~/Screenshots

# Always show hidden files in Finder
function setFinderToAlwaysShowHiddenFiles {
	
	FINDER_NAME='Finder'
	if [ "`ps -e | grep $FINDER_NAME -c`" == "1" ]; then FINDER_NAME='finder'; fi
	# echo "Finder name is $FINDER_NAME"
	
	if [ `defaults read com.apple.$FINDER_NAME AppleShowAllFiles` == "FALSE" ]; then
		echo "Enabling showing of hidden files everywhere..."
		defaults write com.apple.$FINDER_NAME AppleShowAllFiles TRUE
		sudo killall $FINDER_NAME
	fi
}
setFinderToAlwaysShowHiddenFiles 

# Alias to show registered URL schemes
function listRegisteredURLSchemes {
	LS_REGISTER_CMD='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
	$LS_REGISTER_CMD -dump | grep -B6 bindings:.*:
}
listRegisteredURLSchemes

