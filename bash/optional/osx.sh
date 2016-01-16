#!/bin/bash

# Stop if we're not on OSX
if [ `uname` != 'Darwin' ]; then
	return
fi

# Set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# homebrew at front of path (just in case)
pathsadd "$(brew --prefix)/bin:$(brew --prefix)/sbin"
manpathsadd "$(brew --prefix)/share/man"

# homebrew core utils at front of path
pathsadd "$(brew --prefix coreutils)/libexec/gnubin"
manpathsadd "$(brew --prefix)/opt/coreutils/libexec/gnuman"

# homebrew sqlite3 at front of path
pathsadd "$(brew --prefix sqlite)/bin"

# homebrew perl at front of path
# pathsadd "$(brew --prefix perl)/bin"

# Change the screenshot directory
function setScreenshotDirectory {
	if [ `defaults read com.apple.screencapture location` != "$1" ]; then
		echo "Changing the screenshot directory from `defaults read com.apple.screencapture location` to $1..."
		mkdir -p $1
		defaults write com.apple.screencapture location $1
		sudo killall SystemUIServer
	fi
}
#setScreenshotDirectory $SCREENSHOT_DIR

# Always show hidden files in Finder
function setFinderToAlwaysShowHiddenFiles {
	
	FINDER_NAME='Finder'
	if [[ "$(ps -e | grep $FINDER_NAME -c)" == "1" ]]; then FINDER_NAME='finder'; fi 
	# echo "Finder name is $FINDER_NAME"
	
	if [[ $(defaults read com.apple.$FINDER_NAME AppleShowAllFiles) == "FALSE" ]]; then
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

# Disable writing .DS_Store to network drives (http://support.apple.com/kb/HT1629)
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Enable text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

##### Coreutils with Homebrew #####
if [[ "$0" =~ bash$ ]]; then
    # Short of learning how to actually configure OSX, here's a hacky way to use
    # GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
fi
#############



#TODO: Periodically backup all configuration all settings
# defaults read > 


# If available, use the OSX trash when removing files
# brew install trash
if [[ $(which trash >/dev/null && echo $?) == 0 ]]; then
    alias rm='trash'
fi

# Better top
unset -f top &>/dev/null   
TOP_PATH=$(which top)
eval "function top { 
    $TOP_PATH -o time -O cpu -S -f -r -i 1 -n 30 -stats command,user,pid,pstate,time,cpu,threads,mem,vprvt,csw 
}"

# Sqlite with extensions
if [[ $(which sqlite3 >/dev/null && echo $?) == 0 ]]; then
    unset -f sqlite3 &>/dev/null   
    SQLITE_PATH=$(which sqlite3);
    eval "function sqlite3 { 
        $SQLITE_PATH -cmd '.load $(dirname $(dirname $SQLITE_PATH))/lib/libsqlitefunctions'
    }"
fi

# Clear Bluetooth cache
function _hullabaloo_clear_bluetooth_cache {
    NEW_FOLDER=$_HULLABALOO_INSTALL_DIR/.backup/bluetooth
    FILES=( '/Library/Preferences/com.apple.Bluetooth.plist'
            '/Library/Preferences/SystemConfiguration/com.apple.Bluetooth.plist'
            '~/Library/Preferences/ByHost/com.apple.Bluetooth.*.plist'
            '~/Library/Preferences/ByHost/com.apple.Bluetooth.plist' )

    echo "Turning Bluetooth off..."
    $_HULLABALOO_INSTALL_DIR/osx/toggleBluetooth.scpt
    
    echo "Removing Bluetooth plist files and storing them in $NEW_FOLDER..."
    for file in ${FILES[@]}; do 
        if [[ -f "$file" ]]; then 
            NEW_FILE="${NEW_FOLDER}${file}"
            mkdir -p $(dirname "$NEW_FILE") 2>&1 >/dev/null
            sudo mv -f "$file" "$NEW_FILE"
        fi
    done
    
    echo "Pausing 3 seconds..."
    sleep 3
    
    echo "Turning Bluetooth back on..."
    $_HULLABALOO_INSTALL_DIR/osx/toggleBluetooth.scpt
}


# Give us more breathing room
ulimit -n 65536
ulimit -u 2048


# Airport on the command line
# eg. airport -s
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
















