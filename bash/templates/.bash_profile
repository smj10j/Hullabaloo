#
# .bash_profile
# Launched whenever a non-login, interactive bash shell starts
#




####################################################################################
######################## Don't modify below here ###################################
####################################################################################

# Run the system-wide profile 
# It should contain predominantly environment variable configurations
# and commands to launch programs at login
if [ -r ~/.profile ]; then . ~/.profile; fi

# Run our bash-specific startup
# Predominantly aliases, function definitions, prompt settings, and shell options
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

