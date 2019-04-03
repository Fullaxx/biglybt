#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

source /app/imagestart.sh

/app/biglybtcheck.sh
/app/openvpn.sh || bail "openvpn startup failed!"

source /app/tiger.sh
