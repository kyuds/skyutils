#!/bin/bash
NAME="${1:-skytest}"
echo "Using cluster name: $NAME"

# Create the cluster with CPU node pool as default
echo "Creating GKE cluster with CPU node pool as default..."
gcloud container clusters create "$NAME" \
    --zone=us-central1-c \
    --num-nodes=1 \
    --machine-type=n1-highmem-16 \
    --enable-ip-alias \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --maintenance-window="03:00" \
    --node-labels=type=cpu,cloud.google.com/gke-accelerator= \
    --verbosity=info

# Create GPU node pool
echo "Creating GPU node pool..."
gcloud container node-pools create gpu-pool \
    --cluster="$NAME" \
    --zone=us-central1-c \
    --num-nodes=1 \
    --machine-type=n1-highmem-16 \
    --accelerator type=nvidia-tesla-t4,count=1 \
    --node-labels=type=gpu \
    --scopes=https://www.googleapis.com/auth/cloud-platform \

