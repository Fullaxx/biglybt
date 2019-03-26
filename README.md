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
Set Depth 16
```
-e VNCDEPTH='16'
```
Set 1920x1080 Resolution
```
-e VNCRES='1920x1080'
```
Set Password Authentication
```
-e VNCPASS='vncpass'
```
Set Read-Write and Read-Only password
```
-e VNCPASS='vncpass' -e VNCPASSRO='readonly'
```
## Run the image
Run the image with OpenVPN \
Make sure that your myconnection.ovpn exists in /srv/docker/biglybt/openvpn/
```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun \
-e OVPNCFG='myconnection.ovpn' \
-e OVPNSLEEPTIME='4' \
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
