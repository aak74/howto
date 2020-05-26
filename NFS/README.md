# Установка NFS

## Выполнить на сервере
```sh
# minimal install
apt install nfs-kernel-server

#create folder for mounting
mkdir /nfs

# add record for access
echo "/nfs\t10.0.1.0/24(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports

# export config
exportfs -a

# start service
systemctl start nfs-kernel-server

# enable service after reboot
systemctl enable nfs-kernel-server
```

## Выполнить на клиенте
```sh
# minimal install
apt install nfs-common

#create folder for mounting
mkdir /nfs

# create record for mount 
echo "10.0.1.105:/nfs    /nfs  nfs auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800 0 0" >> /etc/fstab

# mount folder
mount /nfs
```