#!/bin/sh
#
# A simple MySQL client that creates a table, then writes to it in a loop


apc capsule connect mysql-client <<'EOF'
U=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f4`
P=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f5`
H=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f6`
O=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f7`

set -x
mysql --user=${U} --password=${P} --host=$H --port=${O} \
  -e 'create table checkrep (name varchar(20), time datetime) ;'

i=0
while true ; do
  i=$((i+1))
  mysql --user=${U} --password=${P} --host=$H --port=${O} \
    -e "insert into checkrep (name, time) values (\"check-${i}\", SYSDATE()) ;"
  sleep 5
done
EOF
