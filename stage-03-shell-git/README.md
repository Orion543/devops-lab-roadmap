# Stage 03 - Shell Script + Git

## 目標

建立 Git 版本控制習慣，寫出第一批可用的 Shell Script，並讓 script 具備錯誤處理能力。

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 / Git 操作 |
| web-01 | 192.168.0.111 | 被檢查與備份的服務主機 |
| web-02 | 192.168.0.112 | 跨主機驗證 |

## 完成項目

- ✅ Git 基本操作（status、add、commit、push、pull、branch）
- ✅ Commit 訊息規範（feat、fix、docs）
- ✅ 3 支 Shell Script
  - `sysinfo.sh` - 顯示系統資訊
  - `healthcheck.sh` - 檢查 nginx 服務狀態
  - `backup.sh` - 備份 nginx 與網站內容
- ✅ Script 基礎（shebang、set -euo pipefail、變數、if、exit code）
- ✅ Script 權限與執行
- ✅ 跨主機 script 可攜性驗證
- ✅ 錯誤處理與模擬測試

## 執行方式

```
# 顯示系統資訊
./stage-03-shell-git/scripts/sysinfo.sh

# 檢查 web-01 服務健康狀態
./stage-03-shell-git/scripts/healthcheck.sh

# 備份（可指定目錄）
./stage-03-shell-git/scripts/backup.sh
./stage-03-shell-git/scripts/backup.sh /tmp/backups
```

## 參考文件

- [git-notes.md](docs/git-notes.md)
- [scripting-notes.md](docs/scripting-notes.md)
- [troubleshooting.md](docs/troubleshooting.md)

## 證據目錄

- `evidence/` - git log、script 輸出、錯誤案例
