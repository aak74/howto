#!/usr/bin/env bash

LABEL=app=event-processing
NAMESPACE=efox-prod

OLDEST_POD_CREATED_AT=$(kubectl --namespace=$NAMESPACE get pod -l $LABEL -o go-template --template='{{range .items}}{{ .metadata.creationTimestamp }}{{"\n"}}{{ end }}' | sort -u | head -n 1)

echo $OLDEST_POD_CREATED_AT

PODS=$(kubectl --namespace=$NAMESPACE get pod -l $LABEL -o go-template --template='{{range .items}}{{ .metadata.name }}{{"\n"}}{{ end }}')

for POD in $PODS
do
  CREATED_AT=$(kubectl --namespace=$NAMESPACE get pod $POD -o go-template --template='{{ .metadata.creationTimestamp }}{{"\n"}}')
  if [[ "$CREATED_AT" = "$OLDEST_POD_CREATED_AT" ]]; then
    OLDEST_POD=$POD
  fi
done

kubectl --namespace=$NAMESPACE logs -f --tail=50 -c php $OLDEST_POD