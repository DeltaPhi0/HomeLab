
# Raspberry Pi 3 Headless Server Setup Guide  
*Last Updated: May 6, 2025*  

![Raspberry Pi](https://img.shields.io/badge/-Raspberry%20Pi%203-CC3542?logo=raspberrypi&logoColor=white)

## 📦 Hardware Specifications
- **Device**: Raspberry Pi 3 Model B (1GB RAM)
- **Storage**: 64GB SD Card
- **Connection**: USB-to-Micro-USB power + Ethernet

## 🛠️ Initial Setup

### 1. OS Installation
1. Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Choose **Debian Bookworm (headless)** version
3. Write to SD card

*Note: Failed Ubuntu Server installation due to HDMI issues led to this choice*

### 2. Network Configuration
```bash
# Find your Pi's IP (after first boot)
nmap -sn 192.168.1.0/24

# Test connectivity
ping google.com

### 3. Router Settings
1. Access router at `192.168.1.1` (may vary)
2. Change subnet to `192.168.0.0/24` or `192.168.222.0/24`
3. Set static IP via `nmtui`:
   ```bash
   sudo nmtui
   ```
   - Select "Edit a connection"
   - Configure manual IP (e.g., `192.168.0.100`)

## 🔒 SSH Security Setup

### 1. Hostname Resolution
```bash
sudo nano /etc/hosts
```
Add line:  
`192.168.0.100 your-hostname`

### 2. SSH Key Authentication
**Client Machine:**
```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id username@hostname
```

**Server Security:**
```bash
sudo nano /etc/ssh/sshd_config
```
Uncomment and modify:  
`PasswordAuthentication no`

## 🌐 VPN Configuration

### Prerequisites
1. **Static DNS Setup** (Use [DuckDNS](https://www.duckdns.org/))
2. **Port Forwarding** in router settings:
   - Protocol: UDP
   - WAN Port: 1194
   - LAN Host: [Your Pi's IP]
   - LAN Port: 1194

### WireGuard Setup (Mobile Access)
```bash
# Install PiVPN
sudo apt install pivpn

# Configure PiVPN (choose WireGuard and DDNS domain)
sudo pivpn add -n wgclient
sudo pivpn -qr
```

1. Scan QR code with WireGuard mobile app
2. Test connection:
   ```bash
   pivpn -c  # Monitor connections
   ```

### OpenVPN Setup (Main Machine)
**Server:**
```bash
wget https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh
AUTO_INSTALL=y ./openvpn-install.sh

# Fix TUN if needed:
sudo mkdir -p /dev/net
sudo mknod /dev/net/tun c 10 200
sudo chmod 666 /dev/net/tun
```

**Client:**
```bash
scp user@your-pi-ip:client.ovpn ~/
sudo apt install network-manager-openvpn
```
1. Import `client.ovpn` in Network Manager
2. Connect via GUI interface

## 💾 Backup & Recovery
1. Use **Clonezilla** for system backups
2. Before backup:
   ```bash
   sudo pishrink.sh -Za  # Shrink partition
   ```
3. Update fstab after restoration if needed
4. Store backups on external drive

## 💡 Pro Tips
- `man [command]` is your best friend
- Use `grep` for quick searches:  
  ```bash
  dmesg | grep -i error
  ```
- Always verify commands from untrusted sources
- Keep a setup journal for future reference

## 🚨 Important Security Notes
- Never share your private SSH key
- Regularly update packages:
  ```bash
  sudo apt update && sudo apt upgrade -y
  ```
- Use fail2ban for intrusion prevention
- **Warning:** Only share VPN access with trusted users

---

**Maintainer**: [Your Name]  
**Special Thanks**: Leonard for the hardware gift!  

*"The cloud is just someone else's computer - here's to making your own!"*
```
