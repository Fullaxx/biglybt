#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

OVPNSLEEPTIME=${OVPNSLEEPTIME:-6}
CONFIGFILE="/config/${OVPNCFG}"

rm -f /var/log/openvpn/openvpn.log

if [ ! -r ${CONFIGFILE} ]; then bail "${CONFIGFILE} not available!"; fi
openvpn --config ${CONFIGFILE} --daemon --script-security 2 \
  --log /var/log/openvpn/openvpn.log --up /app/up.sh --down /app/down.sh

echo "Sleeping ${OVPNSLEEPTIME}s while we wait for openvpn to settle ..."
sleep ${OVPNSLEEPTIME}

if grep -q 'ERROR: Cannot open TUN/TAP dev /dev/net/tun' /var/log/openvpn/openvpn.log; then
  tail -n 2 /var/log/openvpn/openvpn.log
  bail "Could not enable TUN device! Validate docker run options: --cap-add=NET_ADMIN --device /dev/net/tun"
fi

if grep -q 'Exiting due to fatal error' /var/log/openvpn/openvpn.log; then
  tail -n 10 /var/log/openvpn/openvpn.log
  bail "openvpn is not running!"
fi

OVPID=`ps aux | grep -w openvpn | grep ${CONFIGFILE} | awk '{print $2}'`
if [ x"${OVPID}" == "x" ]; then
  tail -n 10 /var/log/openvpn/openvpn.log
  bail "openvpn is not running!"
fi

chmod 0644 /var/log/openvpn/openvpn.log
