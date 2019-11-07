#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

OVPNSLEEPTIME=${OVPNSLEEPTIME:-6}
CONFIGFILE="/config/${OVPNCFG}"

if [ ! -r ${CONFIGFILE} ]; then bail "${CONFIGFILE} not available!"; fi
openvpn --config ${CONFIGFILE} --daemon --script-security 2 \
  --log /var/log/openvpn/openvpn.log --up /app/up.sh --down /app/down.sh

OVPID=`pgrep openvpn`
if [ x"${OVPID}" == "x" ]; then
  bail "openvpn is not running!"
fi

echo "Sleeping ${OVPNSLEEPTIME}s while we wait for openvpn to settle ..."
sleep ${OVPNSLEEPTIME}
