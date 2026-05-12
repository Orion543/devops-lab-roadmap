# Troubleshooting - Web Lab

## 常見錯誤與解法

### 1. curl 出現 `connection refused`

**可能原因**：Nginx 沒有啟動 或 Port 沒有監聽

**排查**：
```
systemctl status nginx
ss -tulpen | grep :80
```

### 2. curl 出現 `301 Moved Permanently`

**可能原因**：HTTP 請求被強制轉向 HTTPS（正常行為）

**解法**：改用 `https://` 並加上 `-k`（自簽憑證）
```
curl -k https://web-01/app/
```

### 3. curl 出現 `502 Bad Gateway`

**可能原因**：Reverse proxy 後端掛掉

**排查**：
```
curl http://127.0.0.1:5000/
tail -f /var/log/nginx/error.log
```

### 4. 出現 `503 Service Temporarily Unavailable`

**可能原因**：Rate Limiting 觸發（超過 `rate` + `burst`）

**解法**：等待時間窗口重置，或調高 `rate` / `burst`

### 5. Load Balancing 不平均

**可能原因**：使用 `least_conn` 演算法（正常行為）或權重設定

**確認**：
```
sudo nginx -T | grep -A 10 "upstream"
```

### 6. SSL 憑證問題

**解法**：
```
# 測試時忽略憑證驗證
curl -k https://web-01/

# 檢查憑證內容
openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -text -noout
```

### 7. nginx -t 失敗

**可能原因**：設定檔語法錯誤

**排查**：`sudo nginx -t` 會顯示錯誤行號

### 8. port already allocated

**解法**：
```
sudo lsof -i :80
sudo systemctl restart nginx
```

## 通用排查流程（HTTPS 環境）

```
# 1. 服務狀態
systemctl status nginx

# 2. 監聽 Port（80 和 443）
ss -tulpen | grep -E ":80|:443"

# 3. 防火牆
sudo iptables -L INPUT -n -v

# 4. 本機 HTTPS 測試
curl -k https://localhost/app/

# 5. 錯誤日誌
tail -20 /var/log/nginx/error.log
```

## 本次 Lab 遇到的錯誤（實例）

| 錯誤現象 | 可能原因 | 解決方式 |
|----------|----------|----------|
| curl 回傳 301 | HTTP 被強制轉 HTTPS | 改用 `curl -k https://...` |
| 壓力測試出現 503 | Rate Limiting 觸發 | 調高 `rate` 或 `burst` |
| 負載平衡全導向 backup | 所有 primary 可能掛了 | 檢查 web-01 的 Python 服務 |
