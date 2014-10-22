#!/bin/sh
#
#

cleanup()
{
  apc capsule delete mysql-client-reader --batch || true
}

# process common options
source ./setup-mysql-common.sh

# --- main ----

# 1. Create the capsule
apc capsule create mysql-client-reader --package mysql-client-snapshot --batch

# 2. Bind to the service
apc service bind mysql-ha -j mysql-client-reader --batch
