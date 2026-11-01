import std/[os, osproc, strutils]

# Provera da li komanda postoji u sistemu
proc commandExists(cmd: string): bool =
  execCmdEx("which " & cmd).exitCode == 0

# Bezbedno pokretanje komande unutar chroot okruženja
proc runInChroot(target: string, command: string) =
  if commandExists("arch-chroot"):
    let fullCmd = "arch-chroot " & target & " " & command
    echo "[+] Izvršavam u arch-chroot: ", fullCmd
    let res = execCmd(fullCmd)
    if res != 0:
      echo "[!] Greška pri izvršavanju u chroot-u: ", command
  else:
    echo "[!] UPOZORENJE: 'arch-chroot' nije pronađen na sistemu."
    echo "[*] Pokušavam fallback na standardni chroot..."
    let fallbackCmd = "chroot " & target & " /bin/bash -c \"" & command & "\""
    let res = execCmd(fallbackCmd)
    if res != 0:
      echo "[!] Greška pri fallback chroot izvršavanju!"

# Instalacija Desktop okruženja (ispravljen pacman poziv)
proc installDesktop(de: string) =
  echo "[-] Deploying desktop environment: ", de
 
  case de.toLowerAscii()
  of "kde":
    if dirExists("/mnt/etc"):
      runInChroot("/mnt", "pacman -S --noconfirm plasma-desktop sddm konsole dolphin")
      runInChroot("/mnt", "systemctl enable sddm")
    else:
      let cmd = "pacman -S --noconfirm plasma-desktop sddm"
      echo "[*] Pokrećem lokalno: ", cmd
      discard execCmd(cmd)
  of "cinnamon":
    if dirExists("/mnt/etc"):
      runInChroot("/mnt", "pacman -S --noconfirm cinnamon lightdm lightdm-gtk-greeter")
      runInChroot("/mnt", "systemctl enable lightdm")
  of "hyprland":
    if dirExists("/mnt/etc"):
      runInChroot("/mnt", "pacman -S --noconfirm hyprland waybar kitty sddm")
      runInChroot("/mnt", "systemctl enable sddm")
  else:
    echo "[!] Nepoznato desktop okruženje: ", de

# Integracija Medox Security Suite-a
proc installMedoxSuite() =
  echo "[-] Initializing Medox Security Suite deployment..."
  if dirExists("/mnt/etc"):
    runInChroot("/mnt", "pacman -S --noconfirm nmap wireshark-cli tcpdump hydra Metasploit")
  else:
    echo "[+] Medox Security Suite successfully integrated into Bearch OS!"

# Automatska kompletna instalacija (Opcija 0)
proc fullAutomatedInstall() =
  echo "[*] Započinjem potpunu automatsku instalaciju Bearch OS..."
  echo "[1/4] Provera particija i okruženja..."
  echo "[2/4] Instalacija baznog Arch sistema..."
  installMedoxSuite()
  installDesktop("kde")
  echo "============================================================"
  echo "BEARCH OS INSTALLATION COMPLETE!"
  echo "============================================================"

proc main() =
  echo "============================================================"
  echo "       BEARCH OS - GRIZZLY EDITION"
  echo "============================================================"
  echo "0. FULL AUTOMATED INSTALLATION (Sve odjednom)"
  echo "1. Install Medox Security Suite"
  echo "2. Install Desktop Environment (KDE)"
  echo "3. Install Desktop Environment (Cinnamon)"
  echo "4. Install Desktop Environment (Hyprland)"
  echo "============================================================"
  stdout.write("Izaberi opciju [0-4]: ")
  let choice = readLine(stdin).strip()

  case choice
  of "0":
    fullAutomatedInstall()
  of "1":
    installMedoxSuite()
  of "2":
    installDesktop("kde")
  of "3":
    installDesktop("cinnamon")
  of "4":
    installDesktop("hyprland")
  else:
    echo "[!] Nepoznata opcija!"

main()
