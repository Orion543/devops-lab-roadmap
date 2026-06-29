#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
echo "Starting services with build..."
docker compose up -d --build
docker compose ps
