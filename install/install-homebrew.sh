#!/bin/bash

if [ -z `which brew` ]; then

	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	confirmCmdSuccess

	echo "Running Brew Doctor..."
	brew doctor
	confirmCmdSuccess

	
	echo "Adding common Brew taps..."
	brew tap homebrew/dupes
	brew tap josegonzalez/homebrew-php

	######### Installing Global Brews ##########

	echo "Installing git..."
	brew install git

	echo "Installing wget..."
	brew install wget --enable-iri
	
	echo "Updating existing Mac coreutils ones..."
	brew install coreutils

	echo "Installing findutils (find, locate, etc.)..."
	brew install findutils

	echo "Installing bash-completion..."
	brew install git bash-completion
	

	######### Installing Development Brews ##########

	echo "Installing Nginx..."
	brew install nginx

	echo "Installing MySQL..."
	brew install mysql
	
	echo "Installing Mongo..."
	brew install mongodb
	
	echo "Installing Memcached..."
	brew install libevent
	brew install memcached
	brew install libmemcached
	
	echo "Installing PHP-FPM..."
	brew install php55 --without-apache --with-intl --with-fpm --with-mysql
	
	echo "Installing PHP libraries..."
	brew install php55-apcu
	brew install php55-xdebug
	brew install php55-mongo
	brew install php55-mcrypt
	brew install php55-intl
	brew install php55-memcache
	brew install php55-memcached
	
	


	######### Configuring brews ##########


	echo "Setting Nginx, MySQL, PHP-FPM, and Memcached to run at launch..."
	ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
	ln -sfv /usr/local/opt/php55/*.plist ~/Library/LaunchAgents
	ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
	ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents

	echo "Configuring MySQL via mysql_secure_installation..."
	mysql.server start
	mysql_secure_installation




	######### Launching Initial Installs ##########
	launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist 
	launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
	launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist



	### Potential brew doctor error 
	### 	Error: Failed to import: abstract-php-versions
	### 	uninitialized constant AbstractPhpVersions
	### can be fixed with:
	### https://github.com/josegonzalez/homebrew-php/issues/768#issuecomment-30846449


	############## Done ###################

	echo ""
	echo "Update your .bash_profile HOMEBREW_GITHUB_API_TOKEN with a personal Github token created here: https://github.com/settings/applications"
	echo "#export HOMEBREW_GITHUB_API_TOKEN=" >> ~/.bash_profile
	echo ""


else
    echo "Homebrew is already installed..."
    echo ""
fi

if [ -z `which brew` ]; then
    echo "Homebrew installation was unsuccessful - aborting"
    exit 1
fi











