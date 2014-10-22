#!/bin/sh
#
# Mysql HA
#
set -e
set -x

#!/bin/sh
#
# This script will cleanup the MySQL demo objects

#!/bin/sh
#
#

cleanup()
{
    echo -n "Cleaning up ... "
  ./setup-mysql-client-reader.sh -c
  ./setup-mysql-client.sh -c
  ./setup-mysql-ha-service.sh -c
  ./setup-mysql-proxy.sh -c
  ./setup-master-slave-capsule.sh -c
}

# process common options
source ./setup-mysql-common.sh

cleanup

# --- main ---
#
echo -n "Setting up demo on " `apc namespace`

./setup-master-slave-capsule.sh
./setup-mysql-proxy.sh
./setup-mysql-ha-service.sh
# sleep here for a short time to wait for the service to be ready
sleep 2
./setup-mysql-client.sh
