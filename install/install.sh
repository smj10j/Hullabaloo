#!/bin/bash

echo "Cloning git@bitbucket.org:smj10j/devenvironment.git..."
git clone git@bitbucket.org:smj10j/devenvironment.git
cd devenvironment
git submodule init && git submodule update

echo "Installing vimrc from https://github.com/amix/vimrc..."
sh editors/vim/amix-vimrc/install_awesome_vimrc.sh

