# Pods stuck in Terminating status

```sh
kubectl delete pod --grace-period=0 --force --namespace <NAMESPACE> <PODNAME>
```