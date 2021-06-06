# Creating new user for Kubernetes

This is howto inspired by this [article](https://itnext.io/let-you-team-members-use-kubernetes-bf2ebd0be717).

1. Create certificate for new user
1. Create RoleBinding
1. Create config for user


## Create certificate for new user
```shell
{
# Create private key
openssl genrsa -out user-viewer.key 2048
# Create Certificate Signing Request
openssl req -new -key user-viewer.key -out user-viewer.csr -subj '/CN=viewer/O=developer'
# Create certificate
openssl x509 -req -in user-viewer.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out user-viewer.crt -days 365
}
```

## Create RoleBinding
```shell
kubectl create rolebinding viewer-cluster-admin-binding --clusterrole=view --user=viewer -n your-namespace
```

## Create config for user
Send for user files:
- ca.crt
- user_viewer.crt
- user_viewer.key

### Option 1
```shell
{
# Set CLUSTER_NAME and URL
kubectl config set-cluster <CLUSTER_NAME> --server=https://<URL> 
kubectl config set-cluster <CLUSTER_NAME> --certificate-authority=ca.crt 
kubectl config set-credentials viewer --client-key=user_viewer.key --client-certificate=user_viewer.crt
kubectl config set-context <CLUSTER_NAME> --user=viewer --cluster <CLUSTER_NAME>
kubectl config use-context <CLUSTER_NAME>
}
```

### Option 2 for advanced users
```shell
# base64 CA certificate
cat ca.crt | base64 -w 0
# base64 certificate
cat user_viewer.crt | base64 -w 0
# base64 private key
cat user_viewer.key | base64 -w 0

# Insert values into ~/.kube/config file
```
