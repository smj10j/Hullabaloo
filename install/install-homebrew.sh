#!/bin/bash

if [ -z $(which brew) ]; then

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
	brew reinstall git

	# http://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
	echo "Updating existing Mac coreutils..."
	brew reinstall coreutils
	brew reinstall binutils
	brew reinstall diffutils
	brew reinstall ed --default-names
	brew reinstall findutils --default-names
	brew reinstall gawk
	brew reinstall gnu-indent --default-names
	brew reinstall gnu-sed --default-names
	brew reinstall gnu-tar --default-names
	brew reinstall gnu-which --default-names
	brew reinstall gnutls --default-names
	brew reinstall grep --default-names
	brew reinstall gzip
	brew reinstall screen
	brew reinstall watch
	brew reinstall wdiff --with-gettext
	brew reinstall wget --enable-iri

	echo "Installing bash-completion..."
	brew reinstall git bash-completion
	

	######### Installing Development Brews ##########

	echo "Installing Nginx..."
	brew reinstall nginx

	echo "Installing MySQL..."
	brew reinstall mysql
	
	echo "Installing Mongo..."
	brew reinstall mongodb
	
	echo "Installing Memcached..."
	brew reinstall libevent
	brew reinstall memcached
	brew reinstall libmemcached
	
	echo "Installing PHP-FPM..."
	brew reinstall php55 --without-apache --with-intl --with-fpm --with-mysql
	
	echo "Installing PHP libraries..."
	brew reinstall php55-apcu
	brew reinstall php55-xdebug
	brew reinstall php55-mongo
	brew reinstall php55-mcrypt
	brew reinstall php55-intl
	brew reinstall php55-memcache
	brew reinstall php55-memcached
	
	


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

	BASH_PROFILE_FILE=$(_hullabaloo_bash_profile_file)

	echo ""
	echo "Update your .bash_profile HOMEBREW_GITHUB_API_TOKEN with a personal Github token created here: https://github.com/settings/applications"
	echo "" >> $BASH_PROFILE_FILE
	echo "#export HOMEBREW_GITHUB_API_TOKEN=" >> $BASH_PROFILE_FILE
	echo ""

	echo ""
	echo "Adding coreutils prefix to brew"
	echo "" >> $BASH_PROFILE_FILE
	echo "##### Coreutils with Homebrew #####" >> $BASH_PROFILE_FILE
	echo "export PATH=\"\$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:\$PATH\"" >> $BASH_PROFILE_FILE
	echo "# From: https://gist.github.com/quickshiftin/9130153" >> $BASH_PROFILE_FILE
	echo "# Short of learning how to actually configure OSX, here's a hacky way to use" >> $BASH_PROFILE_FILE
	echo "# GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise" >> $BASH_PROFILE_FILE
	echo "alias man='_() { echo \$1; man -M \$(brew --prefix)/opt/coreutils/libexec/gnuman \$1 1>/dev/null 2>&1;  if [ \"\$?\" -eq 0 ]; then man -M \$(brew --prefix)/opt/coreutils/libexec/gnuman \$1; else man \$1; fi }; _'" >> $BASH_PROFILE_FILE
	echo "#############" >> $BASH_PROFILE_FILE
	echo ""


else
    echo "Homebrew is already installed..."
    echo ""
fi

if [ -z $(which brew) ]; then
    echo "Homebrew reinstallation was unsuccessful - aborting"
    exit 1
fi











