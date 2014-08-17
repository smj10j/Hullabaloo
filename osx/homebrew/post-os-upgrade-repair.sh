#!/bin/bash


echo "Installing some compile tools because shit's about to GET DONE"
xcode-select --install
brew install apple-gcc42


echo "Manually pulling down the latest Homebrew from Git.."
cd /usr/local/Cellar
git reset --hard
git branch --set-upstream-to=origin master
git pull
cd ~


echo "Letting brew repair itself to the best of its ability..."
brew update
brew missing
brew doctor


echo "Re-linking every formula in brew..."
FORMULAS=(`brew list`);
for FORMULA in "${FORMULAS[@]}"
do 
    echo "brew unlink $FORMULA" && echo "brew link $FORMULA";
    OUTPUT=`brew unlink $FORMULA`;
    echo $OUTPUT;
    OUTPUT=`brew link $FORMULA`;
    echo $OUTPUT;
done


echo "Repairing python paths..."
brew unlink python
brew install python --universal --framework
brew link --overwrite python

curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
pip install -U setuptools
pip install -U virtualenv


echo "Repairing php55 paths..."
brew link --overwrite php55


echo "And making sure brew is now good-to-go..."
brew update
brew doctor
brew upgrade