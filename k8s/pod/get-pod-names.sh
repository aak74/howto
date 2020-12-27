#!/usr/bin/env bash

LABEL=app=event-processing
NAMESPACE=efox-prod

kubectl --namespace=$NAMESPACE get po -l $LABEL -o go-template --template='{{range .items}}{{ .metadata.name }}{{"\n"}}{{ end }}'
