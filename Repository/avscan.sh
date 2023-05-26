#!/bin/bash
systemctl stop clamav-freshclam
freshclam --quiet
clamscan --recursive --infected --log=result-`date +%F`.log --exclude-dir='^/Virt|^/Temp/ISO' --move=/root/.isolation /mnt/Remote/Servers/SRV01/Container-C
systemctl restart clamav-freshclam
