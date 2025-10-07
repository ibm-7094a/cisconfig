# 🧩 cisconfig  
*A simple, friendly tool for connecting to Cisco switches and routers over console cables.*

---

> ⚠️ **Important Learning Note:**  
> This tool automates the same process you can perform manually using the `cu` command.  
> If you want to understand how it all works or troubleshoot problems, please read  
> **[Manual Guide — Using `cu` without cisconfig](README_cu_manual.md)**.  
> 
> cisconfig is a helper, not a replacement for learning how serial connections work.

---

## 🚀 Features

- Works on **macOS (Intel + ARM)** and **Linux**
- Uses **`cu`** for serial connections (no `screen`!)
- Detects available serial ports automatically:
  - macOS: `/dev/cu.*`
  - Linux: `/dev/ttyUSB*`, `/dev/ttyACM*`
- Allows manual entry if nothing is found
- Kills processes using the selected device
- Supports common Cisco baud rates (9600, 19200, 38400, 57600, 115200)
- Allows custom baud and frame settings (8N1 or custom)
- Provides a clear disconnect reminder (`~.`)

---

## 🧠 Requirements

- **sudo privileges** (required for port access)
- `cu` utility:
  - macOS: included by default
  - Linux: `sudo apt install uucp` or `sudo dnf install uucp`
- Optional: `lsof` or `fuser` for process detection

---
## ⚙️ Installation

Choose the installer that matches your system:

### 🧱 macOS (Intel)
```
curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/install_mac_intel.sh -o install_mac_intel.sh
sudo bash install_mac_intel.sh
```
🍎 macOS (Apple Silicon)
```
curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/install_mac_arm.sh -o install_mac_arm.sh
sudo bash install_mac_arm.sh
```
🐧 Linux
```
curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/install_linux.sh -o install_linux.sh
sudo bash install_linux.sh
```
Once installed, run:
```
sudo cisconfig
```
and follow the on-screen prompts to connect to your Cisco device.
