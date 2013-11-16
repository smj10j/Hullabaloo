#!/bin/bash

# Enhance the path (mostly for MacPorts)
PATH=/opt/local/bin:/opt/local/sbin:/opt/local/libexec/perl5.12/sitebin:$PATH

# Change the screenshot directory
SCREENSHOT_DIR=~/Screenshots
mkdir -p $SCREENSHOT_DIR
defaults write com.apple.screencapture location $SCREENSHOT_DIR
killall SystemUIServer

# Always show hidden files in Finder
FINDER_NAME='Finder'
if [ "`ps -e | grep $FINDER_NAME -c`" == "1" ]; then FINDER_NAME='finder'; fi
if [ `defaults read com.apple.$FINDER_NAME AppleShowAllFiles` == "FALSE" ]; then
	echo "Enabling showing of hidden files everywhere..."
	defaults write com.apple.$FINDER_NAME AppleShowAllFiles TRUE
	sudo killall $FINDER_NAME
fi

# Alias to show registered URL schemes
alias listRegisteredURLSchemes='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump | grep -B6 bindings:.*:'
