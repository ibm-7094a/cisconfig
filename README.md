
# 🧩 cisconfig  
*A simple, friendly tool for connecting to Cisco switches and routers over console cables.*

`cisconfig` makes it easy to open a console session without remembering long `cu` commands or digging through `/dev/tty.*` device names.  
It automatically finds your serial adapters, helps you select the right one, sets baud and frame settings, and connects using the classic, reliable `cu` utility.

---

## 🚀 Features

- Works on **macOS** and **Linux**
- Detects available serial devices (`/dev/cu.*`, `/dev/ttyUSB*`, etc.)
- Lets you **manually enter a device** if nothing is found
- Lists and **kills processes** holding your console port open
- Choose from **common Cisco baud rates** or enter a custom one
- Choose between **8N1** or full custom serial settings
- Gives a clear reminder on **how to disconnect** (`~.`)
- Launches a clean `cu` session automatically

---

## 🧠 Requirements

- macOS or Linux  
- `cu` installed  
  - macOS: already included  
  - Linux: `sudo apt install uucp` or `sudo dnf install uucp`  
  (Some linux systems take `sudo apt-get install cu` or `sudo dnf install cu`)
- Optional but recommended: `lsof` or `fuser` for process detection

---

## ⚙️ Installation

### Option 1 — Quick install (recommended)

Run this in your terminal:

```bash
sudo curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/cisconfig -o /usr/local/bin/cisconfig
sudo chmod +x /usr/local/bin/cisconfig
```

Now you can run it anywhere:

```bash
cisconfig
```

> 💡 On Apple Silicon Macs, if `/usr/local/bin` doesn’t exist, you can install to `/opt/homebrew/bin` instead.

----------

### Option 2 — Manual install

If you cloned the repo:

```bash
git clone https://github.com/<yourusername>/cisconfig.git
cd cisconfig
sudo cp cisconfig /usr/local/bin/
sudo chmod +x /usr/local/bin/cisconfig
```

----------

## 🖥️ Usage

Just run:

```bash
cisconfig
```

You’ll be guided through:

1.  Choosing your platform (macOS or Linux)
    
2.  Listing or manually entering a console device
    
3.  Checking for and stopping processes that may hold the port
    
4.  Selecting baud rate (9600, 19200, 38400, 57600, 115200, or custom)
    
5.  Picking frame format (8N1 or custom)
    
6.  Confirming settings before connecting
    

Once you confirm, `cisconfig` will set up the serial port and launch `cu` for you.

----------
## 🔌 Example Session
```
$ cisconfig
===========================================
   cisconfig — classroom Cisco console helper
===========================================

Welcome to cisconfig.

Select platform:
  1) macOS
  2) Linux
Platform (1 or 2): 1

Detected console devices:
  1) /dev/cu.usbserial-1410
  2) /dev/cu.usbserial-1420

Select a device number (or m/r/q): 1
→ Selected device: /dev/cu.usbserial-1410

Choose baud rate:
  1) 9600
  2) 19200
  3) 38400
  4) 57600
  5) 115200
  c) custom
Select option (number or c): 1
→ Selected baud: 9600

Choose framing:
  1) 8N1 (default)
  2) Custom
Select (1 or 2): 1
→ Selected frame: 8N1

Confirm connection settings:
  Device: /dev/cu.usbserial-1410
  Baud:   9600
  Frame:  8N1
Connect now? (Y/n) Y

How to disconnect:
Press **Enter**, then type `~.` (tilde, then period), and hit Enter again.

Launching cu...

```

----------

## 🧵 Disconnecting

Inside the `cu` session, type:

```
~.
```

That’s a tilde followed by a period on a new line.  
If it doesn’t respond, you can open another terminal and `killall cu`.

----------

## ❓ Troubleshooting

**No devices found?**

-   Check your cable and adapter are plugged in.
    
-   Try `ls /dev/ttyUSB*` (Linux) or `ls /dev/cu.*` (macOS) manually.
    
-   If nothing appears, install the USB serial driver (FTDI, Prolific, etc.).
    

**Permission denied on /dev/ttyUSB0?**

-   On Linux, add yourself to the `dialout` group:
    
    ```bash
    sudo usermod -aG dialout $USER
    ```
    
    then log out and back in.
    

**cu not found?**

-   macOS: install Xcode Command Line Tools (`xcode-select --install`)
    
-   Linux: `sudo apt install uucp` (Debian/Ubuntu) or `sudo dnf install uucp` (Fedora)
    

----------

## 🧰 Uninstall

```bash
sudo rm /usr/local/bin/cisconfig
```

----------

## 💬 Credits

Created by for classmates and labmates who are tired of fighting with `screen`, `minicom` and similar tools!😄  
Built with ❤️ and tested on macOS + Linux.

----------

## 📜 License

MIT License — do whatever you like, just credit me please!
