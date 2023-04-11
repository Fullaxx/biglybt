#!/bin/bash

bail()
{
  ERRMSG="FAILED: $1"
  >&2 echo "${ERRMSG}"
  xmessage "${ERRMSG}" &
  exit 1
}

mkdir -p /in/autoload     || bail "mkdir -p /in/autoload"
mkdir -p /in/torrents     || bail "mkdir -p /in/torrents"
mkdir -p /out/torrents    || bail "mkdir -p /out/torrents"
mkdir -p /out/complete    || bail "mkdir -p /out/complete"
mkdir -p /out/processing  || bail "mkdir -p /out/processing"
mkdir -p ${HOME}/.biglybt || bail "mkdir -p ${HOME}/.biglybt"

# if we have a new BiglyBT config file (/config/biglybt.config) use it
if [ -r /config/biglybt.config ]; then
  cp /config/biglybt.config ${HOME}/.biglybt/ || bail "cp /config/biglybt.config ${HOME}/.biglybt/"
fi

# if we have no config, use the default
if [ ! -r ${HOME}/.biglybt/biglybt.config ]; then
  cp /usr/share/biglybt/biglybt.config.default ${HOME}/.biglybt/biglybt.config || bail "cp /usr/share/biglybt/biglybt.config.default ${HOME}/.biglybt/biglybt.config"
fi

if [ -n "${USER}" ]; then
  chown -R ${USER}.${GROUP} ${HOME} /in /out || bail "chown -R ${USER}.${GROUP} ${HOME} /in /out"
fi
