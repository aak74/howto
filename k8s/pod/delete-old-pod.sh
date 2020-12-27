#!/usr/bin/env bash

LABEL=app=event-processing
NAMESPACE=efox-prod

PODS=$(kubectl --namespace=$NAMESPACE get pod -l $LABEL -o go-template --template='{{range .items}}{{ .metadata.name }}{{"\n"}}{{ end }}')

OLDEST_POD=''
OLDEST_POD_CREATED_AT='2222-12-31T23:59:29Z'

for POD in $PODS
do
  CREATED_AT=$(kubectl --namespace=$NAMESPACE get pod $POD -o go-template --template='{{ .metadata.creationTimestamp }}{{"\n"}}')
  echo $CREATED_AT $POD

  if [[ "$CREATED_AT" < "$OLDEST_POD_CREATED_AT" ]]; then
    OLDEST_POD_CREATED_AT=$CREATED_AT
    OLDEST_POD=$POD
  fi
done
echo last pod $OLDEST_POD_CREATED_AT $OLDEST_POD

kubectl --namespace=$NAMESPACE delete po $OLDEST_POD