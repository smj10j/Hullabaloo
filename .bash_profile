PATH=/opt/local/bin:/opt/local/sbin:/opt/local/libexec/perl5.12/sitebin:$PATH


alias edit='open -a BBEdit'

ebh='/Users/steve/Code/Extrabux/Extrabux-Complete'
alias ebh='cd $ebh'

alias exo='cd ~/Code/Exosphere/'


SVN_EDITOR='vi'

# mysql
alias mysql_start='sudo /opt/local/share/mysql5/mysql/mysql.server start'
alias mysql_stop='sudo /opt/local/share/mysql5/mysql/mysql.server stop'
alias mysql_restart='mysql_stop && mysql_start'
# nginx
alias nginx_start='sudo nginx'
alias nginx_stop='sudo nginx -s stop'
alias nginx_restart='nginx_stop && nginx_start'
#php-fpm
alias fpm_start='sudo port load php54-fpm'
alias fpm_stop='sudo port unload php54-fpm'
alias fpm_restart='fpm_stop && fpm_start'

alias m='mysql -uextrabux -pebadmin28 extrabux -A'
alias slavedb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-readslave1.extrabux.com extrabux -A'
alias masterdb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-master.extrabux.com extrabux -A'
alias stagingdb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-staging1.extrabux.com extrabux -A'
alias mt='mytop -uextrabux -p'lookaway\!@#4' -h '
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'


alias s='~/Code/Extrabux/DevTools/scripts/short-ssh.sh'

alias vhosts='sudo vi /opt/local/etc/nginx/sites-available/extrabux && sudo vi /etc/hosts && nginx_restart'

lso() { stat -f '%Sp %p %N' ${1:-*} | rev | sed -E 's/^([^[:space:]]+)[[:space:]]([[:digit:]]{4})[^[:space:]]*[[:space:]]([^[:space:]]+)/\1 \2 \3/' | rev; }; lso; lso ~/.ssh/

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

source ~/.git-completion.bash
