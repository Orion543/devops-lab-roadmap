# Stage 02 - Web Lab (Enterprise Edition)

## 目標

建立企業級 Web 服務，包含 Reverse Proxy、Load Balancing、HA、SSL/TLS、Rate Limiting、效能調校與完整監控。

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 |
| web-01 | 192.168.0.111 | Nginx Load Balancer + SSL |
| web-02 | 192.168.0.112 | Backup Backend |

## 完成項目

- ✅ 安裝 Nginx + 自訂網頁
- ✅ iptables 防火牆實戰
- ✅ Reverse Proxy（Nginx → Python Backend）
- ✅ Load Balancing（`least_conn` + 權重）
- ✅ High Availability（`max_fails` + `backup`）
- ✅ SSL/TLS（自簽憑證 + HTTP/2）
- ✅ 效能調校（worker、gzip、快取）
- ✅ Rate Limiting（`30r/m` + `burst=10`）
- ✅ Log 分析腳本
- ✅ 壓力測試（ab）
- ✅ 連通性測試腳本

## 架構圖

```
                    ┌─────────────────────────────────────────┐
                    │         Nginx (web-01:443)              │
                    │      SSL Termination + Load Balancer    │
                    │                                         │
                    │  upstream backend_servers {            │
                    │    least_conn;                         │
                    │    server web-01:5000 weight=3;        │
                    │    server web-01:5001 weight=2;        │
                    │    server web-02:5000 backup;          │
                    │  }                                      │
                    └─────────────────────────────────────────┘
                                      │
            ┌─────────────────────────┼─────────────────────────┐
            │                         │                         │
            ▼                         ▼                         ▼
    ┌───────────────┐         ┌───────────────┐         ┌───────────────┐
    │  web-01:5000  │         │  web-01:5001  │         │  web-02:5000  │
    │   (weight=3)  │         │   (weight=2)  │         │   (backup)    │
    └───────────────┘         └───────────────┘         └───────────────┘
```

## 執行方式

```
# 連通性測試（HTTPS）
./stage-02-web-lab/scripts/test-connectivity.sh

# 壓力測試（需先安裝 apache2-utils）
ab -n 1000 -c 100 -k https://web-01/app/

# Log 分析（在 web-01 執行）
sudo ./stage-02-web-lab/scripts/log-analysis.sh
```

## 參考文件

- [network-notes.md](docs/network-notes.md)
- [nginx-notes.md](docs/nginx-notes.md)
- [ssl-notes.md](docs/ssl-notes.md)
- [performance-notes.md](docs/performance-notes.md)
- [troubleshooting.md](docs/troubleshooting.md)
- [test-cases.md](docs/test-cases.md)

## 證據目錄

- `evidence/curl-test.txt` - curl 測試
- `evidence/nginx-status.txt` - nginx 狀態
- `evidence/reverse-proxy.txt` - 反向代理測試
- `evidence/lb-test.txt` - 負載平衡測試
- `evidence/ha-test.txt` - HA 測試
- `evidence/ssl-test.txt` - SSL 測試
- `evidence/rate-limit-test.txt` - Rate Limiting 測試
- `evidence/perf-test.txt` - 壓力測試
- `evidence/log-analysis.txt` - Log 分析
- `evidence/connectivity-test.txt` - 連通性測試
