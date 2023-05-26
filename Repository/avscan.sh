#!/bin/bash
clamscan --recursive --infected --log= --exclude-dir='^/Virt|^/Temp/ISO' --move=/root/.isolation /mnt/Remote/Servers/SRV01/Container-C
