#!/bin/bash

# Flush rules chain
iptables -F DOCKER-USER
iptables -F DOCKER-IN

# Remove user chain
iptables -X DOCKER-IN

# Create user chain
iptables -N DOCKER-IN

iptables -A FORWARD -j DOCKER-USER

# Filter requests to internal services from networks diff from docker bridge
iptables -A DOCKER-USER -d 172.16.0.0/12 ! -s 172.16.0.0/12 -j DOCKER-IN

# Return to parent chain
iptables -A DOCKER-USER -j RETURN

# Enable all requests from local network
iptables -A DOCKER-IN -s 10.0.0.0/12 -j RETURN

# Drop external requests to 5601 port (Kibana)
iptables -A DOCKER-IN -p tcp --dport 5601 -j DROP

# Enable all requests from developers
iptables -A DOCKER-IN -s 5.167.93.59 -j ACCEPT # kopylov
iptables -A DOCKER-IN -s 91.107.27.189 -j ACCEPT # ageev
iptables -A DOCKER-IN -s 185.155.17.36 -j ACCEPT # nikekhin

# Disable all other requests
iptables -A DOCKER-IN -j LOG # log for debug purposes
iptables -A DOCKER-IN -j DROP