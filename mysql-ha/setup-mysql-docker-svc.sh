#!/bin/sh
#
# Setup an HA service
#
set -e
set -x

apc namespace /mysqldemo

# cleanup
apc service delete mysql-docker --batch || true
apc provider delete mysql-docker-provider --batch || true

# 1. Assuming a proxy called mysql-proxy exists, create a provider
apc provider register mysql-docker-provider --type mysql -j mysql-master -u mysql://root:mysqlpw@mysql-proxy --port 3306 --batch

# 2. Create a service using the provider
apc service create mysql-docker -t mysql --provider mysql-docker-provider --batch
