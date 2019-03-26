#!/bin/bash

mkdir -p /in/autoload
mkdir -p /in/torrents
mkdir -p /out/torrents
mkdir -p /out/complete
mkdir -p /out/processing

mkdir -p /root/.biglybt

# if we have a new BiglyBT config file (/config/biglybt.config) use it
if [ -r /config/biglybt.config ]; then
  cp /config/biglybt.config /root/.biglybt/
fi

# if we have no config, use the default
if [ ! -r /root/.biglybt/biglybt.config ]; then
  cp /usr/share/biglybt/biglybt.config.default /root/.biglybt/biglybt.config
fi