#!/bin/bash

if [ -z `which port` ]; then

    VERSION=`sw_vers -productVersion`
    VERSION=${VERSION%.*}

    echo "Attempting to install MacPorts for OSX version $VERSION..."
    echo ""

    if [ "$VERSION" == "10.9" ]; then
        curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.2.1-10.9-Mavericks.pkg
        open -W MacPorts-2.2.1-10.9-Mavericks.pkg
        rm -rf MacPorts-2.2.1-10.9-Mavericks.pkg
    elif [ "$VERSION" == "10.8" ]; then
        curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.2.1-10.8-MountainLion.pkg
        open -W MacPorts-2.2.1-10.8-MountainLion.pkg
        rm -rf MacPorts-2.2.1-10.8-MountainLion.pkg
    elif [ "$VERSION" == "10.7" ]; then
        curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.2.1-10.7-Lion.pkg
        open -W MacPorts-2.2.1-10.7-Lion.pkg
        rm -rf MacPorts-2.2.1-10.7-Lion.pkg
    else
        echo "Only Lion and above is supported - check here: http://www.macports.org/install.php#installing to install for an older OS"
        exit 1
    fi
else
    echo "MacPorts is already installed..."
    echo ""
fi

if [ -z `which port` ]; then
    echo "MacPorts installation was unsuccessful - aborting"
    exit 1
fi

echo "Installing bash-completion..."
port install bash-completion; 
echo ""

