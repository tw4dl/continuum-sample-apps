#!/bin/bash
#

set -x

apt-get update -y
apt-get install mysql-client-5.6 -y

#apt-get install mysql-proxy -y
wget -q http://dev.mysql.com/get/Downloads/MySQL-Proxy/mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit.tar.gz
tar xvf mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit.tar.gz
mkdir -p /opt
mv mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit /opt/mysql-proxy

mv run-mysql-proxy.sh /opt/mysql-proxy/bin
chmod +x /opt/mysql-proxy/bin/run-mysql-proxy.sh
LUA_DIR=/opt/mysql-proxy/lua
mkdir -p $LUA_DIR
mv usemaster.lua $LUA_DIR
mv adminm.lua $LUA_DIR

# install mysql-utilities (replicaion and failover)
apt-get install -y psmisc
apt-get install -y libaio1
apt-get install -y python
wget -q http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities_1.5.2-1ubuntu12.04_all.deb
wget -q http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python_2.0.1-1ubuntu12.04_all.deb
dpkg -i mysql-connector-python_2.0.1-1ubuntu12.04_all.deb
dpkg -i mysql-utilities_1.5.2-1ubuntu12.04_all.deb

mkdir -p /opt/mysql-utilities/bin
mv run-mysql-failover.sh /opt/mysql-utilities/bin
chmod +x /opt/mysql-utilities/bin/run-mysql-failover.sh
mv post-failover.sh /opt/mysql-utilities/bin
chmod +x /opt/mysql-utilities/bin/post-failover.sh
