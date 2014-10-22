#!/bin/bash
#
# This script runs the mysql-proxy
#

set -x

IDS=(${MYSQL_IDS})
MASTER_ID=${IDS[0]}
SLAVE_IDS=${IDS[@]:1}
BACKENDS=""

for id in ${SLAVE_IDS} ; do



        mysql --host=${IP_PREFIX}.${id} \
                --user=root \
                --password=mysqlpw \
                -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl' WITH GRANT OPTION;"

        mysqlreplicate \
                --master=root:mysqlpw@${IP_PREFIX}.${MASTER_ID}:3306 \
                --slave=root:mysqlpw@${IP_PREFIX}.${id}:3306 \
                --rpl-user=repl:repl \
                --pedantic \
                --verbose
done

nohup mysqlfailover \
        --master=root:mysqlpw@${IP_PREFIX}.${MASTER_ID}:3306 \
        --discover-slaves-login=root:mysqlpw \
        --exec-post-failover=/mysql-proxy/post-failover.sh \
        --log=/tmp/failover.log \
        --pidfile=/tmp/failover.pid \
        --daemon=start \
        --verbose   </dev/null 2>&1 >/dev/null &

sleep 1
tail -30 /tmp/failover.log
