#!/usr/bin/env bash
set -euo pipefail

echo "Stopping and removing all containers..."
docker stop $(docker ps -q) 2>/dev/null || true
docker rm $(docker ps -aq) 2>/dev/null || true

echo "Removing unused images..."
docker image prune -f

echo "Removing unused volumes..."
docker volume prune -f

echo "Removing unused networks..."
docker network prune -f

echo "System prune (all unused resources)..."
docker system prune -f

echo "Cleanup completed."
