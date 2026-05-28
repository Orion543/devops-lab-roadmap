#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "System Information Report"
echo "=========================================="

echo -e "\n[Hostname]"
hostnamectl --static

echo -e "\n[IP Address]"
ip -4 a | grep -v "127.0.0.1" | grep inet

echo -e "\n[Disk Usage]"
df -h | grep -v tmpfs

echo -e "\n[Memory Usage]"
free -h

echo -e "\n[Uptime]"
uptime

echo -e "\n[Kernel Version]"
uname -r

echo -e "\n[CPU Info]"
lscpu | grep -E "Model name|Socket|Core|Thread|CPU MHz"
