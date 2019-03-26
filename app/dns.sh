#!/bin/bash

echo > /etc/resolv.conf
echo "# /etc/resolv.conf.head can replace this line" >> /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
echo "# /etc/resolv.conf.tail can replace this line" >> /etc/resolv.conf
