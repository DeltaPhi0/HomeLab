#!/bin/bash
echo "What's yout username?"
read USR
sudo apt install samba
sudo mkdir /media/files
sudo chown $USR: /media/files
sudo sh -c 'echo "[files]\n  path = /media/files\n   writeable = yes\n   public = no" >> /etc/samba/smb.conf'
sudo sed -i '/map to guest = bad user/c\    map to guest = never' /etc/samba/smb.conf
echo "enter your new samba username"
sudo smbpasswd -a $USR
sudo systemctl restart smbd
echo -e "You can now access your files throught\nWindows : Map Network Drive, '\ \[your pi's IP]\ files'.\nmacOS : Open Finder >> Connect to Server >> smb://[pi's IP]."
rm samba-setup-sh
