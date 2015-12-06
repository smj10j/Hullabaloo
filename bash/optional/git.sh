#!/bin/bash

# http://www.jperla.com/blog/post/teach-yourself-git-in-2-minutes
alias ad='git add'
alias pl='git pull'
alias ph='git push'
alias cm='git commit'
alias sl='git status -uall'
alias lg='git log'
alias gp='git grep'
alias de='git diff --ignore-space-change'
alias me='git merge'
alias bh='git branch'
alias ct='git checkout'
# alias cm='git commit -m'

# https://stackoverflow.com/questions/2553786/how-do-i-alias-commands-in-git
# alias gst='git status'
# alias gl='git pull'
# alias gp='git push'
# alias gd='git diff | mate'
# alias gau='git add --update'
# alias gc='git commit -v'
# alias gca='git commit -v -a'
# alias gb='git branch'
# alias gba='git branch -a'
# alias gco='git checkout'
# alias gcob='git checkout -b'
# alias gcot='git checkout -t'
# alias gcotb='git checkout --track -b'
alias glog='git gr'
# alias glogp='git log --pretty=format:"%h %s" --graph'

git config --global color.ui true
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
