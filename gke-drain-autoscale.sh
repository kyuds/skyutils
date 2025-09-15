#!/bin/bash

# Need to match node-pool name in gke-autoscale.sh

NAME="${1:-skytest}"

echo "Using cluster name: $NAME with autoscaling pool $NODE_POOL"

gcloud container clusters resize $NAME \
    --node-pool=pool-16vcpu \
    --zone=us-central1-c \
    --num-nodes=0
