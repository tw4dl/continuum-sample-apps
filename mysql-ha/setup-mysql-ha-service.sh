#!/bin/sh
#
# Setup an HA service
#

cleanup()
{
  apc service delete mysql-ha --batch || true
  apc provider delete mysql-ha-provider --batch || true
}

# process common options
source ./setup-mysql-common.sh

# --- main ----

# 1. Assuming a proxy called mysql-proxy exists, create a provider
apc provider register mysql-ha-provider --type mysql -j mysql-proxy -u mysql://root:mysqlpw@mysql-proxy --port 4040 --batch

# 2. Create a service using the provider
apc service create mysql-ha -t mysql --provider mysql-ha-provider --batch
