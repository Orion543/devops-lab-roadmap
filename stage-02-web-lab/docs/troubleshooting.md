# Troubleshooting - Web Lab

## 常見錯誤與解法

### 1. curl 出現 `connection refused`

**可能原因：**
- Nginx 沒有啟動
- Port 80 沒有服務在聽

**排查步驟：**

```
systemctl status nginx
ss -tulpen | grep :80
```

### 2. curl 出現 `502 Bad Gateway`

**可能原因：**
- Reverse proxy 後端掛掉
- 後端服務沒啟動或 Port 錯誤

**排查步驟：**

```
curl http://127.0.0.1:5000/   # 測試後端
tail -f /var/log/nginx/error.log
```



### 3. curl 出現 `403 Forbidden`

```
**可能原因：**
- 檔案權限不足
- Nginx 沒有讀取權限

**排查步驟：**
ps aux | grep nginx
```

### 4. nginx -t 失敗

**可能原因：**
- 設定檔語法錯誤
- 缺少結尾分號
- 大括號沒有對稱

**排查步驟：**

```
sudo nginx -t   # 會顯示錯誤行號
```

## 服務打不通的通用排查流程

```
# 1. 服務狀態
systemctl status nginx

# 2. 監聽 Port
ss -tulpen | grep :80

# 3. 防火牆
sudo iptables -L INPUT -n -v

# 4. 本機測試
curl http://localhost

# 5. 錯誤日誌
tail -20 /var/log/nginx/error.log
```

## 本次 Lab 遇到的錯誤（請自行補充）

| 錯誤現象 | 可能原因 | 解決方式 |
|----------|----------|----------|
| （你遇到的） | （原因） | （解法） |
| （你遇到的） | （原因） | （解法） |
