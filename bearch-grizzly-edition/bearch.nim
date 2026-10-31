import os, osproc, strformat, strutils

proc installMedoxSecuritySuite() =
  echo "[-] Initializing Medox Security Suite deployment..."
  let targetDir = "/mnt/opt/medox-security-suite"
  if dirExists(targetDir):
    echo "[*] Medox Security Suite already exists. Updating..."
    let (output, exitCode) = execCmdEx(fmt"git -C {targetDir} pull")
    if exitCode != 0:
      echo "[!] Warning: Could not update Medox suite: ", output
  else:
    echo "[*] Cloning Medox Security Suite from GitHub..."
    let cloneCmd = fmt"git clone https://github.com/medenimaster-one-hand/medox-security-suite.git {targetDir}"
    let (output, exitCode) = execCmdEx(cloneCmd)
    if exitCode != 0:
      echo "[!] Error cloning Medox Security Suite: ", output
      return

  echo "[+] Setting executable permissions and linking security tools..."
  discard execCmd(fmt"chmod +x {targetDir}/*.sh")
  discard execCmd("mkdir -p /mnt/usr/local/bin")
  discard execCmd("ln -sf /opt/medox-security-suite/keylogger.sh /mnt/usr/local/bin/medox-keylogger")
  discard execCmd("ln -sf /opt/medox-security-suite/live_monitor.sh /mnt/usr/local/bin/medox-monitor")
  echo "[+] Medox Security Suite successfully integrated into Bearch OS!"

proc installDesktopEnvironment*(desktopType: string) =
  echo "[-] Deploying desktop environment: ", desktopType
  var pkgs = ""
  case desktopType.toLowerAscii()
  of "kde":
    pkgs = "plasma-meta kde-applications sddm sddm-kcm"
    discard execCmd("arch-chroot /mnt systemctl enable sddm")
  of "cinnamon":
    pkgs = "cinnamon lightdm lightdm-gtk-greeter"
    discard execCmd("arch-chroot /mnt systemctl enable lightdm")
  of "hyprland":
    pkgs = "hyprland waybar kitty sddm"
    discard execCmd("arch-chroot /mnt systemctl enable sddm")
  else:
    echo "[!] Unknown desktop environment!"
    return

  let (output, exitCode) = execCmdEx(fmt"arch-chroot /mnt pacman -S --noconfirm {pkgs}")
  if exitCode != 0:
    echo "[!] Error installing desktop: ", output
  else:
    echo "[+] Desktop environment successfully installed!"

when isMainModule:
  echo "=========================================="
  echo "     BEARCH OS - GRIZZLY EDITION          "
  echo "=========================================="
  echo "1. Install Medox Security Suite"
  echo "2. Install Desktop Environment (KDE)"
  echo "3. Install Desktop Environment (Cinnamon)"
  echo "4. Install Desktop Environment (Hyprland)"
  echo "=========================================="
  stdout.write "Izaberi opciju [1-4]: "
  let choice = readLine(stdin)
 
  case choice.strip()
  of "1":
    installMedoxSecuritySuite()
  of "2":
    installDesktopEnvironment("kde")
  of "3":
    installDesktopEnvironment("cinnamon")
  of "4":
    installDesktopEnvironment("hyprland")
  else:
    echo "[!] Nelegan izbor."
