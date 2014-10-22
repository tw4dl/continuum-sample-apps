#!/bin/sh
#
# mysql-ha common script.  Contains variables and functions that are shared
# by the other scripts
#
set -e

IP_PREFIX=192.168.2
MYSQL_IDS="1 2"

usage() { echo "Usage: $0 [-c] [-h] [-n namespace]" 1>&2; exit 1; }

setNamespace()
{
  apc namespace ${1}
}

## sets up job links to all MySQL jobs (except itself)
link_to_mysql() {
        from_id=$1

        for id in $MYSQL_IDS ; do
                if [[ "$id" != "$from_id" ]] ; then
                        apc job link mysql-${from_id} \
                                --batch \
                                --target=mysql-${id} \
                                -port=3306 \
                                --name=MYSQL_${id} \
                                --bound-ip=${IP_PREFIX}.${id} \
                                --bound-port=3306
                fi
        done
}

while getopts "chn:" o; do
    case "${o}" in
        c)
            CLEANUP=1
            ;;
        n)
            NAMESPACE=${OPTARG}
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

set -x

if [ -n "$NAMESPACE" ] ; then
    setNamespace ${NAMESPACE}
fi

if [ -n "${CLEANUP}" ] ; then
    cleanup
    exit 0
fi
