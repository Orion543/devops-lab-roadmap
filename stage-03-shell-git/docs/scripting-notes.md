# Shell Scripting Notes

## Script 基本骨架

```
#!/usr/bin/env bash
set -euo pipefail

echo "Start script"
```

## shebang

`#!/usr/bin/env bash` 指定用 bash 執行腳本，讓 script 可以在不同環境下找到正確的 bash。

## set -euo pipefail 解釋

| 設定 | 作用 |
|------|------|
| `set -e` | 任何指令失敗（exit code 非 0）就立即退出 |
| `set -u` | 使用未定義的變數時報錯並退出 |
| `set -o pipefail` | pipe 中任何一個指令失敗，整個 pipe 就算失敗 |

## 變數

```
# 定義變數（等號兩邊不能有空格）
NAME="orion"
BACKUP_DIR="${1:-$HOME/backups}"

# 使用變數（加上大括號是好習慣）
echo "Hello ${NAME}"

# 命令替換
TIMESTAMP="$(date +%F-%H%M%S)"
```

## 條件判斷（if）

```
if ssh orion@web-01 "systemctl is-active --quiet nginx"; then
  echo "[OK] nginx is running"
else
  echo "[FAIL] nginx is not running"
  exit 1
fi
```

### 其他判斷寫法

```
# 檢查檔案是否存在
if [ -f /etc/nginx/nginx.conf ]; then
  echo "nginx.conf exists"
fi

# 檢查變數是否為空
if [ -z "${VARIABLE}" ]; then
  echo "VARIABLE is empty"
fi

# 數字比較
if [ ${COUNT} -gt 10 ]; then
  echo "Count is greater than 10"
fi
```

## Exit Code

- `0`：成功
- 非 `0`：失敗（可用 `echo $?` 查看上一個指令的 exit code）

```
# script 中明確退出
exit 0   # 成功
exit 1   # 一般錯誤
exit 2   # 特定錯誤類型
```

## 執行權限

| 指令 | 說明 |
|------|------|
| `chmod +x script.sh` | 加上執行權限 |
| `chmod -x script.sh` | 移除執行權限 |
| `./script.sh` | 相對路徑執行 |
| `/home/orion/script.sh` | 絕對路徑執行 |

## 函數

```
# 定義函數
log_info() {
  echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
  echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

# 使用函數
log_info "Starting backup process"
log_error "Backup failed"
```

## 常見問題

### Permission denied

代表 script 沒有執行權限，執行 `chmod +x script.sh` 即可。

### Command not found

可能原因：
- shebang 寫錯
- script 沒有執行權限但用 `./` 執行
- 依賴的指令不存在

### 變數未定義錯誤

使用 `set -u` 時，若使用未定義變數會報錯。解決：定義預設值 `${VAR:-預設值}`
