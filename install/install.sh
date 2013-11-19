#!/bin/bash

echo ""
echo "################################################################"
echo "################ DevEnvironment Installation ###################"
echo "######## https://github.com/smj10j/DevEnvironment ###########"
echo "################################################################"
echo ""

DEV_ENVIRONMENT_INSTALL_DIR=${INSTALL_DIR:-~/.smj10j/DevEnvironment}

function confirmCmdSuccess {
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "Aborting installation of DevEnvironment"
		echo ""
		exit 1
	fi
}

if [ -e $DEV_ENVIRONMENT_INSTALL_DIR ]; then
	echo "It looks like you already have something in $DEV_ENVIRONMENT_INSTALL_DIR"
	echo "Attempting to do a git pull and continue"
	cd $DEV_ENVIRONMENT_INSTALL_DIR
	git pull
	confirmCmdSuccess
else
	echo "Cloning git@github.com:smj10j/DevEnvironment.git into $DEV_ENVIRONMENT_INSTALL_DIR..."
	mkdir -p $DEV_ENVIRONMENT_INSTALL_DIR
	git clone git@github.com:smj10j/DevEnvironment.git $DEV_ENVIRONMENT_INSTALL_DIR
	confirmCmdSuccess
	cd $DEV_ENVIRONMENT_INSTALL_DIR
fi
echo ""

echo "Checking out submodules..."
git submodule init
confirmCmdSuccess
git submodule update
confirmCmdSuccess
echo ""

# OSX-Specific installs
if [ `uname` == 'Darwin' ]; then
	echo "Installing required macports (your root password may be requested)..."
	echo ""
	sudo install/install-macports.sh
	confirmCmdSuccess
	echo ""
fi

echo "Installing vimrc from https://github.com/amix/vimrc..."
sh editors/vim/amix-vimrc/install_awesome_vimrc.sh
echo ""

echo "Determining bash profile script..."
if [ `uname` == 'Darwin' ]; then
	BASH_PROFILE_FILE=~/.bash_profile
else
	BASH_PROFILE_FILE=~/.bashrc
fi

if [ ! -e $BASH_PROFILE_FILE ]; then
	echo "No existing bash profile files found, creating $BASH_PROFILE_FILE"
	touch $BASH_PROFILE_FILE
fi
echo "Will install in $BASH_PROFILE_FILE...";
echo ""

# Check if it's already installed...
if [ `grep "source $DEV_ENVIRONMENT_INSTALL_DIR/bash/main.bashrc" -c $BASH_PROFILE_FILE` -gt 0 ]; then
	echo "It appears these tools are already installed"
	echo "You're all up to date!"
	echo "Not adding duplicate 'source' line to $BASH_PROFILE_FILE"
	echo ""
else
	# Nope! Full steam ahead
	echo "############## Custom Bash Profile  ##############" >> $BASH_PROFILE_FILE
	echo "## Docs: https://github.com/smj10j/DevEnvironment ##" >> $BASH_PROFILE_FILE
	echo 'if [ `ps -p $$ | grep -c "/opt/local/bin/bash"` -eq 0 ]; then' >> $BASH_PROFILE_FILE
	echo "	if [ -e /opt/local/bin/bash ]; then " >> $BASH_PROFILE_FILE
	echo "		/opt/local/bin/bash -l" >> $BASH_PROFILE_FILE
	echo "		exit 0" >> $BASH_PROFILE_FILE
	echo "	fi" >> $BASH_PROFILE_FILE
	echo "fi" >> $BASH_PROFILE_FILE
	echo "export DEV_ENVIRONMENT_INSTALL_DIR=$DEV_ENVIRONMENT_INSTALL_DIR" >> $BASH_PROFILE_FILE
	echo "source $DEV_ENVIRONMENT_INSTALL_DIR/bash/main.bashrc" >> $BASH_PROFILE_FILE
	echo "#######################################################" >> $BASH_PROFILE_FILE
fi

# Can also change default shell with: chsh -s /opt/local/bin/bash

echo ""
echo "Install complete!"
echo "Now installing a new Terminal profile and opening a new shell so the changes take effect immediately..."
echo ""

open osx/smj10j.terminal && exit 0

