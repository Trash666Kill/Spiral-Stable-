#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as sudo"
   	exit 1
else
# swapfile
 echo "*****Adding swapfile to the system*****"
 fallocate -l 1G /swapfile
 chmod 600 /swapfile
 mkswap /swapfile
 swapon /swapfile
 echo /swapfile swap swap defaults 0 0 >> /etc/fstab
 swapon --show
fi
