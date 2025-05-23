#!/bin/bash
#!/bin/bash
if ! command -v apt >/dev/null; then
    echo "This script is for Debian/Ubuntu systems with APT."
    exit 1
fi
read -p "Do you want to read the script? [y/n]: " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    curl -s https://raw.githubusercontent.com/DeltaPhi0/homelab/refs/heads/main/media/jellyfin/jellyfin-setup.sh
    read -p "Do you want to continue? [y/n]: " answer2

    if [[ "$answer2" =~ ^[Yy]$ ]]; then
        echo "Enjoy Samba"
    else
        echo "Have a good day"
        rm samba-setup.sh
        exit 0
    fi
else
    echo "Then let's proceed."
fi

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
echo -e "You can now access your files throught\nWindows : Map Network Drive, '\ \[your pi's IP]\ files'.\nmacOS : Open Finder >> Connect to Server >> smb://[pi's IP].\nLinux+Nemo : Files >> File >> Connect to Server >> fill in."
