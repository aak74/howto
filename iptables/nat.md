iptables -A FORWARD -i ens192 -o ens160 -s 10.0.1.0/24 -j ACCEPT
iptables -A FORWARD -i ens160 -o ens192 -d 10.0.1.0/24 -j ACCEPT

iptables -A POSTROUTING -t nat -o ens160 -j MASQUERADE
iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE


default via 10.0.10.1 dev eth0 
10.0.10.0/26 dev eth0 proto kernel scope link src 10.0.10.3 
10.0.10.96/28 via 10.0.10.2 dev eth0 
10.10.150.0/24 via 10.10.150.2 dev tun0 
10.10.150.2 dev tun0 proto kernel scope link src 10.10.150.1 
10.10.155.0/24 via 10.10.150.2 dev tun0 
10.10.156.0/24 via 10.10.150.2 dev tun0 
10.10.157.0/24 via 10.10.150.2 dev tun0 
10.10.158.0/24 via 10.10.150.2 dev tun0