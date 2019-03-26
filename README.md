# A small docker image running BiglyBT with openvpn

## Base Docker Image
[fullaxx/ubuntu-desktop](https://hub.docker.com/r/fullaxx/ubuntu-desktop)

## Get the image from Docker Hub
```
docker pull fullaxx/biglybt
```
## Volume Options
Input: Drop your torrents in /srv/docker/biglybt/in/autoload/
```
-v /srv/docker/biglybt/in:/in
```
Output: Your downloads will reside in /srv/docker/biglybt/out/complete/
```
-v /srv/docker/biglybt/out:/out
```
Configuration: Any .ovpn files must be placed in /srv/docker/biglybt/openvpn/
```
-v /srv/docker/biglybt/openvpn:/openvpn
```
## VNC Options
Optional: Set Depth 16
Default: 24
```
-e VNCDEPTH='16'
```
Optional: Set 1920x1080 Resolution
Default: 1280x800
```
-e VNCRES='1920x1080'
```
Optional: Set Password Authentication
Default: No Authentication
```
-e VNCPASS='vncpass'
```
Optional: Set Read-Write and Read-Only password
Default: No Authentication
```
-e VNCPASS='vncpass' -e VNCPASSRO='readonly'
```
## OpenVPN Options
Optional: Wait 5 seconds for openvpn to initiate and connect before moving on
Default: 3 seconds
```
-e OVPNSLEEPTIME='5'
```
Use this file to connect to an openvpn service \
Default behavior is openvpn will not launch \
Any .ovpn files must be placed in your openvpn volume (/srv/docker/biglybt/openvpn/)
```
-e OVPNCFG='myconnection.ovpn'
```
## Run the image
Run the image with OpenVPN \
Make sure that your myconnection.ovpn exists in /srv/docker/biglybt/openvpn/
```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun \
-e OVPNCFG='myconnection.ovpn' \
-e OVPNSLEEPTIME='5' \
-v /srv/docker/biglybt/data:/root/.biglybt \
-v /srv/docker/biglybt/in:/in \
-v /srv/docker/biglybt/out:/out \
-v /srv/docker/biglybt/openvpn:/openvpn \
-p 127.0.0.1:5901:5901 fullaxx/biglybt
```
## Connect using vncviewer
```
vncviewer 127.0.0.1:5901
```
## Build it locally using the github repository
```
docker build -t="fullaxx/biglybt" github.com/fullaxx/biglybt
```
