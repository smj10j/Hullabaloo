#!/bin/bash

####TODO: install these daemons

# Nginx
alias nginx_start='sudo nginx'
alias nginx_stop='sudo nginx -s stop'
alias nginx_restart='nginx_stop && nginx_start'

# PHP-FPM
alias fpm_start='sudo port load php54-fpm'
alias fpm_stop='sudo port unload php54-fpm'
alias fpm_restart='fpm_stop && fpm_start'

# Local MySQL
alias mysql_start='sudo /opt/local/share/mysql5/mysql/mysql.server start'
alias mysql_stop='sudo /opt/local/sfhare/mysql5/mysql/mysql.server stop'
alias mysql_restart='mysql_stop && mysql_start'

# Remote MySQL
alias m='mysql -uextrabux -pebadmin28 extrabux -A'
alias slavedb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-readslave1.extrabux.com extrabux -A'
alias masterdb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-master.extrabux.com extrabux -A'
alias stagingdb='mysql -usmj10j -pw5hanBF4jzS2cEA4ndKX97at -h db-staging1.extrabux.com extrabux -A'

# Other utilities
alias mt='mytop -uextrabux -p'lookaway\!@#4' -h '
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias vhosts='sudo vi /opt/local/etc/nginx/sites-available/extrabux && sudo vi /etc/hosts && nginx_restart'

