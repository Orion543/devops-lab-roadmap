#!/usr/bin/env bash
set -euo pipefail

LOGFILE="./bootstrap-$(date +%F-%H%M%S).log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "== Update packages =="
sudo apt update
sudo apt upgrade -y

echo "== Install base tools =="
sudo apt install -y openssh-server curl vim git htop rsync net-tools

echo "== Host info =="
hostnamectl
ip a
df -h
free -m

echo "== SSH status =="
systemctl status ssh --no-pager
