#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../docker"

VERSION="${1:-1.0.0}"

echo "Building my-nginx:${VERSION}..."
docker build -t "my-nginx:${VERSION}" .
docker tag "my-nginx:${VERSION}" my-nginx:latest

echo "Build completed."
docker images | grep my-nginx
