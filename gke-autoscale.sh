#!/bin/bash

# will start on 8 vcpus. can force trigger autoscale
# via requesting a job with like 12 vcpus

NAME="${1:-skytest}"
echo "Using cluster name: $NAME"

gcloud container clusters create $NAME \
    --zone us-central1-c \
    --machine-type n1-standard-8 \
    --num-nodes 1 \
    --enable-autoscaling \
    --min-nodes 1 \
    --max-nodes 3

# Add 16 vCPU node pool  
gcloud container node-pools create pool-16vcpu \
    --cluster $NAME \
    --zone us-central1-c \
    --machine-type n1-standard-16 \
    --num-nodes 0 \
    --enable-autoscaling \
    --min-nodes 0 \
    --max-nodes 3
