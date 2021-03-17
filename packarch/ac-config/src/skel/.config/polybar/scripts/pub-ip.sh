#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1)

if pgrep -x openvpn > /dev/null; then
    echo VPN: $IP
else
    echo $IP
fi
