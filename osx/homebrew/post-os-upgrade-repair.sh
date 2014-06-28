#!/bin/bash

xcode-select --install


brew install apple-gcc42


cd /usr/local/Cellar
git reset --hard
git branch --set-upstream-to=origin master
git pull
cd ~


brew update
brew missing
brew doctor



FORMULAS=(`brew list`);
for FORMULA in "${FORMULAS[@]}"
do 
    echo "brew unlink $FORMULA" && echo "brew link $FORMULA";
    OUTPUT=`brew unlink $FORMULA`;
    echo $OUTPUT;
    OUTPUT=`brew link $FORMULA`;
    echo $OUTPUT;
done

brew unlink python
brew install python --universal --framework

curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
pip install -U setuptools
pip install -U virtualenv



