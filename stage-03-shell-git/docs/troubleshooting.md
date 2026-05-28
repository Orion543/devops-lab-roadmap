# Troubleshooting - Shell Script + Git

## Script 執行失敗

### 錯誤：Permission denied

**原因**：script 沒有執行權限

**解法**：
```
chmod +x script.sh
```

### 錯誤：Command not found

**原因**：
- shebang 寫錯
- 依賴的指令不存在

**解法**：
```
# 檢查 shebang 是否正確
head -1 script.sh

# 確認指令存在
which ssh curl
```

### 錯誤：connection refused

**原因**：目標主機的服務沒有啟動或 port 沒有監聽

**解法**：
```
# 檢查服務狀態
systemctl status nginx

# 檢查監聽 port
ss -tulpen | grep :80
```

## Git 操作問題

### 錯誤：failed to push some refs

**原因**：遠端有新的 commit 本機沒有

**解法**：
```
git pull --rebase
git push
```

### 錯誤：detected dubious ownership

**原因**：Git 不信任該目錄的擁有者

**解法**：
```
git config --global --add safe.directory /path/to/repo
```

### 錯誤：merge conflict

**原因**：兩個分支修改了同一個檔案

**解法**：
```
# 查看衝突檔案
git status

# 手動編輯解決衝突
vim <衝突檔案>

# 標記為已解決
git add <衝突檔案>

# 完成合併
git commit -m "fix: resolve merge conflict"
```

### 錯誤：detached HEAD state

**原因**：直接 checkout 到某個 commit hash

**解法**：
```
# 建立分支保留目前變更
git branch temp-branch
git checkout temp-branch

# 或直接切回 main
git checkout main
```

## healthcheck.sh 常見失敗

### ssh 連線失敗

**確認項目**：
- SSH key 已設定：`ssh web-01 hostname`
- 主機名稱可解析：`ping web-01`

### curl 失敗

**確認項目**：
- nginx 是否啟動：`systemctl status nginx`
- 防火牆是否阻擋：`sudo iptables -L INPUT -n -v`

## 本次 Lab 遇到的錯誤（請自行補充）

| 錯誤現象 | 可能原因 | 解決方式 |
|----------|----------|----------|
| （你遇到的） | （原因） | （解法） |
| （你遇到的） | （原因） | （解法） |
