#!/bin/bash

if [ -n ${LOGFILE} ]; then
  TIMESTAMP=`date "+%y%m%d-%H%M%S"`
  echo "${TIMESTAMP}: OPENVPN GOING DOWN - ACTIVATING KILLSWITCH" >> /out/${LOGFILE}
fi

/app/killswitch.sh
