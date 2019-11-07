# An Ubuntu docker image running BiglyBT with openvpn

## Base Docker Image
[fullaxx/ubuntu-desktop](https://hub.docker.com/r/fullaxx/ubuntu-desktop)

## Software
[BiglyBT](https://www.biglybt.com/) - A java-based bittorrent application \
[openvpn](https://openvpn.net/)

## Get the image from Docker Hub
```
docker pull fullaxx/biglybt
```

## Volume Options
Input: Drop your torrents/magnets in /srv/docker/biglybt/in/autoload/
```
-v /srv/docker/biglybt/in:/in
```
Output: Your downloads will reside in /srv/docker/biglybt/out/complete/
```
-v /srv/docker/biglybt/out:/out
```
Configuration: Any .ovpn files must be placed in /srv/docker/biglybt/config/ \
Also, if biglybt.config is found in /config, it will be copied to $HOME/.biglybt/ and used
```
-v /srv/docker/biglybt/config:/config
```

## BiglyBT Dir Tree
```
/in
|-- autoload - Drop your torrents/magnets here
`-- torrents - BiglyBT will move torrent files here after autoload input

/out
|-- complete - Downloads will be moved here upon completion
|-- torrents - BiglyBT will move torrent files of finished downloads here
`-- processing - BiglyBT will use this for processing incomplete downloads
```

## VNC Options
Optional: Set Depth 16 \
Default: 24
```
-e VNCDEPTH='16'
```
Optional: Set 1920x1080 Resolution \
Default: 1280x800
```
-e VNCRES='1920x1080'
```
Optional: Set Password Authentication \
Default: No Authentication
```
-e VNCPASS='vncpass'
```
Optional: Set Read-Write and Read-Only password \
Default: No Authentication
```
-e VNCPASS='vncpass' -e VNCPASSRO='readonly'
```
Optional: Run as a non-root user \
Default: root (UID: 0)
```
-e VNCUSER='guest' -e VNCUID='1000'
```
Optional: Set a custom group for non-root user \
Default: same as VNCUSER and VNCUID
```
-e VNCGROUP='guests' -e VNCGID='1001'
```
Optional: Set umask to define permission for new files \
Default: 0022
```
-e VNCUMASK='0002'
```

## OpenVPN Options
Optional: Wait 9 seconds for openvpn to initiate and connect before moving on \
Default: 5 seconds
```
-e OVPNSLEEPTIME='9'
```
Use the file *myconnection.ovpn* to connect to an openvpn service \
Default behavior is that openvpn will not run \
Any .ovpn files must be placed in your openvpn volume (/srv/docker/biglybt/config/)
```
-e OVPNCFG='myconnection.ovpn'
```

## TimeZone Configuration
Set the timezone to be used inside the container \
Default: UTC
```
-e TZ='Asia/Tokyo'
-e TZ='Europe/London'
-e TZ='America/Los_Angeles'
-e TZ='America/Denver'
-e TZ='America/Chicago'
-e TZ='America/New_York'
```

## Shared Memory Modification (to support Web Browsers)
Increase the size of shared memory to prevent web browsers from crashing \
Thanks to [jlesage](https://hub.docker.com/r/jlesage/firefox/#increasing-shared-memory-size)
```
--shm-size 2g
```

## Run the image
Run the image keeping your biglybt configuration
```
docker run -d \
-v /srv/docker/biglybt/data:/root/.biglybt \
-v /srv/docker/biglybt/in:/in \
-v /srv/docker/biglybt/out:/out \
-p 127.0.0.1:5901:5901 fullaxx/biglybt
```
Run the image as a non-root user
```
docker run -d \
-e VNCUSER='guest' -e VNCUID='1000' \
-v /srv/docker/biglybt/data:/home/guest/.biglybt \
-v /srv/docker/biglybt/in:/in \
-v /srv/docker/biglybt/out:/out \
-p 127.0.0.1:5901:5901 fullaxx/biglybt
```
Run the image as a non-root user with custom group
```
docker run -d \
-e VNCUSER='guest' -e VNCUID='1000' \
-e VNCGROUP='guests' -e VNCGID='1001' \
-v /srv/docker/biglybt/data:/home/guest/.biglybt \
-v /srv/docker/biglybt/in:/in \
-v /srv/docker/biglybt/out:/out \
-p 127.0.0.1:5901:5901 fullaxx/biglybt
```
Run the image with OpenVPN \
Make sure that your *myconnection.ovpn* file exists in /srv/docker/biglybt/config/
```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun \
--sysctl net.ipv6.conf.all.disable_ipv6=0 \
-e OVPNCFG='myconnection.ovpn' \
-e OVPNSLEEPTIME='9' \
-e LOGFILE='mylog' \
-v /srv/docker/biglybt/in:/in \
-v /srv/docker/biglybt/out:/out \
-v /srv/docker/biglybt/config:/config \
-p 127.0.0.1:5901:5901 fullaxx/biglybt
```

## Connect using vncviewer
```
vncviewer 127.0.0.1:5901
```

## Build it locally using the github repository
```
docker build -t="fullaxx/biglybt" github.com/Fullaxx/biglybt
```
