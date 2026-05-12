# SSL/TLS Notes

## 憑證類型

| 類型 | 用途 | 取得方式 |
|------|------|----------|
| 自簽憑證 | 開發/測試環境 | `openssl req -x509 -nodes ...` |
| Let's Encrypt | 正式環境（免費） | `certbot` |
| 商業憑證 | 正式環境（付費） | 向 CA 購買 |

## 產生自簽憑證（測試用）

```
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -subj "/C=TW/ST=Taipei/L=Taipei/O=Lab/CN=web-01"

sudo chmod 600 /etc/nginx/ssl/nginx-selfsigned.key
```

## 安裝 certbot（Let's Encrypt）

```
sudo apt install -y certbot python3-certbot-nginx

# 需要真實 domain
sudo certbot --nginx -d your-domain.com

# 自動 renew
sudo systemctl enable --now certbot.timer
```

## Nginx SSL 設定範例

```
server {
    listen 443 ssl http2;
    server_name _;
    
    ssl_certificate /etc/nginx/ssl/nginx-selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx-selfsigned.key;
    
    # SSL 最佳實踐
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    
    # 安全標頭
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
}

# HTTP 重導向到 HTTPS
server {
    listen 80;
    server_name _;
    return 301 https://$server_name$request_uri;
}
```

## 驗證 HTTPS

```
# 測試 HTTPS（忽略自簽憑證警告）
curl -k https://web-01/

# 驗證 HTTP 自動轉 HTTPS
curl -I http://web-01/ | grep -i location
```
