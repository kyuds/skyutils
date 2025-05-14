#!/bin/bash

NAME="${1:-skylarge}"
echo "Using cluster name: $NAME"

gcloud container clusters create $NAME \
    --zone=us-central1-c \
    --num-nodes=1 \
    --machine-type=n1-highmem-32
