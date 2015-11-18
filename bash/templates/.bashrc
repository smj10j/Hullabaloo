#
# .bashrc
# Launched whenever a non-login, interactive bash shell starts
# .bash_profile also sources this file to keep things consistent
#
SCRIPT_NAME=$(echo "$0" | sed 's/^-\(.*\)/shell-\1/' | xargs basename)
if [ "$DEBUG" != "" -o -f .DEBUG ]; then echo "sourcing $SCRIPT_NAME..."; fi


############## Begin Hullabaloo Bash Profile ##############
export _HULLABALOO_INSTALL_DIR=~/.hullabaloo
source $_HULLABALOO_INSTALL_DIR/bash/main.bashrc
############### End Hullabaloo Bash Profile ###############

### Choose brew-installed sqlite
PATH="$(brew --prefix sqlite)/bin:$PATH"

### Init rbenv
# if [ "$DEBUG" != "" -o -f .DEBUG ]; then echo "rbenv: $(which rbenv)"; fi


