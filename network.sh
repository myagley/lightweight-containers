#!/usr/bin/env bash

if [ ! -z ${DEBUG} ]; then
    set -x
fi

NETCONFPATH=${NETCONFPATH:-/etc/cni/net.d}
CNI_PATH=${CNI_PATH:-/usr/local/bin}
RUNC_ROOT=${RUN_ROOT:-/var/run/runc}

exec_plugins() {
    i=0
    name=$(echo "$2" | jq '.id' -r)
    pid=$(echo "$2" | jq '.pid' -r)

    export CNI_COMMAND=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    export CNI_CONTAINERID="$name"
    export CNI_PATH=$CNI_PATH
    export CNI_ARGS=""
    export CNI_NETNS="/proc/$pid/ns/net"

    cnitool $1 mynet $CNI_NETNS
    exit $?
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 add|del"
    exit 1
fi

read state

exec_plugins $1 $state
