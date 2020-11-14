#!/bin/bash

mkdir -p /in/autoload
mkdir -p /in/torrents
mkdir -p /out/torrents
mkdir -p /out/complete
mkdir -p /out/processing
mkdir -p ${HOME}/.biglybt

# if we have a new BiglyBT config file (/config/biglybt.config) use it
if [ -r /config/biglybt.config ]; then
  cp /config/biglybt.config ${HOME}/.biglybt/
fi

# if we have no config, use the default
if [ ! -r ${HOME}/.biglybt/biglybt.config ]; then
  cp /usr/share/biglybt/biglybt.config.default ${HOME}/.biglybt/biglybt.config
fi

if ! grep '/usr/local/biglybt/biglybt' ${HOME}/.config/openbox/autostart ; then
  echo >> ${HOME}/.config/openbox/autostart
  echo "/usr/local/biglybt/biglybt &" >> ${HOME}/.config/openbox/autostart
fi

# /usr/local/biglybt is necessary for auto-update to work correctly
if [ -n "${USER}" ]; then
  chown -R ${USER}.${GROUP} ${HOME} /usr/local/biglybt /in /out
fi
