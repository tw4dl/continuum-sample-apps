#!/bin/sh
#
# Docker Proxy setup
#

cleanup()
{
  rm -f ./configure-proxy-shar.sh
  apc capsule delete mysql-proxy-admin --batch || true
  apc app delete mysql-proxy --batch || true
  apc package delete mysql-proxy-snapshot --batch || true
}

# process common options
source ./setup-mysql-common.sh

# --- main ----

# 1. Create a capsule to setup the snapshot.  The mysql-proxy-admin serves as our administration capsule.
# From there we can connect to the proxy and the servers.
apc capsule create mysql-proxy-admin --image linux --allow-egress --batch

# 2. Create a shar with all the necessary scripts
shar run-mysql-failover.sh run-mysql-proxy.sh post-failover.sh usemaster.lua adminm.lua > /tmp/remote-proxy-shar.sh

# 3. Setup config files
apc capsule connect mysql-proxy-admin </tmp/remote-proxy-shar.sh
apc capsule connect mysql-proxy-admin <./remote-install-proxy.sh

# 4. Create snapshot and link it to our capsule
apc capsule snapshot mysql-proxy-admin --name mysql-proxy-snapshot --link --batch

# 5. Link to the servers
apc capsule stop mysql-proxy-admin
link_to_mysql proxy-admin
apc capsule start mysql-proxy-admin

# 6. run the backend setup replication script, this capsule is now disposable, but kept for debugging
echo "## initialize mysql instances"
for id in ${MYSQL_IDS} ; do
apc capsule connect mysql-proxy-admin <<EOF
set -x
/usr/bin/mysql --host=${IP_PREFIX}.${id} --port=3306 --user=root --password=mysqlpw -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mysqlpw' WITH GRANT OPTION;"
/usr/bin/mysql --host=${IP_PREFIX}.${id} --port=3306 --user=root --password=mysqlpw -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl' WITH GRANT OPTION;"
/usr/bin/mysql --host=${IP_PREFIX}.${id} --port=3306 --user=root --password=mysqlpw -e "FLUSH PRIVILEGES;"
EOF
done

# 7. Add env to package
apc package update mysql-proxy-snapshot --batch \
        --env-set "MYSQL_IDS=\"${MYSQL_IDS}\" IP_PREFIX=${IP_PREFIX}"

# 8. Create an app from the package
apc app from package mysql-proxy --disable-routes --package mysql-proxy-snapshot --start-cmd '/bin/sh -c /opt/mysql-proxy/bin/run-mysql-proxy.sh' --batch

# 9. Add a port to the capsule
apc app update mysql-proxy --port-add 4041 --batch
apc app update mysql-proxy --port-add 4040 --optional --batch


# 11. Link mysql-proxy to the servers
link_to_mysql proxy

# 10. Start the app
apc app start mysql-proxy

# 12. Link the admin capsule to mysql-proxy
apc job link mysql-proxy-admin -t mysql-proxy --port 4040 --name MYSQL_PROXY_SQL --batch
apc job link mysql-proxy-admin -t mysql-proxy --port 4041 --name MYSQL_PROXY_ADMIN --batch

# 12. Run the failover script
apc capsule connect mysql-proxy-admin <<'!'
set -x
/opt/mysql-utilities/bin/run-mysql-failover.sh
!
