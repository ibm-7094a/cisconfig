markdown
# 🧠 Using `cu` to Connect to Cisco Devices (Manual Guide)

This guide explains how to connect to a Cisco switch or router using the `cu` (Call UNIX) utility directly — no scripts required.  
The **cisconfig** tool simply automates this process, so understanding these steps will help you connect even if the script ever fails.

---

## 🔍 Step 1 — Identify Your Console Device

### 🧩 macOS
List all possible console devices with:
```bash
ls /dev/cu.*
````

You’ll usually see something like:

```
/dev/cu.usbserial-1410
```

> ⚠️ **Tip:**
> Always use `/dev/cu.*` devices on macOS, **not** `/dev/tty.*`.
> `/dev/tty.*` includes internal system ports, Bluetooth devices, and other interfaces unrelated to your USB console adapter.

---

### 🐧 Linux

List likely serial ports:

```bash
ls /dev/ttyUSB* /dev/ttyACM*
```

Examples:

```
/dev/ttyUSB0
/dev/ttyACM0
```

If you’re unsure, unplug and replug your USB-serial cable, then re-run the command.
The new entry that appears is your adapter.

---

## ⚙️ Step 2 — Fix “Device Busy” Errors (if any)

If you try to connect and get:

```
cu: open (/dev/ttyUSB0): Device busy
```

That means some process is already using the port.

**On macOS:**

```bash
sudo lsof /dev/cu.usbserial-1410
sudo kill <PID>
```

**On Linux:**

```bash
sudo fuser -k /dev/ttyUSB0
```

You can then reconnect cleanly.

---

## 🚀 Step 3 — Start the Console Session

Now connect to your Cisco switch or router using `cu`:

```bash
sudo cu -l <device> -s <baudrate>
```

**Example:**

```bash
sudo cu -l /dev/cu.usbserial-1410 -s 9600
```

✅ **Default Cisco baud rate:** 9600
✅ **Default frame format:** 8 data bits, no parity, 1 stop bit (8N1)

---

## 🧩 Step 4 — Optional: Set Frame Format (8N1 or Custom)

If for some reason your connection requires a different frame setting, you can configure it before connecting.

**Example (8N1 standard Cisco format):**

```bash
sudo stty -f /dev/cu.usbserial-1410 cs8 -parenb -cstopb
```

**Example (7E1 — uncommon, but educational):**

```bash
sudo stty -f /dev/cu.usbserial-1410 cs7 parenb -parodd cstopb
```

Then launch `cu` again as shown above.

---

## 🧵 Step 5 — Disconnect Properly

To exit the `cu` session, type:

```
~.
```

That’s a **tilde** (`~`) followed by a **period** (`.`) on a new line, then press Enter.
This is the universal `cu` escape sequence.

If the connection hangs, open another terminal and run:

```bash
sudo killall cu
```

---

## 🧰 Step 6 — Verify You’re Connected

If successful, your terminal should show the Cisco device prompt:

```
Switch>
```

or

```
Router>
```

Congratulations — you’re in console mode!

---

## 💡 Summary — What cisconfig Automates for You

| Step              | Manual Command                     | cisconfig Action                |
| ----------------- | ---------------------------------- | ------------------------------- |
| Detect device     | `ls /dev/cu.*` / `ls /dev/ttyUSB*` | Scans and lists automatically   |
| Kill locked ports | `lsof` or `fuser` + `kill`         | Detects and kills automatically |
| Choose baud rate  | `-s 9600` (or others)              | Menu-driven choice              |
| Set frame         | `stty` command                     | Offers 8N1/custom menu          |
| Launch session    | `sudo cu -l /dev/... -s ...`       | Builds and runs the command     |
| Exit instructions | `~.`                               | Displays reminder automatically |

---

## 🧭 Common Baud Rates for Cisco Devices

| Device Type            | Default Baud | Alternate Options           |
| ---------------------- | ------------ | --------------------------- |
| Cisco Switches         | 9600         | 19200, 38400, 57600, 115200 |
| Cisco Routers          | 9600         | 19200, 38400, 57600, 115200 |
| USB-to-Serial adapters | 9600         | Depends on firmware         |

---

## 🛠 Troubleshooting

**“cu: command not found”**

* macOS: install Xcode Command Line Tools:

  ```bash
  xcode-select --install
  ```
* Linux:

  ```bash
  sudo apt install uucp
  ```

**“Permission denied” on /dev/ttyUSB0**

* Add your user to the `dialout` group:

  ```bash
  sudo usermod -aG dialout $USER
  ```

  Then log out and back in.

**No devices listed**

* Replug your console cable.
* Try `ls /dev` and look for anything with “usbserial” or “ttyUSB”.
* You may need to install FTDI or Prolific drivers on macOS.

---

## 🧠 Learning Note

Understanding these steps helps you master serial communications — not just Cisco consoles, but microcontrollers, IoT boards, and any embedded system using UART.

cisconfig simply automates this routine to save time — but the underlying process is always the same:

```
Find device → Clear lock → Set speed → Connect → Exit cleanly
```

---

### 🧩 License

MIT License © IBM-7094A
Free to use, modify, and distribute with attribution.

```

---

That’s the complete file — exactly how it should appear in your repo as `README_cu_manual.md`.  
Would you like me to generate a version with syntax-highlighted terminal snippets for print/export (like a stylized PDF or classroom handout)?
```
