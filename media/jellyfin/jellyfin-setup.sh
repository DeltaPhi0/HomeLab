#!/bin/bash
sudo apt update
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
sudo mkdir -p /media/jellyfin/{movies,shows}
echo "What is your machine's username?"
read USR
sudo chown -R $USR:$USR /media/jellyfin
sudo chmod -R 755 /media/jellyfin
sudo apt upgrade -y
