#!/bin/bash

if [ -z $(which brew) ]; then

	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	confirmCmdSuccess

	./install/reinstall-homebrew.sh

	echo "Configuring MySQL via mysql_secure_installation..."
	mysql_secure_installation


	echo ""
	echo "Update your .bash_profile HOMEBREW_GITHUB_API_TOKEN with a personal Github token created here: https://github.com/settings/applications"
	echo "Update with a personal Github token created here: https://github.com/settings/applications" >> $(_hullabaloo_bashrc_file)
	echo "" >> $(_hullabaloo_bashrc_file)
	echo "#export HOMEBREW_GITHUB_API_TOKEN=" >> $(_hullabaloo_bashrc_file)
	echo ""

else
    echo "Homebrew is already installed, reinstall all required packages..."
    echo ""

	./install/reinstall-homebrew.sh

fi

if [ -z $(which brew) ]; then
    echo "Homebrew installation was unsuccessful - aborting"
    exit 1
fi











