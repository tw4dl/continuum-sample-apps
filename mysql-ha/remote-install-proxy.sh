#!/bin/bash
#

set -x

apt-get update -y
apt-get install mysql-client -y
apt-get install mysql-proxy -y

# install utility scripts
mkdir -p /mysql-proxy
mv run-mysql-failover.sh /mysql-proxy
chmod +x /mysql-proxy/run-mysql-failover.sh
mv run-mysql-proxy.sh /mysql-proxy
chmod +x /mysql-proxy/run-mysql-proxy.sh
mv post-failover.sh /mysql-proxy
chmod +x /mysql-proxy/post-failover.sh

LUA_DIR=/usr/share/mysql-proxy
mv usemaster.lua $LUA_DIR
mv adminm.lua $LUA_DIR

# install mysql-utilities (replication and failover)
apt-get install -y psmisc
apt-get install -y libaio1
apt-get install -y python
wget -q http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities_1.5.2-1ubuntu12.04_all.deb
wget -q http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python_2.0.1-1ubuntu12.04_all.deb
dpkg -i mysql-connector-python_2.0.1-1ubuntu12.04_all.deb
dpkg -i mysql-utilities_1.5.2-1ubuntu12.04_all.deb
