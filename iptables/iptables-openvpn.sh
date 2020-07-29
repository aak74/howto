#!/bin/bash

# flushing all chains
iptables -F

# deleting all user-defined chains
iptables -X

# allow all outgoing traffic (except invalid packets)
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# allow incoming ssh packets
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

#create a new chain named OPENVPN
iptables -N OPENVPN

# jump from the FORWARD chain to the user-defined chain
# now packets traverse the iptables rules in the user-defined chain
iptables -A FORWARD -j OPENVPN

#if not dropped or accepted (terminating target) packets continue traversing the INPUT chain
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# iptables -P OUTPUT DROP
# iptables -P INPUT DROP
# iptables -P FORWARD DROP

# flushing nat table and POSTROUTING chain
iptables -t nat -F POSTROUTING

function allow_route {
    local NET_SOURCES=$1
    for NET_SOURCE in $NET_SOURCES
    do
        iptables -t nat -A POSTROUTING -s $NET_SOURCE -d 10.0.1.0/24 -j MASQUERADE
    done;
}

function allow_ping {
    local NET_SOURCES=$1
    local IPS=$2

    for NET_SOURCE in $NET_SOURCES
    do
        for IP in $IPS
        do
            iptables -A OPENVPN -p icmp -s $NET_SOURCE -d $IP -j ACCEPT
        done;
    done;
}

function allow_ports {
    local NET_SOURCES=$1
    local IPS=$2
    local PORTS=$3

    for NET_SOURCE in $NET_SOURCES
    do
        for IP in $IPS
        do
            iptables -A OPENVPN -p tcp -s $NET_SOURCE -d $IP -m multiport --dports $PORTS -j ACCEPT
        done;
    done;
}

function allow_all {
    local NET_SOURCES=$1
    local IPS=$2

    for NET_SOURCE in $NET_SOURCES
    do
        for IP in $IPS
        do
            iptables -A OPENVPN -s $NET_SOURCE -d $IP -j ACCEPT
        done;
    done;
}

# allow OPENVPN network to route into inner network
allow_route "10.0.45.0/24 10.0.46.0/24 10.0.47.0/24 10.0.48.0/24"

# ADMIN
allow_ping "10.0.45.0/24" "10.0.1.0/24"
allow_all "10.0.45.0/24" "0.0.0.0"

# DEVELOPER
allow_ping "10.0.46.0/24" "10.0.1.95 10.0.1.101 10.0.1.12 10.0.1.13"
allow_ports "10.0.46.0/24" "10.0.1.95 10.0.1.101" "80,443"
allow_ports "10.0.46.0/24" "10.0.1.12" "6432"
allow_ports "10.0.46.0/24" "10.0.1.13" "15432,15433,15434,18123"

# SUPPORT
allow_ping "10.0.47.0/24" "10.0.1.95 10.0.1.101 10.0.1.12 10.0.1.13"
allow_ports "10.0.47.0/24" "10.0.1.95 10.0.1.101" "80,443"
allow_ports "10.0.47.0/24" "10.0.1.12" "6432"
allow_ports "10.0.47.0/24" "10.0.1.13" "15432,18123"

# OFFICE
allow_ping "10.0.48.0/24" "10.0.1.95 10.0.1.101"
allow_ports "10.0.48.0/24" "10.0.1.95 10.0.1.101" "80,443"

iptables -A OPENVPN -j RETURN