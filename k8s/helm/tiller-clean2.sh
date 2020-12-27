#!/usr/bin/env bash

# Delete all release configmaps without namespace

CONTEXT=yc

set -e

function remove_revisions {
  local RELEASE=$1
  REVISIONS=$(kubectl --context $CONTEXT --namespace=kube-system get cm -l OWNER=TILLER -l NAME=$RELEASE | awk '{if(NR>1)print $1}' | sed 's/.*\.v//' | sort -n)
  NUM_REVISIONS=$(echo $REVISIONS | tr " " "\n" | wc -l)
  NUM_REVISIONS=$(($NUM_REVISIONS+0))

  echo "Release $RELEASE has $NUM_REVISIONS revisions."
  echo "Will delete all revisions"

  TO_DELETE=$(echo $REVISIONS | tr " " "\n")

  for DELETE_REVISION in $TO_DELETE
  do
    CMNAME=$RELEASE.v$DELETE_REVISION
    echo "Deleting $CMNAME"
    # Take a backup
    kubectl --context $CONTEXT --namespace=kube-system get cm $CMNAME -o yaml > configmaps/$CMNAME.yaml
    # Do the delete
    kubectl --context $CONTEXT --namespace=kube-system delete cm $CMNAME
  done
}

IFS=$'\n'
RELEASES=$(kubectl --context $CONTEXT --namespace=kube-system get cm -l OWNER=TILLER -o go-template --template='{{range .items}}{{ .metadata.labels.NAME }}{{"\n"}}{{ end }}' | sort -u)
unset IFS

NAMESPACES=$(kubectl --context $CONTEXT get ns -o go-template --template='{{range .items}}{{ .metadata.name }}{{"\n"}}{{ end }}')

# echo ${RELEASES[@]}
# echo "---"
# echo ${NAMESPACES[@]}

# exit 0


for RELEASE in $RELEASES
do
  # echo 1
  if [[ ! "${NAMESPACES[@]}" =~ "${RELEASE}" ]]; then
    # echo $RELEASE
    remove_revisions $RELEASE
  fi
done