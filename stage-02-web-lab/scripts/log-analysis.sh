#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/var/log/nginx/access.log"

echo "=== Top 10 Endpoints ==="
sudo awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10

echo -e "\n=== HTTP Status Code Distribution ==="
sudo awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr

echo -e "\n=== Top 10 IPs ==="
sudo awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10

echo -e "\n=== Requests with 5xx Errors ==="
sudo awk '$9 ~ /^5/ {print $1, $7, $9}' "$LOG_FILE" | head -10

echo -e "\n=== Slow Requests (response_time > 1s) ==="
sudo awk '$NF > 1 {print $7, $NF}' "$LOG_FILE" | sort -k2 -nr | head -10
