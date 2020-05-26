# ETCD

## Команды
```sh
ETCDCTL_API=3 etcdctl --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --cacert=/etc/kubernetes/pki/etcd/ca.crt snapshot save snapshot.db


# compact up to revision 3
etcdctl compact 3
```

