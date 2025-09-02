#!/bin/bash

for i in {1..6}; do
    sky launch --infra k8s --cpus 0.1 --memory 0.2 --async -y
done

