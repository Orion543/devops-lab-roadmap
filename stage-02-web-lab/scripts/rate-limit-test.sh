#!/usr/bin/env bash
set -euo pipefail

echo "== Rate Limit Test =="
for i in {1..10}; do
  echo -n "Request $i: "
  curl -s -o /dev/null -w "%{http_code}\n" http://web-01/app/
done
