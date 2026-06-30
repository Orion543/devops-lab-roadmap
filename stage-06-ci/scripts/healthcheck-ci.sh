#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080}"

echo "=== CI Healthcheck ==="
echo "Testing: $URL"

HTTP_CODE=$(curl -s -o /tmp/ci-response.html -w "%{http_code}" "$URL")

if [[ "$HTTP_CODE" != "200" ]]; then
  echo "[FAIL] HTTP status: $HTTP_CODE"
  echo "Response body:"
  cat /tmp/ci-response.html 2>/dev/null || echo "(empty)"
  exit 1
fi

echo "[OK] HTTP status: $HTTP_CODE"
echo "[OK] CI healthcheck passed"
exit 0
