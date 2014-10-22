#!/bin/sh
#
#

cleanup()
{
  apc capsule delete mysql-client --batch || true
  apc capsule delete mysql-client-reader --batch || true
}

# process common options
source ./setup-mysql-common.sh

# --- main ----

# 1. Create the capsule
apc capsule create mysql-client --package mysql-snapshot --allow-egress --batch

# 4. Bind to the service
apc service bind mysql-ha -j mysql-client --batch

# 3. Create the capsule for the reader
apc capsule create mysql-client-reader --package mysql-snapshot --batch

# 4. Bind to the service
apc service bind mysql-ha -j mysql-client-reader --batch
