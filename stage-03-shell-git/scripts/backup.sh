#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${1:-$HOME/backups}"
RETENTION_DAYS=7
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
ARCHIVE_NAME="web-backup-${TIMESTAMP}.tar.gz"

echo "=========================================="
echo "備份腳本"
echo "=========================================="

echo -e "\n[INFO] 建立備份目錄：${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}"

BACKUP_PATHS=("/etc/nginx" "/var/www/html")
EXISTING_PATHS=()

echo -e "\n[INFO] 檢查要備份的目錄..."
for path in "${BACKUP_PATHS[@]}"; do
    if [ -d "$path" ]; then
        EXISTING_PATHS+=("$path")
        echo "[OK] $path 存在"
    else
        echo "[WARN] $path 不存在，已跳過"
    fi
done

if [ ${#EXISTING_PATHS[@]} -eq 0 ]; then
    echo "[FAIL] 沒有任何目錄可備份，結束"
    exit 1
fi

echo -e "\n[INFO] 正在封裝：${EXISTING_PATHS[*]}"
if tar -czf "${BACKUP_DIR}/${ARCHIVE_NAME}" "${EXISTING_PATHS[@]}" 2>/dev/null; then
    echo "[OK] 備份已建立：${BACKUP_DIR}/${ARCHIVE_NAME}"
else
    echo "[FAIL] 備份建立失敗"
    exit 1
fi

BACKUP_SIZE=$(du -h "${BACKUP_DIR}/${ARCHIVE_NAME}" | cut -f1)
echo -e "\n[INFO] 備份大小：${BACKUP_SIZE}"

echo -e "\n[INFO] 清理超過 ${RETENTION_DAYS} 天的舊備份"
find "${BACKUP_DIR}" -name "web-backup-*.tar.gz" -type f -mtime +${RETENTION_DAYS} -delete

echo -e "\n[INFO] 目前備份清單："
ls -lh "${BACKUP_DIR}" | grep web-backup || echo "無"

echo -e "\n=========================================="
echo "[OK] 備份作業完成"
echo "=========================================="


