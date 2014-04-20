#!/bin/bash

echo ""
echo "################################################################"
echo "################ Hullabaloo Installation ###################"
echo "######## https://github.com/smj10j/Hullabaloo ###########"
echo "################################################################"
echo ""

export _HULLABALOO_INSTALL_DIR=${INSTALL_DIR:-~/.smj10j/Hullabaloo}

function confirmCmdSuccess {
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "Aborting installation of Hullabaloo"
		echo ""
		exit 1
	fi
}

if [ -e $_HULLABALOO_INSTALL_DIR ]; then
	echo "It looks like you already have something in $_HULLABALOO_INSTALL_DIR"
	echo "Attempting to do a git pull and continue"
	cd $_HULLABALOO_INSTALL_DIR
	git pull
	confirmCmdSuccess
else
	echo "Cloning git@github.com:smj10j/Hullabaloo.git into $_HULLABALOO_INSTALL_DIR..."
	mkdir -p $_HULLABALOO_INSTALL_DIR
	git clone git@github.com:smj10j/Hullabaloo.git $_HULLABALOO_INSTALL_DIR
	confirmCmdSuccess
	cd $_HULLABALOO_INSTALL_DIR
fi
echo ""

echo "Checking out submodules..."
git submodule init
confirmCmdSuccess
git submodule update
confirmCmdSuccess
echo ""



OSX-Specific installs
if [ `uname` == 'Darwin' ]; then
	if [ -z `which brew` ]; then

		echo ""
		echo "#######################################################"
		echo "Installing Homebrew"
		echo ""
		echo "Your root password may be requested"
		echo "#######################################################"
		echo ""
		sudo install/install-homebrew.sh
		confirmCmdSuccess
		echo ""
	fi	
fi

echo "Installing vimrc from https://github.com/amix/vimrc..."
rm -rf ~/.vim_runtime
ln -s $_HULLABALOO_INSTALL_DIR/editors/vim/amix-vimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
confirmCmdSuccess
echo ""

echo "Creating user-editable versions of template files..."
for TPL_FILE in bash/user/.*.tpl; do 
	TPL_FILE_COPY=`echo "${TPL_FILE%\.tpl}" | sed 's/\/\./\//g'`
	echo "Copying template file $TPL_FILE to $TPL_FILE_COPY";
	cp $TPL_FILE $TPL_FILE_COPY; 
done
echo ""

echo "Loading in our newly added profiles..."
source bash/main.bashrc -v
echo ""

echo "Determining bash profile script..."
BASH_PROFILE_FILE=`_hullabaloo_bash_profile_file`

echo "Will install in $BASH_PROFILE_FILE...";
echo ""

# Check if it's already installed...
if [ `grep "source $_HULLABALOO_INSTALL_DIR/bash/main.bashrc" -c $BASH_PROFILE_FILE` -gt 0 ]; then
	echo "It appears these tools are already installed"
	echo "You're all up to date!"
	echo "Not adding duplicate 'source' line to $BASH_PROFILE_FILE"
	echo ""
else
	# Nope! Full steam ahead
	echo "############## Begin smj10j Bash Profile #################" >> $BASH_PROFILE_FILE# 
# 	echo "## Docs: https://github.com/smj10j/Hullabaloo ##" >> $BASH_PROFILE_FILE
# 	echo 'if [ `ps -p $$ | grep -v "grep" | grep -c "/opt/local/bin/bash"` -eq 0 ]; then' >> $BASH_PROFILE_FILE
# 	echo "	if [ -e /opt/local/bin/bash ]; then " >> $BASH_PROFILE_FILE
# 	echo "		echo \"Switching to updated bash shell...\"" >> $BASH_PROFILE_FILE
# 	echo "		/opt/local/bin/bash -l" >> $BASH_PROFILE_FILE
# 	echo "		exit 0" >> $BASH_PROFILE_FILE
# 	echo "	fi" >> $BASH_PROFILE_FILE
# 	echo "fi" >> $BASH_PROFILE_FILE
	echo "export _HULLABALOO_INSTALL_DIR=$_HULLABALOO_INSTALL_DIR" >> $BASH_PROFILE_FILE
	echo 'source $_HULLABALOO_INSTALL_DIR/bash/main.bashrc' >> $BASH_PROFILE_FILE
	echo "################ End smj10j Bash Profile #################" >> $BASH_PROFILE_FILE
fi

#NOTE: Can also change default shell with: chsh -s /opt/local/bin/bash

echo ""
echo "Install complete!"
echo "Opening $_HULLABALOO_INSTALL_DIR/bash/config/variables.bashrc so you can make any necessary modifications..."
echo ""

read -n1 -r -p "Press any key to open $_HULLABALOO_INSTALL_DIR/bash/config/variables.bashrc..." key
echo ""
edit bash/config/variables.bashrc

echo ""
echo "Now opening a new shell so the changes take effect immediately..."
echo ""

_hullabaloo_reload
