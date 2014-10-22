# MySQL High Availability Example

The bash scripts in this directory contain a series of continuum based apc commands that illustrate how to use job links, providers, service gateways and capsules in order to build a multi job high availability MySQL active-standby cluster.  The techniques illustrated by this example can be reused to create any other type of replication or clustered system for other databases.

## Requirements

The MySQL service gateway must be setup with policy rules allowing the user to create a provider, service and bind to the service.
The Continuum CLI 'apc' must be installed on your system.
The scripts below need to be run on a unix system, or a system that emulates the bourne shell.

### Shortcut:

The `setup.sh` script executes the following steps in order. It may be easier to follow along if you execute them each by hand.

## Create a pair of MySQL servers

This script will start two capsules, install mysql 5.6, and prepare the two capsules for performing a master-slave replication:

```
./setup-master-slave-capsule.sh
```

## Create MySQL proxy

The MySQL proxy is a very common proxy that is often used with MySQL HA configurations.  This step sets up a capsule and an application container to be used as the proxy in the system.  The MySQL servers combined with the proxy will together create a MySQL provider.

```
./setup-mysql-proxy.sh
```

## Create a MySQL HA service

The next script will register the MySQL server and proxy jobs as a MySQL provider, then it will create a service to use that provider.  Any app or capsule which binds to the service will be using a semantic pipeline provided by Continuum.

```
./setup-mysql-ha-service.sh
```

## Create Clients

The script creates a pair of clients to use with the HA service.  The clients are capsules using mysql CLI as client applications.

```
./setup-mysql-client.sh
```

## Run the Client Tests

On one window run the following client script.  It will create a table and insert rows on that table every 5 seconds:

```
./run-mysql-client.sh
```

On another window run this reader script.  It will read the same table created by the writer, once a second:

```
./run-mysql-client-reader.sh
```

## Failover

You are now ready to test failover.  You can stop the MySQL master by connecting to the master and stopping the MySQL service.  We tested the failure in various ways.  The simiplest failure is a mysql process failure which was simulated as follows:

We first start monitors to make sure the failure is occurring correctly:

```
apc jobs logging mysql-proxy
```

We also want to monitor the failover script:

```
apc capsule connect mysql-proxy-admin <<EOF
tail -f /tmp/failover.log
EOF
```

Finally we simply kill a service or a job.

# Gentle death

```
apc capsule connect mysql-1 <<EOF
service mysql stop
EOF
```

# harsher death

```
apc job stop mysql-1
```
