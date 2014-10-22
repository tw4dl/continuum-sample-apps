#!/bin/sh
#
# This script will cleanup the MySQL demo objects

#!/bin/sh
#
#

cleanup()
{
  ./setup-mysql-client.sh -c
  ./setup-mysql-ha-service.sh -c
  ./setup-mysql-proxy.sh -c
  ./setup-master-slave-capsule.sh -c
}

# process common options
source ./setup-mysql-common.sh

# --- main ---
#
cleanup
echo -n "Cleaned up " `apc namespace`
