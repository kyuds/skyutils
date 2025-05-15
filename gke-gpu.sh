#!/bin/bash

NAME="${1:-skytestwgpu}"
echo "Using cluster name: $NAME"

gcloud container clusters create "$NAME" \
    --zone=us-central1-c \
    --num-nodes=4 \
    --machine-type=n1-highmem-16 \
    --accelerator type=nvidia-tesla-t4,count=1 \
    --enable-ip-alias \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --maintenance-window "03:00" \
    --node-labels=type=gpu \
    --verbosity=info
