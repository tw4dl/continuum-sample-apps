#!/bin/bash
#

MYSQL_PROXY_ADMIN_IP=`echo $MYSQL_PROXY_ADMIN_URI | sed -e 's/tcp:\/\/\(.*\):[0-9]\+/\1/g'`
MYSQL_PROXY_ADMIN_PORT=`echo $MYSQL_PROXY_ADMIN_URI | sed -e 's/tcp:\/\/.*:\([0-9]\+\)/\1/g'`

/usr/bin/mysql --host=$MYSQL_PROXY_ADMIN_IP --port=$MYSQL_PROXY_ADMIN_PORT --user=root --password=mysqlpw -e "setmaster $3:$4;"

