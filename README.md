Hullabaloo
==========

All my various settings



Installation
------------

Run the following in your shell
The installation directory can be changed if desired (defaults to ~/.smj10j/Hullabaloo)
```bash 
	export INSTALL_DIR=; curl -s https://raw.github.com/smj10j/Hullabaloo/master/install/install.sh | /bin/bash && exit 0
```


TODO
----

1. ssh
2. cd pushing/popping
3. periodic backups
4. enhanced text-editor selection/install
5. daemon installation


What's Included
---------------

##### Files
- `edit <file|directory>` - quickly open files in BBEdit from Terminal
- `lso [file|directory]` - ls with permissions in octal
<pre>
drwxr-xr-x 0755 Code/smj10j/Hullabaloo/.git
-rw-r--r-- 0644 Code/smj10j/Hullabaloo/.gitignore
-rw-r--r-- 0644 Code/smj10j/Hullabaloo/.gitmodules
-rw-r--r-- 0644 Code/smj10j/Hullabaloo/README.md
drwxr-xr-x 0755 Code/smj10j/Hullabaloo/bash
drwxr-xr-x 0755 Code/smj10j/Hullabaloo/editors
drwxr-xr-x 0755 Code/smj10j/Hullabaloo/install
</pre>
	
	
##### Paths
- `pathsadd <path string>` - gracefully manages appending a string of paths to the $PATH variable
- `pathadd <directory>` - adds a single directory (if not present) to the $PATH variable

##### Arrays
- Array functions including:
	- `array_push <arr> <el>` - push an element onto the end of the array
	- `array_pop <arr> [<el>]` - pops an element off the end of an array into [optionally supplied] variable $el
	- `array_shift <arr> <el>` - push an element onto the front of the array
	- `array_unshift <arr> [<el>]` - pops an element off the front of the array into [optionally supplied] variable $el
	
##### Pretty Printing
- #TODO
		
##### SSH
- Automatically starts ssh-agent and adds private keys
- `ssh` bash completion - users your ~/.ssh/known_hosts file to auto-complete hostnames as you type

##### Vim
- [Custom vimrc](https://github.com/amix/vimrc) - in Amix's words, "The Ultimate vimrc"

##### Git
- [Git Aliases](http://www.jperla.com/blog/post/teach-yourself-git-in-2-minutes)
<pre>
alias ad='git add'
alias pl='git pull'
alias ph='git push'
alias cm='git commit -m'
alias sl='git status -uall'
alias lg='git log'
alias gp='git grep'
alias de='git diff --ignore-space-change'
alias me='git merge'
alias bh='git branch'
alias ct='git checkout'
</pre>

##### OSX 
- Sets the screenshot directory to  ~/Screenshots
- Sets Finder to always show hidden files
- `listRegisteredURLSchemes` - lists the currently registered URL schemes
- [Bash-completion](http://trac.macports.org/wiki/howto/bash-completion)



Customization
---------------

- In `Hullabaloo/bash/includes`
	- `shortcuts.bashrc` - Custom aliases go here
	- `variables.bashrc` - Configurable variables used in the other .bashrc scripts go here


Screenshots
-----------

#### Pretty Terminal Profile
![Pretty Terminal Profile](https://raw.github.com/smj10j/Hullabaloo/master/screenshots/Pretty-Terminal.png "Pretty Terminal")

#### To install - Set new windows to open with the 'smj10j' profile in Terminal
![To install - Set new windows to open with the 'smj10j' profile in Terminal](https://raw.github.com/smj10j/Hullabaloo/master/screenshots/Set-Terminal-Profile.png "Set Terminal Profile")

#### Pretty Vim
![Pretty Vim](https://raw.github.com/smj10j/Hullabaloo/master/screenshots/Pretty-Vim.png "Pretty Vim")
	
#### View Registered URL Schemes with [RCDefaultApp](http://www.rubicode.com/Software/RCDefaultApp/)
![RCDefaultApp - View Registered URL Schemes](https://raw.github.com/smj10j/Hullabaloo/master/screenshots/RCDefaultApp.png "RCDefaultApp - View Registered URL Schemes")
		
		
		
		
		
		
