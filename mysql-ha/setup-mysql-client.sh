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

# 2. Stop it
apc capsule stop mysql-client

# 3. Bind to the service
apc service bind mysql-ha -j mysql-client --batch

# 4. Create the capsule for the reader
apc capsule create mysql-client-reader --package mysql-snapshot --batch

# 5. Stop it
apc capsule stop mysql-client-reader

# 6. Bind to the service
apc service bind mysql-ha -j mysql-client-reader --batch

# 7. start both capsules
apc capsule start mysql-client
apc capsule start mysql-client-reader
