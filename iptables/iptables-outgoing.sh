#!/bin/bash

# allow incoming ssh packets
iptables -A INPUT -p tcp --dport 22 -i eno2 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -i eno2 -j ACCEPT

# allow all outgoing traffic (except invalid packets)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -i eno1 -j ACCEPT
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT  -i eno1 -j DROP


