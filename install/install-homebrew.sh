#!/bin/bash

if [ -z `which brew` ]; then

	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

	echo "Running Brew Doctor..."
	brew doctor

	echo "Update your .bash_profile HOMEBREW_GITHUB_API_TOKEN with a personal Github token created here: https://github.com/settings/applications"
	echo "#export HOMEBREW_GITHUB_API_TOKEN=" >> ~/.bash_profile

else
    echo "Homebrew is already installed..."
    echo ""
fi

if [ -z `which brew` ]; then
    echo "Homebrew installation was unsuccessful - aborting"
    exit 1
fi

echo "Installing bash-completion..."
brew install git bash-completion
echo ""

