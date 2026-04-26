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

## Reverse Proxy 設定範例

```
location /app/ {
    proxy_pass http://127.0.0.1:5000/;
}
```

| 指令 | 說明 |
|------|------|
| `proxy_pass` | 轉發請求到後端伺服器 |
| `http://127.0.0.1:5000/` | 後端位址（結尾的 / 很重要） |

## 設定修改流程

```
sudo vim /etc/nginx/sites-available/default
sudo nginx -t              # 先測語法
sudo systemctl reload nginx # 成功才 reload
```

## 網頁根目錄

- 預設：`/var/www/html/`
- 自訂首頁：修改 `index.html`

## 查看 Log

```
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
journalctl -u nginx
```
