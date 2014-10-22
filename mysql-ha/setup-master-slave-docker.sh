#!/bin/sh
#
# Docker Mysql HA
#
#

cleanup()
{
  for id in $MYSQL_IDS ; do
      apc job delete mysql-${id} --batch || true
  done
}

source ./setup-mysql-common.sh

# --- main ----

# 1. Create mysql backends with replication parameters using docker.
#    Parameters are passed on the commandline

MYSQL_COMMON_OPTS="--user=mysql --datadir=/var/lib/mysql --gtid-mode=ON --log-bin=mysqld-bin --log-slave-updates --enforce-gtid-consistency --master-info-repository=TABLE --binlog-format=ROW"

# for each backend ID defined in common
for id in $MYSQL_IDS ; do
    name="mysql-$id"
    MYSQL_OPTS="--server-id=$id --report-host=${IP_PREFIX}.${id} --report-port=${id} ${MYSQL_COMMON_OPTS}"

    # no slave specific options (yet)
    if [ ${id} != "1" ] ; then
        SLAVE_OPTS=""
    else
        SLAVE_OPTS=""
    fi

    apc docker run \
        -i mysql \
        -t 5.6 \
        -p 3306 \
        -auto-restart \
        -e 'MYSQL_ROOT_PASSWORD=mysqlpw' \
        -s "/bin/sh -c \"cd /usr/local/mysql && /bin/sh -x /entrypoint.sh mysqld ${MYSQL_OPTS} ${SLAVE_OPTS}\"" \
        ${name}
done

# 2. Stop the jobs to avoid thrashing
for id in ${MYSQL_IDS} ; do
    apc app stop mysql-${id} --batch
done


# 3. Job link slaves to each other
for id in ${MYSQL_IDS} ; do
        link_to_mysql $id
done

# 4. Start the jobs, ignore temporary failures
for id in ${MYSQL_IDS} ; do
    apc app start mysql-${id} --batch || true
done

# 5. List the jobs for visual inspection
apc job list
