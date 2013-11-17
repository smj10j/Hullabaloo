#!/bin/bash

# Stop if we're not on OSX
if [ `uname` != 'Darwin' ]; then
	return
fi

# Change the screenshot directory
function setScreenshotDirectory {
	if [ `defaults read com.apple.screencapture location` != "$1" ]; then
		echo "Changing the screenshot directory from `defaults read com.apple.screencapture location` to $1..."
		mkdir -p $1
		defaults write com.apple.screencapture location $1
		sudo killall SystemUIServer
	fi
}
setScreenshotDirectory $SCREENSHOT_DIR

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


# Enable Bash Completion (http://trac.macports.org/wiki/howto/bash-completion)
if [ -e /opt/local/bin/bash ]; then 
	if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
		. /opt/local/etc/profile.d/bash_completion.sh
	fi
else
	echo "Not enabling bash-completion because the bash shell for it is not installed"
	echo "Install it with 'sudo port install bash-completion'" 
fi