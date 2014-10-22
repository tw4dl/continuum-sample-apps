#!/bin/sh
#
# Using capsules to build Mysql HA
#

cleanup()
{
  for id in $MYSQL_IDS ; do
      apc job delete mysql-${id} --batch || true
  done
  apc capsule delete mysql-base --batch || true
  apc package delete --batch snapshot-mysql-base || true
}

# --- main ----

source ./setup-mysql-common.sh

# 1. Create a base capsule with packages needed to run mysql
echo "## make mysql base snapshot"
apc capsule create mysql-base --disk=1500 --image ubuntu-14.04 --allow-egress --batch
apc capsule connect mysql-base << SSHEOF
apt-get update -y
apt-get install -y mysql-client-5.6
apt-get install -y mysql-server-5.6
#bind to all, not just 127.0.0.1
sed -i 's/\(bind-address\s*=\s*127\)/#\1/g' /etc/mysql/my.cnf
cat << EOF > /etc/my.cnf
[mysqld]
gtid-mode=ON
log-bin=mysqld-bin
log-slave-updates
enforce-gtid-consistency
master-info-repository=TABLE
binlog-format=ROW
EOF
SSHEOF

# 2. Create snapshot of the capsule to use for the servers.
apc capsule snapshot mysql-base -n snapshot-mysql-base --batch
apc capsule delete mysql-base --batch || true


# 3. For each server, using the snapshot create a capsule and expose port 3306
echo "## make mysql jobs"
for id in ${MYSQL_IDS} ; do
        apc capsule create --disk=1500 -p snapshot-mysql-base mysql-${id} --allow-egress --batch
        apc capsule update mysql-${id} -pa 3306 --batch --optional
done


# 4. Setup job links between the capsules.  These are /32 routes that allow the MySQL servers to communicate with each other.
echo "## set up job links (will restart the jobs)"
for id in ${MYSQL_IDS} ; do
        link_to_mysql $id
done

# 5. Initialze the mysql instances so they can replicate
echo "## initialize mysql instances"
for id in ${MYSQL_IDS} ; do
        apc capsule connect mysql-${id} <<EOF
set -x
echo "host ID: $id"
echo "general-log=1" >>/etc/my.cnf
echo "general-log-file=/var/log/mysql/query.log" >>/etc/my.cnf
echo "report-host=${IP_PREFIX}.${id}" >>/etc/my.cnf
echo "report-port=3306" >>/etc/my.cnf
echo "server-id=${id}" >>/etc/my.cnf
service mysql start
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mysqlpw' WITH GRANT OPTION;"
mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
EOF
done
