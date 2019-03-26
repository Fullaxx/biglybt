#!/bin/bash

OVPNSLEEPTIME=${OVPNSLEEPTIME:-5}

if [ x"${OVPNCFG}" != "x" ]; then
  openvpn --config /openvpn/${OVPNCFG} --daemon \
  --script-security 2 --up /app/up.sh --down /app/down.sh || exit 1
  sleep ${OVPNSLEEPTIME}
fi
