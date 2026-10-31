import os, osproc, strformat

proc installMedoxSecuritySuite*() =
  echo "[-] Initializing Medox Security Suite deployment..."
 
  # Kreiramo privremeni radni direktorijum i kloniramo repozitorijum
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

  # Postavljanje simlinkova ili dozvola za skripte u novom sistemu
  echo "[+] Setting executable permissions and linking security tools..."
  discard execCmd(fmt"chmod +x {targetDir}/*.sh")
 
  # Kreiranje prečice u /usr/local/bin unutar chroot-a/mount-a sistema
  discard execCmd("ln -sf /opt/medox-security-suite/keylogger.sh /mnt/usr/local/bin/medox-keylogger")
  discard execCmd("ln -sf /opt/medox-security-suite/live_monitor.sh /mnt/usr/local/bin/medox-monitor")

  echo "[+] Medox Security Suite successfully integrated into Bearch OS!"
