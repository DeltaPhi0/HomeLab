#!/bin/bash
sudo apt update
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
mkdir -p /media/jellyfin/{movies,shows}
chown -R $UNAME:$UNAME /media/jellyfin
chmod -R 755 /media/jellyfin
sudo apt upgrade -y
