#!/bin/bash

# will start on 8 vcpus. can force trigger autoscale
# via requesting a job with like 12 vcpus

# kubectl get events --watch --sort-by='.lastTimestamp' -o custom-columns=TIMESTAMP:.lastTimestamp,TYPE:.type,REASON:.reason,OBJECT:.involvedObject.name,MESSAGE:.message

NAME="${1:-skytest}"
NODE_POOL="${2:-pool16vcpu}"

echo "Using cluster name: $NAME with autoscaling pool $NODE_POOL"

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
    --max-nodes 8
