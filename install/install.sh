#!/bin/bash

function banner {
	STR=${1:+" $1 "}
	STR=${STR:-####}
	FILL_SIZE=$(( (70 - ${#STR}) / 2 ))
	FILLL=$(printf '#%.0s'  $(seq 1 $FILL_SIZE))
	FILLR=$(printf '#%.0s'  $(seq 1 $(( $FILL_SIZE + (${#STR} % 2) ))))
	echo "$FILLL$STR$FILLR"
}

DEFAULT_INSTALL_DIR=$(echo ~/.hullabaloo)
export _HULLABALOO_INSTALL_DIR=${1:-$DEFAULT_INSTALL_DIR}
HULLABALOO_GITHUB_PATH="smj10j/Hullabaloo"

echo ""
banner
banner "Hullabaloo Installation"
banner "https://github.com/$HULLABALOO_GITHUB_PATH"
banner
echo ""

function confirmCmdSuccess {
	if [[ ! $? -eq 0 ]]; then
		echo ""
		echo "Aborting installation of Hullabaloo"
		echo ""
		exit 1
	fi
}

if [[ -e "$_HULLABALOO_INSTALL_DIR" ]]; then
	echo "It looks like you already have something in $_HULLABALOO_INSTALL_DIR"
	echo "Attempting to do a git pull and continue"
	cd "$_HULLABALOO_INSTALL_DIR"
	git pull
	confirmCmdSuccess
else
	echo "Cloning git@github.com:smj10j/Hullabaloo.git into $_HULLABALOO_INSTALL_DIR..."
	mkdir -p "$_HULLABALOO_INSTALL_DIR"
	git clone "git@github.com:$HULLABALOO_GITHUB_PATH.git" "$_HULLABALOO_INSTALL_DIR"
	confirmCmdSuccess
	cd "$_HULLABALOO_INSTALL_DIR"
fi
echo ""


echo "Checking out submodules..."
git submodule init
confirmCmdSuccess
git submodule update
confirmCmdSuccess
echo ""



# OSX-Specific installs
if [[ $(uname) == 'Darwin' ]]; then
	if [[ -z $(which brew) ]]; then

		echo ""
		echo "#######################################################"
		echo "Installing Homebrew"
		echo ""
		echo "Your root password may be requested"
		echo "#######################################################"
		echo ""
		source "$_HULLABALOO_INSTALL_DIR/install/install-homebrew.sh"
		confirmCmdSuccess
		echo ""
	fi
fi

echo "Installing vimrc from https://github.com/amix/vimrc..."
rm -rf ~/.vim_runtime
ln -s "$_HULLABALOO_INSTALL_DIR/editors/vim/amix-vimrc" ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
confirmCmdSuccess
echo ""

echo "Creating user-editable versions of template files..."
for TPL_FILE in bash/user/.*.tpl; do
	TPL_FILE_COPY=`echo "${TPL_FILE%\.tpl}" | sed 's/\/\./\//g'`
	echo "Copying template file $TPL_FILE to $TPL_FILE_COPY"
	cp $TPL_FILE $TPL_FILE_COPY
	confirmCmdSuccess
done
echo ""

echo "Loading in our newly added profiles..."
source "$_HULLABALOO_INSTALL_DIR/bash/main.bashrc" -v
echo ""


if [[ -n "$SSH_HOME" ]]; then
    if [[ $(grep -c "Hullabaloo" "$SSH_HOME/config") == "0" ]]; then
        echo "Adding custom .ssh/config..."
        cat "$_HULLABALOO_INSTALL_DIR/bash/templates/.ssh/config" >> "$SSH_HOME/config"
    fi
fi



echo "Determining bash profile script..."
BASHRC_FILE=$(_hullabaloo_bashrc_file)
BASH_PROFILE_INCLUDE_START='############## Begin Hullabaloo Bash Profile ##############'
BASH_PROFILE_INCLUDE_END='############### End Hullabaloo Bash Profile ###############'


# Check if it's already installed...
if [[ $(grep "source $_HULLABALOO_INSTALL_DIR/bash/main.bashrc" -c $BASHRC_FILE) -gt 0 ]]; then
	echo "It appears Hullabaloo is already installed"
	echo "Not adding duplicate 'source' line to $BASHRC_FILE"
	echo "You're all set!"
	echo ""
else
	# Nope! Full steam ahead

	echo "Will install Hullabaloo loader in $BASHRC_FILE...";
	echo ""

	echo "$BASH_PROFILE_INCLUDE_START" >> $BASHRC_FILE
	echo "export _HULLABALOO_INSTALL_DIR=$_HULLABALOO_INSTALL_DIR" >> $BASHRC_FILE
	echo 'source $_HULLABALOO_INSTALL_DIR/bash/main.bashrc' >> $BASHRC_FILE
	echo "$BASH_PROFILE_INCLUDE_END" >> $BASHRC_FILE
fi

#NOTE: Can also change default shell with: chsh -s /opt/local/bin/bash

echo ""
echo "Install complete!"
echo "Opening $_HULLABALOO_INSTALL_DIR/bash/config/variables.bashrc so you can make any necessary modifications..."
echo ""

read -e -p "Press enter to open $_HULLABALOO_INSTALL_DIR/bash/config/variables.bashrc..." key
echo ""
edit bash/config/variables.bashrc

_hullabaloo_reload
