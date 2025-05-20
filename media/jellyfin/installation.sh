#!/bin/bash
echo "What is your username? Please be sure to get it correctly"
read UNAME
sudo apt update
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
sudo mkdir -p /media/jellyfin/{movies,shows}
sudo chown -R $UNAME:$UNAME /media/jellyfin
sudo chmod -R 755 /media/jellyfin
sudo apt upgrade -y
