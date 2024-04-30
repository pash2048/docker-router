#!/bin/bash

set -x
set -e

## Replace DST_SERVER_IP and DST_SERVER_PORT with actual value
# DST_SERVER_IP="2.2.2.2"
apt-get -y update; apt-get -y install curl
DST_SERVER_IP=$(curl "echoip.ir")
DST_SERVER_PORT="22222"

## Replace RELAY_SERVER_IP and RELAY_SERVER_PORT with actual value
RELAY_SERVER_IP="185.80.196.112"
RELAY_SERVER_PORT="30008"

sudo iptables-save > "iptables-rules-backup-$(date '+%Y-%m-%d-%H:%M:%S').v4"

echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

sudo iptables -t nat -A PREROUTING -p tcp --dport "${RELAY_SERVER_PORT}" -j DNAT --to-destination "${DST_SERVER_IP}:${DST_SERVER_PORT}"
sudo iptables -t nat -A PREROUTING -p udp --dport "${RELAY_SERVER_PORT}" -j DNAT --to-destination "${DST_SERVER_IP}:${DST_SERVER_PORT}"

sudo iptables -t nat -A POSTROUTING -p tcp -d "${DST_SERVER_IP}" --dport "${DST_SERVER_PORT}" -j SNAT --to-source "${RELAY_SERVER_IP}"
sudo iptables -t nat -A POSTROUTING -p udp -d "${DST_SERVER_IP}" --dport "${DST_SERVER_PORT}" -j SNAT --to-source "${RELAY_SERVER_IP}"

ping 4.2.2.4