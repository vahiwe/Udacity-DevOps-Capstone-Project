#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="vahiwe/djangoapp"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run djangoapp\
    --generator=run-pod/v1\
    --image=$dockerpath\
    --port=8000 --labels app=djangoapp

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward djangoapp 8000:8000
