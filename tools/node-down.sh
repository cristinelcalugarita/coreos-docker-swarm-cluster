#!/bin/bash

set -o allexport
source /etc/custom-environment
set +o allexport

cluster_config_dir=/etc/coreos-docker-swarm-cluster
slack=$cluster_config_dir/tools/send-message-to-slack.sh

/usr/bin/etcdctl rm /nodes/${NODE_ROLE}s/${COREOS_PRIVATE_IPV4}

if [ "$NODE_ROLE" == "worker" ]; then
    docker swarm leave
fi

$slack -m "_${COREOS_PRIVATE_IPV4}_ is DOWN ($NODE_ROLE)" -u $SLACK_WEBHOOK_URL -c "$SLACK_CHANNEL"