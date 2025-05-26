# Navidrome Music Server Setup  
**Self hosted music streaming made simple**  

## 🚀 Quick installation  

### 1. Create directories & set permissions  
```bash
sudo mkdir -p /media/navidrome/{music,data}
sudo chmod -R 755 /media/navidrome
sudo chown -R $USER /media/navidrome
```
### 2. Get configuration file
```bash
cd /media/navidrome
wget https://raw.githubusercontent.com/DeltaPhi0/homelab/refs/heads/main/media/navidrome/docker-compose.yaml
sudo chmod 644 docker-compose.yaml
sudo chown $USER:$USER docker-compose.yaml
```
### 3. Start the server
```bash
docker-compose up -d
```

---

## 🌐 Access your music  
- Open in browser: http://[your ip]:4533
- First user created becomes admin  

---

## 📱 Mobile Setup (iOS)
### 1. Install [Substreamer](https://apps.apple.com/us/app/substreamer/id1012991665)
### 2. Connect using 
```
Server: http://[your-ip]:4533
Username: [your-admin-user]
Password: [your-password]
```
---

## ⭐ Favorites Playlist Setup
### 1. Download this file, it will automatically save your favorite songs in a playlist of its own
```bash
wget https://raw.githubusercontent.com/DeltaPhi0/homelab/refs/heads/main/media/navidrome/Favorites.nsp -O /media/navidrome/music/favorites.nsp
```
### 2. Restart server
```bash
docker restart navidockerc-navidrome-1
```
## Enjoy your music!
**Recommended next steps:**
- Go onto the next step in the guide : ) ( [Continue to calibre Setup →](../calibre/INSTALL.md) )

*Note: you can change a files metadata (e.g. artist, album name, title, etc..) using the command id3v2. man id3v2 for more information*
