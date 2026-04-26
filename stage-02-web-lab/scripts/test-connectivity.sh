#!/usr/bin/env bash
set -euo pipefail

echo "== Testing nginx =="
curl -I http://web-01

echo
echo "== Testing reverse proxy =="
curl -I http://web-01/app/
