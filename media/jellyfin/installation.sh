#!/bin/bash
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
mkdir -p /media/jellyfin/{movies,shows}
chown -R $USER:$USER /media/jellyfin
chmod -R 755 /media/jellyfin
