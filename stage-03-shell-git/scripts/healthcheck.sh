#!/usr/bin/env bash
# HTTPS 檢查失敗時只顯示警告（exit code 0），因為 Lab 環境可能未設定 SSL
set -euo pipefail

HOST="${1:-web-01}"
TIMEOUT=5

echo "=========================================="
echo "Health Check - ${HOST}"
echo "=========================================="

echo -e "\n[1/4] Checking nginx service..."
if ssh -o ConnectTimeout=${TIMEOUT} orion@"${HOST}" "systemctl is-active --quiet nginx" 2>/dev/null; then
  echo "[OK] nginx service is running"
else
  echo "[FAIL] nginx service is not running"
  exit 1
fi

echo -e "\n[2/4] Checking port 80..."
if ssh -o ConnectTimeout=${TIMEOUT} orion@"${HOST}" "ss -tulpen | grep -q ':80'" 2>/dev/null; then
  echo "[OK] port 80 is listening"
else
  echo "[FAIL] port 80 is not listening"
  exit 1
fi

echo -e "\n[3/4] Checking HTTP response..."
if curl -fsS --max-time ${TIMEOUT} "http://${HOST}" > /dev/null 2>&1; then
  echo "[OK] HTTP request succeeded"
else
  echo "[FAIL] HTTP request failed"
  exit 1
fi

echo -e "\n[4/4] Checking HTTPS response..."
if curl -fsS --max-time ${TIMEOUT} -k "https://${HOST}" > /dev/null 2>&1; then
  echo "[OK] HTTPS request succeeded"
else
  echo "[WARN] HTTPS request failed (SSL may not be configured)"
fi

echo -e "\n=========================================="
echo "[OK] healthcheck passed for ${HOST}"
echo "=========================================="

