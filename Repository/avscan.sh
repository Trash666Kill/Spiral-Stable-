#!/bin/bash
#
set -e
sshfs -p 26 emperor@SRV01:/mnt/Local/Container-C/ /mnt/Remote/Servers/SRV01/Container-C/ -o allow_other -o compression=no -o StrictHostKeyChecking=false
#
systemctl stop clamav-freshclam
freshclam --quiet
clamscan --recursive --infected --log=/var/log/clamav/avscan-`date +%F`.log --move=/root/.isolation /mnt/Remote/Servers/SRV01/Container-C
systemctl restart clamav-freshclam
#
umount /mnt/Remote/Servers/SRV01/Container-C/
#
