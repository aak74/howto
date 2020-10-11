iptables -A OUTPUT -d 80.0.0.1 -p tcp --sport 80 -m quota --quota 1000000000 -j ACCEPT
iptables -A OUTPUT -d 80.0.0.1 -p tcp --sport 80  -j DROP