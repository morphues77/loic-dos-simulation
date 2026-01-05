#!/usr/bin/env bash
# mono-install.sh
# Purpose: Install Mono runtime on Kali Linux for running LOIC.exe
# Usage: sudo bash mono-install.sh

set -euo pipefail

echo "[*] Updating package lists..."
sudo apt-get update -y

echo "[*] Installing mono-complete (may select mono-devel on Kali)..."
sudo apt-get install -y mono-complete || sudo apt-get install -y mono-devel

echo "[*] Verifying mono installation..."
if command -v mono >/dev/null 2>&1; then
    mono --version
    echo "[+] Mono installation successful."
else
    echo "[!] Mono not found. Please check apt output and try again."
    exit 1
fi
