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





#!/usr/bin/env bash
# loic-run.sh
# Purpose: Launch LOIC via Mono in a controlled lab
# Usage: bash loic-run.sh /path/to/LOIC.exe

set -euo pipefail

LOIC_PATH="${1:-./LOIC.exe}"

if [[ ! -f "$LOIC_PATH" ]]; then
  echo "[!] LOIC executable not found at: $LOIC_PATH"
  echo "    Place LOIC.exe in the project root or provide the correct path."
  exit 1
fi

echo "[*] Starting LOIC with Mono..."
echo "[!] Use ONLY a local VM target in an isolated network. Never target external systems."
mono "$LOIC_PATH"





#!/usr/bin/env bash
# system-metrics-linux.sh
# Purpose: Periodically log system metrics during stress simulation
# Usage: bash system-metrics-linux.sh /path/to/output.log

set -euo pipefail

OUT="${1:-./metrics-linux.log}"
INTERVAL="${INTERVAL:-3}"   # seconds
COUNT="${COUNT:-60}"        # samples

echo "[*] Logging Linux metrics to: $OUT (interval=${INTERVAL}s, count=${COUNT})"
echo "timestamp,cpu_idle_pct,mem_used_pct,loadavg1,loadavg5,loadavg15,rx_bytes,tx_bytes" > "$OUT"

get_net_bytes() {
  local iface="${1:-eth0}"
  local rx=$(cat "/sys/class/net/${iface}/statistics/rx_bytes" 2>/dev/null || echo 0)
  local tx=$(cat "/sys/class/net/${iface}/statistics/tx_bytes" 2>/dev/null || echo 0)
  echo "${rx},${tx}"
}

for i in $(seq 1 "$COUNT"); do
  ts=$(date -Iseconds)
  cpu_idle=$(mpstat 1 1 | awk '/all/ {print $12}')
  mem_used_pct=$(free | awk '/Mem:/ {printf("%.2f", ($3/$2)*100)}')
  read load1 load5 load15 <<< "$(cat /proc/loadavg | awk '{print $1,$2,$3}')"
  read rx tx <<< "$(get_net_bytes "${IFACE:-eth0}")"
  echo "${ts},${cpu_idle},${mem_used_pct},${load1},${load5},${load15},${rx},${tx}" >> "$OUT"
  sleep "$INTERVAL"
done

echo "[+] Metrics collection complete."
