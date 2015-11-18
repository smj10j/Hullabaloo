#
# .profile
# Launched whenever a shell starts (.bash_profile loads this)
#
SCRIPT_NAME=$(echo "$0" | sed 's/^-\(.*\)/shell-\1/' | xargs basename)
if [ "$DEBUG" != "" -o -f .DEBUG ]; then echo "sourcing $SCRIPT_NAME..."; fi


######################## Don't modify below here ###################################
####################################################################################


### Homebrew ###
export HOMEBREW_GITHUB_API_TOKEN=
 
### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"



#eval "$(rbenv init -)"
