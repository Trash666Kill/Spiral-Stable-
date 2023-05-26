#!/bin/bash
systemctl stop clamav-freshclam
freshclam --quiet
clamscan --recursive --infected --log=/var/log/clamav/avscan-`date +%F`.log --move=/root/.isolation /mnt/Remote/Servers/SRV01/Container-C
systemctl restart clamav-freshclam
