#!/bin/sh
#
#
# A simply mysql client which gets a table in a loop.
#

apc capsule connect mysql-client-reader <<'EOF'
U=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f4`
P=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f5`
H=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f6`
O=`echo $MYSQLHA_URI | sed -e s/[\/\:\@]/,/g | cut -d, -f7`
while true ; do
  mysql --user=${U} --password=${P} --host=$H --port=${O} -e 'select name, TIME(time) from checkrep order by time desc limit 10;'
  sleep 1
  echo "========================================"
done
EOF
