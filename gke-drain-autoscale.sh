#!/bin/bash

# Need to match node-pool name in gke-autoscale.sh

NAME="${1:-skytest}"
NODE_POOL="${2:-pool16vcpu}"

echo "Using cluster name: $NAME with autoscaling pool $NODE_POOL"

gcloud container node-pools resize $NODE_POOL \
    --cluster=$NAME \
    --zone=us-central1-c \
    --num-nodes=0
