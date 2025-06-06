#!/bin/bash

NAME="${1:-skylarge}"
ZONE="us-central1-c"
echo "Using cluster name: $NAME"

gcloud container clusters create $NAME \
    --zone=$ZONE \
    --num-nodes=1 \
    --machine-type=n1-highmem-32
    
# n1-highmem-32
