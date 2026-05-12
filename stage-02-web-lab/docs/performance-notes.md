# Nginx Performance Notes

## Worker 調校

| 參數 | 建議值 | 說明 |
|------|--------|------|
| `worker_processes auto` | 等於 CPU 核心數 |  |
| `worker_connections 4096` | 視記憶體而定 | 每個 worker 最大連線數 |
| `worker_rlimit_nofile 65535` | 最大開啟檔案數 | 需超過 worker_connections |
| `use epoll` | Linux 高效能事件模型 |  |
| `multi_accept on` | 一次接受所有連線 |  |

## 完整效能設定範例

```
user www-data;
worker_processes auto;
worker_rlimit_nofile 65535;

events {
    worker_connections 4096;
    use epoll;
    multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    
    keepalive_timeout 65;
    client_body_timeout 12;
    client_header_timeout 12;
    send_timeout 10;
    
    client_body_buffer_size 16K;
    client_header_buffer_size 1k;
    large_client_header_buffers 4 8k;
    
    # Gzip 壓縮
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript 
               application/json application/javascript application/xml+rss
               application/rss+xml image/svg+xml;
    
    # 快取設定
    open_file_cache max=1000 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 2;
    open_file_cache_errors on;
    
    # 日誌格式（含回應時間）
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for" '
                    '$request_time $upstream_response_time';
    
    access_log /var/log/nginx/access.log main buffer=32k flush=5s;
}
```

## Gzip 壓縮

開啟 gzip 可減少 70% 傳輸量，但會增加 CPU 使用。

## 快取設定

| 參數 | 說明 |
|------|------|
| `open_file_cache` | 快取檔案描述符 |
| `open_file_cache_valid` | 快取有效時間 |
| `open_file_cache_min_uses` | 最少使用次數才快取 |

## 壓力測試（使用 HTTPS）

```
# 安裝 apache2-utils
sudo apt install -y apache2-utils

# 測試反向代理效能（1000 請求，100 併發）
ab -n 1000 -c 100 https://web-01/app/

# 測試時忽略憑證驗證（自簽憑證）
ab -n 1000 -c 100 -k https://web-01/app/
```
