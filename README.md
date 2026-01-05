# loic-dos-simulation
Simulated DDoS strike lab — LOIC deployed in Kali against Windows VM. Forensics, detection, and SOC insights documented

# 🛰️ LOIC Network Stress Testing Lab  
---

## 📌 Overview  
This repository documents a hands-on cybersecurity lab built to simulate HTTP flood attacks using the Low Orbit Ion Cannon (LOIC) tool. The lab is executed in a fully isolated virtual environment and serves as a forensic and detection exercise for aspiring SOC Analysts.

> ⚠️ All tests were conducted in a closed, non-production network. No external systems were targeted.

---

## 🧪 Objectives  
- Deploy LOIC on Kali Linux using Mono runtime  
- Simulate HTTP flood against a Windows 11 VM  
- Monitor system performance and network behavior  
- Extract forensic artifacts and SOC-level insights  

---

## 🛠️ Lab Environment  
| Component         | Details                                      |
|------------------|----------------------------------------------|
| OS (Attacker)    | Kali Linux (Mono installed)                  |
| OS (Target)      | Windows 11 (VirtualBox VM)                   |
| Tool             | LOIC v1.0.8.0 (GUI-based DDoS simulator)     |
| Network          | Host-only adapter (isolated lab subnet)      |
| Monitoring       | Task Manager, `ipconfig`, `ifconfig`, logs   |

---

## ⚙️ Setup Instructions  
### 1. Install Mono on Kali Linux  
```bash
sudo apt-get update  
sudo apt-get install mono-complete  
