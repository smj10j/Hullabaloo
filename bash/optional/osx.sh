#!/bin/bash

# Stop if we're not on OSX
if [ `uname` != 'Darwin' ]; then
	return
fi

# Set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

#
# NOTE: The below paths are now properly added by using
# configuration files placed in
# /etc/manpaths.d/ and /etc/paths.d/
#
# homebrew at front of path (just in case)
# pathsadd "$(brew --prefix)/bin:$(brew --prefix)/sbin"
# manpathsadd "$(brew --prefix)/share/man"
#
# # homebrew core utils at front of path
# pathsadd "$(brew --prefix)/opt/coreutils/libexec/gnubin"
# manpathsadd "$(brew --prefix)/opt/coreutils/libexec/gnuman"
#
# homebrew sqlite3 at front of path
# pathsadd "$(brew --prefix)/opt/sqlite/bin"
#
# homebrew perl at front of path
# pathsadd "$(brew --prefix perl)/bin"


# Alias to show registered URL schemes
function listRegisteredURLSchemes {
	LS_REGISTER_CMD='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
	$LS_REGISTER_CMD -dump | grep -B6 bindings:.*:
}


#TODO: Periodically backup all configuration all settings
# defaults read >


# If available, use the OSX trash when removing files
# brew install trash
which trash && alias rm=trash

# Recommended way to use which from which manual
# Commented-out after reading https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then
# which () {
#     (alias; declare -f; which whence) | /usr/local/bin --tty-only --read-alias --read-functions --show-tilde --show-dot $@
# }
# export -f which

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
        $SQLITE_PATH -cmd '.load $(dirname $(dirname "$SQLITE_PATH"))/lib/libsqlitefunctions'
    }"
fi

# Clear Bluetooth cache
function hullabaloo_clear_bluetooth_cache {
    NEW_FOLDER=$_HULLABALOO_INSTALL_DIR/.backup/bluetooth
    FILES=( "/Library/Preferences/com.apple.Bluetooth.plist"
            "/Library/Preferences/SystemConfiguration/com.apple.Bluetooth.plist"
            ~/"Library/Preferences/ByHost/com.apple.Bluetooth.*.plist"
            ~/"Library/Preferences/ByHost/com.apple.Bluetooth.plist" )

    echo "Turning Bluetooth off..."
    "$_HULLABALOO_INSTALL_DIR/osx/toggleBluetooth.scpt"

	echo "Pausing 3 seconds..."
	sleep 3

    echo "Removing Bluetooth plist files and storing them in $NEW_FOLDER..."
    for file in "${FILES[@]}"; do
        if [[ -f "$file" ]]; then
            NEW_FILE="${NEW_FOLDER}${file}"
            mkdir -p '$(dirname "$NEW_FILE)' >/dev/null 2>&1
            sudo mv -f "$file" "$NEW_FILE"
        fi
    done

    echo "Pausing 3 seconds..."
    sleep 3

    echo "Turning Bluetooth back on..."
    "$_HULLABALOO_INSTALL_DIR/osx/toggleBluetooth.scpt"
}



# Airport on the command line
# eg. airport -s
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
