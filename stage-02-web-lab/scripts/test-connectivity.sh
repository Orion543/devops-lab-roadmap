#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "Stage 02 Web Lab - Connectivity Test"
echo "=========================================="

echo -e "\n[Test 1] Nginx Status"
curl -I -s http://web-01/ | head -1

echo -e "\n[Test 2] Reverse Proxy"
curl -I -s http://web-01/app/ | head -1

echo -e "\n[Test 3] Load Balancing (multiple requests)"
for i in 1 2 3; do
  echo -n "Request $i: "
  curl -s http://web-01/app/ | grep -o "<h1>[^<]*</h1>" || echo "FAIL"
done

echo -e "\n[Test 4] HTTPS (if configured)"
curl -k -I -s https://web-01/app/ 2>/dev/null | head -1 || echo "HTTPS not configured"

echo -e "\n[Test 5] Health Check Endpoint"
curl -s http://web-01/health || echo "FAIL"

echo -e "\n=========================================="
echo "Test Complete"
echo "=========================================="
