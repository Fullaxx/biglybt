#!/bin/bash

ip addr show > /tmp/net_stats.txt
echo >> /tmp/net_stats.txt
ip route list >> /tmp/net_stats.txt
xmessage -nearmouse -file /tmp/net_stats.txt
rm -f /tmp/net_stats.txt
