#!/bin/bash
echo "What is your machine's username?"
read USR
read -p "Do you want to read the script? [y/n]: " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    curl -s https://raw.githubusercontent.com/DeltaPhi0/homelab/refs/heads/main/media/jellyfin/jellyfin-setup.sh
    read -p "Do you want to continue? [y/n]: " answer2

    if [[ "$answer2" =~ ^[Yy]$ ]]; then
        echo "Enjoy Jellyfin"
    elif [[ "$answer2" =~ ^[Nn]$ ]]; then
        echo "Have a good day"
        rm jellyfin-setup.sh
        exit 0
    else
        echo "Invalid input. Please enter y or n."
    fi
elif [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "Then let's proceed."
else
    echo "Invalid input. Please enter y or n."
fi

sudo apt update
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
sudo mkdir -p /media/jellyfin/{movies,shows}
sudo chown -R $USR:$USR /media/jellyfin
sudo chmod -R 755 /media/jellyfin
sudo apt upgrade -y
rm jellyfin-setup.sh
