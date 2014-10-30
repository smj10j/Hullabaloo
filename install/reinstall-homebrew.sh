#!/bin/bash

echo "Running Brew Doctor..."
brew doctor
confirmCmdSuccess

echo "Adding common Brew taps..."
brew tap homebrew/dupes
brew tap homebrew/php

######### Installing Global Brews ##########

echo "Installing git..."
brew reinstall git
brew reinstall git-extras

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

echo "Installing keychain..."
brew reinstall keychain

echo "Copying bash/templates/usr/libexec/ssh-askpass to /usr/libexec/ssh-askpass..."
cp "$_HULLABALOO_INSTALL_DIR/bash/templates/usr/libexec/ssh-askpass" "/usr/libexec/ssh-askpass"


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
brew reinstall --without-apache --with-fpm --with-mysql php55


######### Configuring brews ##########


echo "Setting Nginx, MySQL, PHP-FPM, and Memcached to run at launch..."
ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
ln -sfv /usr/local/opt/php55/*.plist ~/Library/LaunchAgents
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents



######### Launching Initial Installs ##########
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
launchctl unload ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist
launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist
mysql.server stop
mysql.server start



############## Done ###################


echo "Running Brew Doctor..."
brew doctor
confirmCmdSuccess


### Potential brew doctor error
### 	Error: Failed to import: abstract-php-versions
### 	uninitialized constant AbstractPhpVersions
### can be fixed with:
### https://github.com/josegonzalez/homebrew-php/issues/768#issuecomment-30846449


