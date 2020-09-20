#!/usr/bin/env bash

# Get docker config for k8s secret same as [here](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-by-providing-credentials-on-the-command-line)

set -e

REGISTRY="https://registry.example.com/v1/"
USERNAME="docker.pull.user"
PASSWORD="SecretPassword"
EMAIL="user@example.com"

AUTH=$(echo -n $USERNAME:$PASSWORD | base64 -w 0)

CONFIG="{\"$REGISTRY\":{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"email\":\"$EMAIL\",\"auth\":\"$AUTH\"}}"

echo -n "$CONFIG" | base64 -w 0
