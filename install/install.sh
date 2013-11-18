#!/bin/bash

echo ""
echo "################################################################"
echo "################ DevEnvironment Installation ###################"
echo "######## https://bitbucket.org/smj10j/devenvironment ###########"
echo "################################################################"
echo ""

INSTALL_DIR=${INSTALL_DIR:-~/.smj10j/DevEnvironment}

function confirmCmdSuccess {
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "Aborting installation of DevEnvironment"
		echo ""
		exit 1
	fi
}

if [ -e $INSTALL_DIR ]; then
	echo "It looks like you already have something in $INSTALL_DIR"
	echo "Attempting to do a git pull and continue"
	cd $INSTALL_DIR
	git pull
	confirmCmdSuccess
else
	echo "Cloning git@bitbucket.org:smj10j/devenvironment.git into $INSTALL_DIR..."
	mkdir -p $INSTALL_DIR
	git clone git@bitbucket.org:smj10j/devenvironment.git $INSTALL_DIR
	confirmCmdSuccess
	cd $INSTALL_DIR
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
if [ -e ~/.bash_profile ]; then
	BASH_PROFILE_FILE=~/.bash_profile
elif [ -e ~/.bashrc ]; then
	BASH_PROFILE_FILE=~/.bashrc
else
	echo "No existing bash profile files found, creating one"
	BASH_PROFILE_FILE=~/.bash_profile
	touch $BASH_PROFILE_FILE
fi
echo "Will install in $BASH_PROFILE_FILE...";
echo ""

# Check if it's already installed...
if [ `grep "source $INSTALL_DIR/bash/main.bashrc" -c $BASH_PROFILE_FILE` -gt 0 ]; then
	echo "It appears these tools are already installed"
	echo "You're all up to date!"
	echo "Not adding duplicate 'source' line to $BASH_PROFILE_FILE"
	echo ""
else
	# Nope! Full steam ahead
	echo "############## Custom Bash Profile from  ##############" >> $BASH_PROFILE_FILE
	echo "## Docs: https://bitbucket.org/smj10j/devenvironment ##" >> $BASH_PROFILE_FILE
	echo 'if [ `ps -p $$ | grep -c "/opt/local/bin/bash"` -eq 0 ]; then' >> $BASH_PROFILE_FILE
	echo "	if [ -e /opt/local/bin/bash ]; then " >> $BASH_PROFILE_FILE
	echo "		/opt/local/bin/bash -l" >> $BASH_PROFILE_FILE
	echo "		exit 0" >> $BASH_PROFILE_FILE
	echo "	fi" >> $BASH_PROFILE_FILE
	echo "fi" >> $BASH_PROFILE_FILE
	echo "source $INSTALL_DIR/bash/main.bashrc" >> $BASH_PROFILE_FILE
	echo "#######################################################" >> $BASH_PROFILE_FILE
fi

# Can also change default shell with: chsh -s /opt/local/bin/bash

echo ""
echo "Install complete!"
echo "Now installing a new Terminal profile and opening a new shell so the changes take effect immediately..."
echo ""

open osx/smj10j.terminal && exit 0

