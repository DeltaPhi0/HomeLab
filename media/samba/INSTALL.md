# Samba File Sharing Setup Guide

**Network file sharing made easy**  
*Last updated: May 21, 2025*

---
## ⚡️ Automatic installation
   ### For a quick setup, use my automated script:
   ### ⚠️ Always inspect scripts before running them!
   ```bash
   wget https://raw.githubusercontent.com/DeltaPhi0/homelab/refs/heads/main/media/samba/samba-setup.sh
   chmod +x samba-setup.sh
   sudo ./samba-setup.sh
   ```
*Note : this script works only if you have a Debian based OS*
## 🚀 Manual installation

### 1. Install requirements
```bash
sudo apt update && sudo apt install samba
```
### 2. Create shared directory
```bash
sudo mkdir /media/files
sudo chown $USER: /media/files
```
### 3. Configure samba
```bash
nano /etc/samba/smb.conf
```
**3.1. Change line**
  - 'map to guest = bad user' → 'map to guest = never'

**3.2. Add at the end of file**
```bash
[files]
  path = /media/files
  writeable = yes
  public = no
```
### 4. Create samba user
```bash
sudo smbpasswd -a $USER
```
**this will create a samba user that matches your machine's username, which is important**
### 5. Apply changes
```bash
sudo systemctl restart smbd
```
---

## 🌐 Accessing your folder

### Connection methods
#### Windows:  
   **Map Network Drive**
```
\\[server-IP]\files
```
#### macOS:
  **Open Finder >> Connect to Server**
  ```
  smb://[server-IP]
  ```
## 🔒 Security recommendations
**Use different passwords for system and Samba users**

## 🛠️ Troubleshooting

**Common issues:**
- **Permission Errors**:  
  ```bash
  sudo chmod -R 770 /media/files
  ```
---


## Recommended next steps:
- Go onto the next step in the guide : ) ( [Continue to Docker Setup →](../docker/INSTALL.md) )

*Pro Tip: Use hostname -I to find your server's IP address!*
