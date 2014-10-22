#!/bin/bash
#
# This script runs the mysql-proxy
#

set -x
set -e

IDS=(${MYSQL_IDS})
MASTER_ID=${IDS[0]}
SLAVE_IDS=${IDS[@]:1}
BACKENDS=""

for id in ${MASTER_ID} ${SLAVE_IDS} ; do
        BACKENDS="--proxy-backend-addresses=${IP_PREFIX}.${id}:3306 $BACKENDS"
done
OPTIONS="--admin-address=:4041 --proxy-address=:4040 --log-level=debug --plugins=proxy --plugins=admin --admin-username=root --admin-password=mysqlpw --admin-lua-script=/opt/mysql-proxy/lua/adminm.lua --proxy-lua-script=/opt/mysql-proxy/lua/usemaster.lua ${BACKENDS}"

/opt/mysql-proxy/bin/mysql-proxy ${OPTIONS} &
PID=$!

while true ; do
  sleep 1
  /usr/bin/mysql --host=127.0.0.1 --port=4041 --user=root --password=mysqlpw -e "setmaster ${IP_PREFIX}.${MASTER_ID}:3306;" || continue
  break
done

wait $PID
