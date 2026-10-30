kimport os, osproc, strutils

proc clearScreen() =
  stdout.write("\e[H\e[2J")
  stdout.flushFile()

proc showBanner() =
  echo "=================================================="
  echo " [🐻] BEARCH INSTALLER - GRIZLI EDITION [V1.0]      "
  echo " [🛡️] MEDOX SECURITY SUITE INTEGRATED             "
  echo "=================================================="

proc mainMenu() =
  while true:
    clearScreen()
    showBanner()
    echo ""
    echo " 1) Pokreni brzu i bezbednu Bearch instalaciju"
    echo " 2) Informacije o sistemu i Grizli alatima"
    echo " 3) Sistemska dijagnostika i čišćenje keša"
    echo " 4) Mrežni audit i aktivni interfejsi"
    echo " 5) Pregled diskova i particija (lsblk)"
    echo "--------------------------------------------------"
    echo " 0) Izlaz u terminal"
    echo ""
    stdout.write("Izaberi opciju [0-5]: ")
    let choice = readLine(stdin)

    case choice
    of "1":
      echo "\n[+] Pokretanje Bearch instalacione procedure..."
      discard execShellCmd("echo 'Instalacija u toku...'")
      echo "\nPritisni Enter za povratak u meni..."
      discard readLine(stdin)
    of "2":
      echo "\n[+] Grizli Edition Info:"
      echo "    Autor: Meda (Medox) // Shadow Grizzly Edition"
      echo "    Namena: Bezbedna, brza i jednostavna Arch instalacija."
      echo "\nPritisni Enter za povratak u meni..."
      discard readLine(stdin)
    of "3":
      echo "\n[+] Čišćenje sistemskog keša i paketa..."
      discard execShellCmd("pacman -Sc --noconfirm")
      echo "\nPritisni Enter za povratak u meni..."
      discard readLine(stdin)
    of "4":
      echo "\n[+] Pregled mrežnih konekcija:"
      discard execShellCmd("ss -tulnp")
      echo "\nPritisni Enter za povratak u meni..."
      discard readLine(stdin)
    of "5":
      echo "\n[+] Pregled raspoloživih diskova:"
      discard execShellCmd("lsblk")
      echo "\nPritisni Enter za povratak u meni..."
      discard readLine(stdin)
    of "0":
      echo "\nBrlog se zaključava. Pozdrav, Medo! 🐻"
      break
    else:
      echo "\n[-] Nepoznata opcija! Izaberi ponovo."
      os.sleep(1000)

when isMainModule:
  mainMenu()
