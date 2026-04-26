# Stage 02 - Web Lab (Nginx + Reverse Proxy)

## 目標

建立 Web 服務基礎，理解 HTTP、Port、Firewall、Reverse Proxy 與基本排錯能力。

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 |
| web-01 | 192.168.0.111 | Web 服務主機 |
| web-02 | 192.168.0.112 | 輔助測試主機 |

## 完成項目

- ✅ 安裝並啟動 Nginx
- ✅ 自訂首頁
- ✅ 理解 iptables 與 port 概念
- ✅ curl 測試 Web 服務
- ✅ 設定 Reverse Proxy（Nginx → Python HTTP Server）
- ✅ 模擬與排錯（502、403、connection refused）
- ✅ 建立測試腳本 test-connectivity.sh

## 架構圖

```
Client (devops-admin)
    │
    │ HTTP / curl
    ▼
web-01:80 (Nginx)
    │
    │ proxy_pass /app/
    ▼
127.0.0.1:5000 (Python HTTP Server)
```

## 參考文件

- [network-notes.md](docs/network-notes.md)
- [nginx-notes.md](docs/nginx-notes.md)
- [troubleshooting.md](docs/troubleshooting.md)
- [test-cases.md](docs/test-cases.md)

## 證據目錄

- `evidence/` - curl 測試結果、nginx 狀態、錯誤案例
- `nginx/` - nginx 設定檔備份
- `scripts/` - 測試腳本
