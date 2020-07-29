# PersistentVolumeClaim & PersistentVolume


## Endless terminating

[stackoverflow](https://stackoverflow.com/questions/51358856/kubernetes-cant-delete-persistentvolumeclaim-pvc)
```sh
kubectl patch pvc $PVC_NAME -p '{"metadata":{"finalizers": []}}' --type=merge
```

[githib](https://github.com/kubernetes/kubernetes/issues/69697#issuecomment-448541618)
```sh
kubectl patch pvc db-pv-claim -p '{"metadata":{"finalizers":null}}'
kubectl patch pod db-74755f6698-8td72 -p '{"metadata":{"finalizers":null}}'
```

[githib](https://github.com/kubernetes/kubernetes/issues/77258#issuecomment-514543465)
```sh
kubectl get pv | tail -n+2 | awk '{print $1}' | xargs -I{} kubectl patch pv {} -p '{"metadata":{"finalizers": null}}'
```