# BEARISH OS - Grizzly Edition

A custom, streamlined Arch Linux installer written in Nim. Designed as a "fire-and-forget" alternative to `archinstall` for fast, clean, and reliable custom deployments.
## 🚀 Quick Start Guide (For Beginners)

If you are new to Arch Linux or want a fast automated deployment, follow these simple steps:

1. **Boot into Arch Linux:** Download the official Arch Linux ISO, flash it to a USB drive, and boot your target machine into the Arch Live environment.
2. **Connect to Internet:** Ensure you have an active network connection (`iwctl` for Wi-Fi or an Ethernet cable).
3. **Run Bearch:** Open the terminal and run the following commands:
   ```bash
   git clone [https://github.com/medenimaster-one-hand/bearch.git](https://github.com/medenimaster-one-hand/bearch.git)
   cd bearch
   ./bearch


## ⚠️ Important Prerequisite
This script is designed to run **exclusively from within an Arch Linux Live USB environment**. Do not attempt to run it on Ubuntu, Debian, or any other running operating system, as it relies on Arch-specific tools (`pacstrap`, `pacman`, etc.).

---

## 🚀 Quick Start Guide (For Beginners)

If you are new to Arch Linux or want a fast automated deployment, follow these simple steps:

1. **Boot into Arch Linux:** Download the official Arch Linux ISO, flash it to a USB drive, and boot your target machine into the Arch Live environment.
2. **Clone or Download the Script:** Get the Bearch installer onto your live system.
3. **Run the Binary / Script:** Execute the installer.
4. **Choose Option 0 (Full Automated Installation):**
   - Sit back and let the script handle the heavy lifting.
   - It automatically sets up the base structure, integrates the **Medox Security Suite**, installs your chosen desktop environment (defaulting to KDE), and handles user creation and rebooting.

---

## 📋 Menu Options

* **0. FULL AUTOMATED INSTALLATION:** Runs the complete end-to-end setup automatically.
* **1. Install Medox Security Suite:** Deploys penetration testing and networking tools (nmap, wireshark, tcpdump, hydra, metasploit).
* **2. Install Desktop Environment (KDE):** Installs Plasma, SDDM, Konsole, and Dolphin.
* **3. Install Desktop Environment (Cinnamon):** Installs Cinnamon and LightDM.
* **4. Install Desktop Environment (Hyprland):** Installs Hyprland, Waybar, Kitty, and SDDM.
