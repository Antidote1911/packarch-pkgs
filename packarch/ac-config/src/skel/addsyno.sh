#!/bin/sh
sudo mkdir /mnt/Musiques /mnt/Partage /mnt/Photos

## Append packarch repository to pacman.conf
sudo cat >> "/etc/fstab" <<- EOL

## Synology DS918
192.168.1.96:/volume1/Partage /mnt/Partage  nfs defaults,noatime 0 1
192.168.1.96:/volume1/music /mnt/Musiques  nfs defaults,noatime 0 1
192.168.1.96:/volume1/photo /mnt/Photos  nfs defaults,noatime 0 1
EOL
