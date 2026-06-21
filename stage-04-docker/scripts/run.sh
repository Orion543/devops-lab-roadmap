#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-my-nginx:latest}"
PORT="${2:-8080}"

# 停止並刪除同名舊容器
docker stop my-nginx 2>/dev/null || true
docker rm my-nginx 2>/dev/null || true

echo "Running ${IMAGE} on port ${PORT}..."
docker run -d \
  --name my-nginx \
  -p ${PORT}:80 \
  --memory="256m" \
  --cpus="0.5" \
  --restart unless-stopped \
  ${IMAGE}

echo "Container started. Access at http://localhost:${PORT}"
docker ps | grep my-nginx
