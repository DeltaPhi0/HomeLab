#!/bin/bash
curl https://repo.jellyfin.org/install-debuntu.sh | bash
sudo mkdir -p /media/jellyfin/{movies,shows}
sudo chown -R $USER:$USER /media/jellyfin
sudo chmod -R 755 /media/jellyfin
