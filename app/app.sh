#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

source /app/imagestart.sh

/app/biglybtcheck.sh

if [ x"${OVPNCFG}" != "x" ]; then
  /app/openvpn.sh || bail "openvpn startup failed!"
  /app/monitor.sh &
fi

source /app/tiger.sh
