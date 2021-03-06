#!/bin/bash

BACKUP_PORT_FILE=`echo ~`"/Installed-MacPorts-"`date +"%Y-%m-%d"`".backup.txt"
BACKUP_PORTS_OPT_LOCAL_DIR="/opt/macports_backup_local"

echo "Backing up list of installed MacPorts to $BACKUP_PORT_FILE..."
sudo port installed > $BACKUP_PORT_FILE

echo "Uninstalling all MacPorts..."
sudo port -f uninstall installed

echo "Backing up old MacPorts /opt/local to $BACKUP_PORTS_OPT_LOCAL_DIR..."
sudo mv /opt/local $BACKUP_PORTS_OPT_LOCAL_DIR

echo "Cleaning up old MacPorts directories..."
sudo rm -rf /opt/local
sudo rm -rf /Applications/DarwinPorts
sudo rm -rf /Applications/MacPorts
sudo rm -rf /Library/LaunchDaemons/org.macports.*
sudo rm -rf /Library/Receipts/DarwinPorts*.pkg
sudo rm -rf /Library/Receipts/MacPorts*.pkg
sudo rm -rf /Library/StartupItems/DarwinPortsStartup
sudo rm -rf /Library/Tcl/darwinports1.0
sudo rm -rf /Library/Tcl/macports1.0
sudo rm -rf ~/.macports

source install/install-homebrew.sh


echo "Now install all your old MacPorts..."