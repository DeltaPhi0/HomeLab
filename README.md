
# Raspberry Pi 3 Headless Server Setup Guide  
*Last Updated: May 6, 2025*  

![Raspberry Pi](https://img.shields.io/badge/-Raspberry%20Pi%203-CC3542?logo=raspberrypi&logoColor=white)

## 📦 Hardware specifications
- **Device**: Raspberry Pi 3 Model B (1GB RAM)
- **Storage**: 64GB SD Card
- **Connection**: USB-to-Micro-USB power + Ethernet

## 🛠️ Initial setup

### 1. OS installation
1. Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Choose **Choose Raspberry Pi OS Lite (64-bit) - Debian Bookworm based** version
3. Write to SD card

*Note: Failed Ubuntu Server installation due to HDMI issues led to this choice*

### 2. Network configuration
```bash
# Find your Pi's IP (after first boot)
nmap -sn 192.168.1.0/24

# Test connectivity
ping google.com
```
### 3. Router settings
1. Access router at `192.168.1.1` (may vary)
2. Change subnet to `192.168.0.0/24` or `192.168.222.0/24` (be sure to not choose a conflicting subnet)
3. Set static IP via `nmtui`:
```bash
sudo nmtui
   ```
   - Select "Edit a connection"
   - Configure manual IP (e.g., `192.168.0.100`)

## 🔒 SSH security setup

### 1. Hostname resolution
```bash
sudo nano /etc/hosts
```
Add line:  
`192.168.0.100 your-hostname`

### 2. SSH key authentication
**Client machine:**
```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id username@hostname
```

**Server security:**
```bash
sudo nano /etc/ssh/sshd_config
```
Uncomment and modify:  
`PasswordAuthentication no`

## 🌐 VPN Configuration

### Prerequisites
1. **Static DNS setup** (Use [DuckDNS](https://www.duckdns.org/))
2. **Port forwarding #1(OpenVPN)** in router settings:
   - Protocol: UDP
   - WAN Port: 1194
   - LAN Host: [Your Pi's local IP]
   - LAN Port: 1194
3. **Port forwarding #2(WireGuard)** in router settings:
   - Protocol: UDP
   - WAN Port: 51820
   - LAN Host: [Your Pi's local IP]
   - LAN Port: 51820

### WireGuard setup (Mobile access)
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

### OpenVPN setup (Main machine)
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
[If you need additional help](https://www.youtube.com/watch?v=CBJMl9MILbg&t=560s)

## 💾 Backup & recovery
1. Before backing up, be sure to shrink partition to minimum possible using either gparted, parted or fdisk
   - e.g. If you have 12.5GB storage, be sure to round it up to the next whole number, in this case, 13GB
2. Use **Clonezilla** for system backups, very intuitive and user friendly
3. Update fstab after restoration if needed (for me it was my case)
4. Store backups on external drive
[For visual learners!](https://www.youtube.com/watch?v=yQ9NpWZ74BU&t=349s)

## 💡 ALWAYS remember
- `man [command]` is your best friend
- Use `grep` for quick searches:  
  ```bash
  command | grep -i error
  ```
- Always verify commands from untrusted sources
- Keep a setup journal for future reference

## 🚨 Important security notes
- Never share your private SSH key
- Regularly update packages:
  ```bash
  sudo apt update && sudo apt upgrade -y
  ```
- Use fail2ban for intrusion prevention
- **Warning:** Only share VPN access with trusted users!!
- (e.g. I personally share it with my brother and a friend of mine, so they can access to my media too.)

---

**Special Thanks**: Leonard for the hardware gift!  

*"The cloud is just someone else's computer...here's to making your own!"*
```
