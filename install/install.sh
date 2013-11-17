#!/bin/bash

echo ""
echo "################################################################"
echo "################ DevEnvironment Installation ###################"
echo "######## https://bitbucket.org/smj10j/devenvironment ###########"
echo "################################################################"
echo ""

INSTALL_DIR=${INSTALL_DIR:-~/.smj10j/DevEnvironment}

if [ -e ~/.bash_profile ]; then
	echo "It looks like you already have something in $INSTALL_DIR"
	echo "Attempting to do a git pull and continue"
	cd $INSTALL_DIR
	git pull
else
	echo "Cloning git@bitbucket.org:smj10j/devenvironment.git into $INSTALL_DIR..."
	mkdir -p $INSTALL_DIR
	git clone git@bitbucket.org:smj10j/devenvironment.git $INSTALL_DIR
	cd $INSTALL_DIR
fi
echo ""

echo "Checking out submodules..."
git submodule init && git submodule update
echo ""

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
	echo "	/opt/local/bin/bash -l" >> $BASH_PROFILE_FILE
	echo "	exit 0" >> $BASH_PROFILE_FILE
	echo "fi" >> $BASH_PROFILE_FILE
	echo "source $INSTALL_DIR/bash/main.bashrc" >> $BASH_PROFILE_FILE
	echo "#######################################################" >> $BASH_PROFILE_FILE
fi


echo ""
echo "Install complete!"
echo "Now reloading your shell so the changes take effect immediately..."
echo ""

source $BASH_PROFILE_FILE
echo ""
exit 0


