```sh
iptables -A INPUT -m recent --name stoplist --update --seconds 3600 -j DROP
iptables -A INPUT -i eno1 -m recent --name stoplist --set -j DROP
```

```sh
# view stoplist
cat /proc/net/xt_recent/stoplist
```