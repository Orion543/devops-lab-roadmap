# Test Cases - Web Lab

## 測試目的

驗證 Nginx Web Server 與 Reverse Proxy 功能正常。

## 測試環境

- 管理主機：`devops-admin`（192.168.0.101）
- Web 主機：`web-01`（192.168.0.111）

## 測試項目

### TC-01：Nginx 是否正常運行

**指令：**

```
systemctl status nginx
```

**預期結果：**
`active (running)`

### TC-02：Nginx 是否正確監聽 Port 80

**指令：**

```
ss -tulpen | grep :80
```

**預期結果：**
看到 `LISTEN`、`*:80`、進程名 `nginx`

### TC-03：本機測試 Web 服務

**指令：**

```
curl http://localhost
```

**預期結果：**
回傳自訂首頁 HTML 內容

### TC-04：從 devops-admin 測試 Web 服務

**指令：**

```
curl http://web-01
```

**預期結果：**
回傳自訂首頁 HTML 內容

### TC-05：測試 HTTP Response Header

**指令：**

```
curl -I http://web-01
```

**預期結果：**
`HTTP/1.1 200 OK`

### TC-06：測試 Reverse Proxy（後端正常）

**指令：**

```
curl http://web-01/app/
```

**預期結果：**
回傳 `Backend Demo OK` 內容

### TC-07：測試 Reverse Proxy（後端異常）

**步驟：**
1. 停止 Python HTTP Server（Ctrl+C）
2. 執行 `curl -I http://web-01/app/`

**預期結果：**
`HTTP/1.1 502 Bad Gateway`

### TC-08：測試腳本

**指令：**

```
./stage-02-web-lab/scripts/test-connectivity.sh
```

**預期結果：**
兩次測試都回傳 `200 OK`

## 測試記錄（請自行填寫）

| 測試項 | 狀態 | 備註 |
|--------|------|------|
| TC-01 | ✅ / ❌ | |
| TC-02 | ✅ / ❌ | |
| TC-03 | ✅ / ❌ | |
| TC-04 | ✅ / ❌ | |
| TC-05 | ✅ / ❌ | |
| TC-06 | ✅ / ❌ | |
| TC-07 | ✅ / ❌ | |
| TC-08 | ✅ / ❌ | |
