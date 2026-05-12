# Test Cases - Web Lab

## 測試目的

驗證 Nginx Web Server、Reverse Proxy、Load Balancing、High Availability、SSL/TLS、Rate Limiting 功能正常。

## 測試環境

- 管理主機：`devops-admin`（192.168.0.101）
- Web 主機：`web-01`（192.168.0.111）

## 基礎測試項目（HTTPS）

### TC-01：Nginx 是否正常運行

```
systemctl status nginx
```
預期：`active (running)`

### TC-02：Nginx 是否正確監聽 Port 443

```
ss -tulpen | grep :443
```
預期：看到 `LISTEN`、`*:443`

### TC-03：HTTPS 本機測試

```
curl -k https://localhost/app/
```
預期：回傳 Backend 內容

### TC-04：從 devops-admin 測試 HTTPS

```
curl -k https://web-01/app/
```
預期：回傳 Backend 內容

### TC-05：HTTP 自動轉 HTTPS

```
curl -I http://web-01/app/ | grep -i location
```
預期：`Location: https://_/app/`

## Load Balancing 測試項目

### TC-LB-01：least_conn 演算法

多次執行：
```
for i in 1 2 3 4 5; do curl -k -s https://web-01/app/ | grep "Served"; done
```
預期：連線數少的後端會優先收到請求。

## High Availability 測試項目

### TC-HA-01：停掉 web-01:5000

```
ssh orion@web-01 "pkill -f 'python3 -m http.server 5000'"
curl -k -I https://web-01/app/ | head -1
```
預期：`HTTP/2 200`（切換到 5001）

### TC-HA-02：停掉所有 primary

```
ssh orion@web-01 "pkill -f 'python3 -m http.server 5000'; pkill -f 'python3 -m http.server 5001'"
curl -k -I https://web-01/app/ | head -1
```
預期：`HTTP/2 200`（切換到 web-02 backup）

## Rate Limiting 測試項目

### TC-RL-01：超過限制時回傳 503

傳送 20 個請求：
```
for i in {1..20}; do curl -k -s -o /dev/null -w "%{http_code}\n" https://web-01/app/; done
```
預期：前約 11 個 `200`，後續 `503`。

## 測試記錄（實際結果）

| 測試項 | 狀態 | 備註 |
|--------|------|------|
| TC-01 | ✅ | |
| TC-02 | ✅ | |
| TC-03 | ✅ | |
| TC-04 | ✅ | |
| TC-05 | ✅ | 301 轉向 |
| TC-LB-01 | ✅ | least_conn 正常 |
| TC-HA-01 | ✅ | 自動切換 |
| TC-HA-02 | ✅ | backup 接手 |
| TC-RL-01 | ✅ | 第 12 個請求開始 503 |
