# Nginx Notes

## 安裝與啟動

```
sudo apt update
sudo apt install -y nginx
sudo systemctl enable --now nginx
```

## 設定檔位置

| 檔案 | 用途 |
|------|------|
| `/etc/nginx/nginx.conf` | 主設定檔 |
| `/etc/nginx/sites-available/default` | 預設站台設定 |
| `/etc/nginx/sites-enabled/` | 啟用的站台（符號連結） |

## 常用指令

| 指令 | 說明 |
|------|------|
| `systemctl status nginx` | 查看狀態 |
| `sudo systemctl start nginx` | 啟動 |
| `sudo systemctl stop nginx` | 停止 |
| `sudo systemctl restart nginx` | 重啟（中斷連線） |
| `sudo systemctl reload nginx` | 重新載入設定（不中斷） |
| `sudo nginx -t` | 測試設定檔語法 |

## reload vs restart

| 方式 | 行為 | 適用情境 |
|------|------|----------|
| `reload` | 平滑重啟，不中斷現有連線 | 修改設定後 |
| `restart` | 完全停止再啟動，會中斷 | 排除問題或重大變更 |

## Reverse Proxy 設定

```
location /app/ {
    proxy_pass http://backend_servers/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

## Load Balancing（負載平衡）

### upstream 語法

```
upstream backend_servers {
    least_conn;   # 最少連線數演算法
    server 127.0.0.1:5000 weight=3 max_fails=3 fail_timeout=30s;
    server 127.0.0.1:5001 weight=2 max_fails=3 fail_timeout=30s;
    server 192.168.0.112:5000 backup;
    keepalive 32;
}
```

### 負載平衡演算法

| 演算法 | 說明 |
|--------|------|
| `rr`（預設） | 輪詢，依序分配 |
| `least_conn` | 分配給連線數最少的伺服器（實務常用） |
| `ip_hash` | 同一 IP 固定分配給同一台伺服器 |
| `weight` | 權重，越高分配到越多流量 |

## High Availability（高可用）

### 失敗偵測參數

| 參數 | 說明 |
|------|------|
| `max_fails=3` | 失敗 3 次後標記為 down |
| `fail_timeout=30s` | 30 秒後重新嘗試 |
| `backup` | 備用伺服器（其他全掛才啟用） |

## Rate Limiting（限流）

```
limit_req_zone $binary_remote_addr zone=api_limit:10m rate=30r/m;

location /app/ {
    limit_req zone=api_limit burst=10 nodelay;
    ...
}
```

## SSL/TLS 設定

```
server {
    listen 443 ssl http2;
    ssl_certificate /etc/nginx/ssl/nginx-selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx-selfsigned.key;
    ssl_protocols TLSv1.2 TLSv1.3;
}

server {
    listen 80;
    return 301 https://$server_name$request_uri;
}
```

## 設定修改流程

```
sudo vim /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl reload nginx
```

## 查看 Log

```
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
journalctl -u nginx
```
