#!/bin/bash

NAME="$1"

gcloud container clusters create $NAME \
    --zone=us-central1-c \
    --num-nodes=1 \
    --machine-type=n1-highmem-8
