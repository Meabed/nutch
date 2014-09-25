#!/bin/bash

export PATH=$PATH:/usr/local/sbin/
export PATH=$PATH:/usr/sbin/
export PATH=$PATH:/sbin

# Save Enviroemnt Variables incase ot attach to the container with new tty
env | awk '{split($0,a,"\n"); print "export " a[1]}' > /etc/env_profile

cassandra_env="$CASSANDRA_NODE_NAME"_PORT_9160_TCP_ADDR
cassandra_ip=$(printenv $cassandra_env)

iptables -t nat -I PREROUTING -p tcp -d 127.0.0.1 --dport 9160 -j DNAT --to-destination $cassandra_ip:9160

if [[ $1 == "-d" ]]; then
    while true; do
        sleep 1000;
    done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
