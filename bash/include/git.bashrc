#!/bin/bash

#git aliases from http://www.jperla.com/blog/post/teach-yourself-git-in-2-minutes
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

git config --global color.ui true
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
