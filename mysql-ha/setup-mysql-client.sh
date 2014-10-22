#!/bin/sh
#
#

cleanup()
{
  apc capsule delete mysql-client --batch || true
  apc package delete mysql-client-snapshot --batch || true
}

# process common options
source ./setup-mysql-common.sh

# --- main ----

# 1. Create the capsule
apc capsule create mysql-client --image linux --allow-egress --batch

# 2. Setup the configure the capsule
apc capsule connect mysql-client <./configure-mysql-client.sh

# 3. Make a snapshot
apc capsule snapshot mysql-client --name mysql-client-snapshot --link --batch

# 4. Bind to the service
apc service bind mysql-ha -j mysql-client --batch
