#!/bin/bash

mkdir -p /data/in/autoload
mkdir -p /data/in/torrents
mkdir -p /data/out/torrents
mkdir -p /data/out/complete
mkdir -p /data/out/processing
mkdir -p ${HOME}/.biglybt

# if we have a new BiglyBT config file (/config/biglybt.config) use it
if [ -r /config/biglybt.config ]; then
  cp /config/biglybt.config ${HOME}/.biglybt/
fi

# if we have no config, use the default
if [ ! -r ${HOME}/.biglybt/biglybt.config ]; then
  cp /usr/share/biglybt/biglybt.config.default ${HOME}/.biglybt/biglybt.config
fi

if [ -n "${USER}" ]; then
  chown -R ${USER}:${GROUP} ${HOME} /data
fi
