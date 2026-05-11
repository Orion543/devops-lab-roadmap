#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "Stage 02 Web Lab - Connectivity Test"
echo "=========================================="

echo -e "\n[Test 1] Nginx Status (HTTPS)"
curl -k -I -s https://web-01/ | head -1

echo -e "\n[Test 2] Reverse Proxy (HTTPS)"
curl -k -I -s https://web-01/app/ | head -1

echo -e "\n[Test 3] Load Balancing (multiple requests via HTTPS)"
for i in 1 2 3; do
  echo -n "Request $i: "
  curl -k -s https://web-01/app/ | grep -o "<h1>[^<]*</h1>" || echo "FAIL"
done

echo -e "\n[Test 4] HTTP to HTTPS Redirect"
curl -I -s http://web-01/app/ | grep -i location

echo -e "\n[Test 5] Health Check Endpoint (HTTPS)"
curl -k -s https://web-01/health || echo "FAIL"

echo -e "\n=========================================="
echo "Test Complete"
echo "=========================================="
