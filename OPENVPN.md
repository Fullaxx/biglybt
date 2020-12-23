# Known Issues with OpenVPN

## Docker Options
Docker by default does not grant access to the tun device. \
You will need to give your container access via one of the listed methods:
```
--cap-add=NET_ADMIN --device /dev/net/tun
```
or
```
--privileged
```

## VPN Authentication
Currently I have only tested VPN providers that use certificate based authentication with this image. \
VPN connections that require the user to enter a username/password during the initial connection attempt \
likely won't work due to the way that openvpn is started in the background. \
If anyone requires this, please contact me and I'll see what I can do.

## Connecting over VNC
When using openvpn, I have had issues connecting to the VNC session when it is not bound to localhost. \
I believe this is due to the new routing that OpenVPN puts in place inside the container. \
When binding your VNC session to your host, make sure to follow the examples which bind to 127.0.0.1.
```
-p 127.0.0.1:5901:5901
```

## Disabling IPv6
In some cases, it might be necessary to disable IPv6 inside the container. \
If you see a log message that looks like this:
```
Wed Jan 1 09:06:57 2020 /sbin/ip -6 addr add XXXX:XXXX:XXXX::XXXX/64 dev tun0 RTNETLINK answers: Permission denied
Wed Jan 1 09:06:57 2020 Linux ip -6 addr add failed: external program exited with error status: 2
```
Run docker with the following options:
```
--sysctl net.ipv6.conf.all.disable_ipv6=0
```
