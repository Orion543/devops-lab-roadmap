#!/usr/bin/env bash
set -euo pipefail

echo "== Rate Limit Test =="
for i in {1..20}; do
  echo -n "Request $i: "
  curl -k -s -o /dev/null -w "%{http_code}\n" https://web-01/app/
done
