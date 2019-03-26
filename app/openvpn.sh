#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

OVPNSLEEPTIME=${OVPNSLEEPTIME:-5}

if [ x"${OVPNCFG}" != "x" ]; then
  if [ ! -r /config/${OVPNCFG} ]; then bail "/config/${OVPNCFG} not available!"; fi
  openvpn --config /config/${OVPNCFG} --daemon \
  --script-security 2 --up /app/up.sh --down /app/down.sh
  sleep ${OVPNSLEEPTIME}
fi
