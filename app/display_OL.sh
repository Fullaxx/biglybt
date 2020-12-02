#!/bin/bash

if [ -f /var/log/openvpn/openvpn.log ]; then
  tail -n 20 /var/log/openvpn/openvpn.log | xmessage -nearmouse -file -
else
  xmessage -nearmouse "/var/log/openvpn/openvpn.log not found!"
fi
