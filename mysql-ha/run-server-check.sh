#!/bin/sh -x
#
# This script runs the mysql-proxy
#

set -x
echo "Failover check params: $@" | tee -a /tmp/check.log


I=0
while true ; do
    if [ ${I} -eq 3 ] ; then
        echo "$@ Failed $I" >> /tmp/check.log
        exit 1
    fi
    /usr/bin/mysql --connect-timeout=1 --host=${3} --port=${4} --user=root --password=mysqlpw -e "select 1 ;"
    RET=$?
    if [ ${RET} -eq 0 ] ; then
        echo "$@ OK $I" >> /tmp/check.log
        break;
    fi
    echo "retrying $I"
    I=$((I+1))
done
exit 0
