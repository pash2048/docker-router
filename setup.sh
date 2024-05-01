#!/bin/bash

set -x
set -e

## Replace DST_SERVER_IP and DST_SERVER_PORT with actual value
# DST_SERVER_IP="2.2.2.2"
# apt-get -y update; apt-get -y install curl iptables
DST_SERVER_IP="185.80.196.112"
DST_SERVER_PORT="30008"
# DST_SERVER_IP="185.80.196.112"
# DST_SERVER_PORT="30008"

## Replace RELAY_SERVER_IP and RELAY_SERVER_PORT with actual value
RELAY_SERVER_IP="37.32.21.176"
RELAY_SERVER_PORT="22222"

# sudo iptables-save > "iptables-rules-backup-$(date '+%Y-%m-%d-%H:%M:%S').v4"

# echo 1 | tee /proc/sys/net/ipv4/ip_forward

sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport "${RELAY_SERVER_PORT}" -j DNAT --to-destination "${DST_SERVER_IP}:${DST_SERVER_PORT}"
sudo iptables -t nat -A PREROUTING -p udp -m udp --dport "${RELAY_SERVER_PORT}" -j DNAT --to-destination "${DST_SERVER_IP}:${DST_SERVER_PORT}"

sudo iptables -t nat -A POSTROUTING -p tcp -m tcp -d "${DST_SERVER_IP}" --dport "${DST_SERVER_PORT}" -j SNAT --to-source "${RELAY_SERVER_IP}"
sudo iptables -t nat -A POSTROUTING -p udp -m udp -d "${DST_SERVER_IP}" --dport "${DST_SERVER_PORT}" -j SNAT --to-source "${RELAY_SERVER_IP}"
ping 4.2.2.4