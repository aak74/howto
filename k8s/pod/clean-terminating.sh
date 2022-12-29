#!/usr/bin/env bash

# Force delete po in Terminating status

CONTEXT=nl
NAMESPACE=processing-prod
#NAMESPACE=pb-extra-prod
#NAMESPACE=pb-conn

for p in $(kubectl get pods --context="$CONTEXT" -n "$NAMESPACE" | grep Terminating | awk '{print $1}'); do
  kubectl delete pod "$p" --grace-period=0 --force --context="$CONTEXT" -n "$NAMESPACE"
done
