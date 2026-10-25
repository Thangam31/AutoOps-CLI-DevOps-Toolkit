# ⚡ AutoOps CLI — DevOps System Diagnostics Toolkit

A lightweight, terminal-first shell utility designed for DevOps engineers and Linux system administrators to rapidly inspect server telemetry, parse critical system logs, and identify high-resource process bottlenecks.

## 🌟 Key Features
* **sysinfo**: Aggregates OS version, Linux Kernel, system uptime, active CPU cores, memory utilization, and disk partition stats.
* **logs**: Real-time log parser that scans /var/log/syslog for critical ERROR and WARNING messages.
* **process**: Isolates top memory and CPU consuming background processes using sorted process tables.

## 🛠️ Tech Stack
* **Language:** Bash Shell Scripting
* **Linux Utilities:** awk, grep, ps, free, df, uptime, nproc

## 🚀 Usage Guide

1. Grant Execution Permission:
   chmod +x autoops.sh

2. System Information Overview:
   ./autoops.sh sysinfo

3. Parse System Log Anomalies:
   ./autoops.sh logs

4. Process Diagnostics:
   ./autoops.sh process

## 📊 Sample Execution Outputs

### Diagnostics (sysinfo)
=====================================================
               AUTOOPS SYSTEM DIAGNOSTICS            
=====================================================
Hostname      : ip-172-31-8-81
OS Version    : Ubuntu 26.04.1 LTS
Kernel        : 7.0.0-1014-aws
Uptime        : up 10 minutes
CPU Cores     : 2
Memory Usage  : 314Mi/908Mi
Disk Usage    : 2.3G/6.7G (34%)
=====================================================

### Process Monitoring (process)
[*] Top 5 Memory Consuming Processes:
USER       PID      %CPU     %MEM     COMMAND
root       668      0.0      4.6      /usr/lib/snapd/snapd
root       749      0.0      3.4      /usr/bin/python3
root       663      0.0      3.2      /usr/bin/python3
