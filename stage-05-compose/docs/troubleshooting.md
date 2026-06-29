# Troubleshooting - Docker Compose

## 常見錯誤

### 1. 容器啟動失敗

```
docker compose logs <service>
docker compose ps
docker compose config
```

### 2. 連接 refused (502 Bad Gateway)

- 確認 app 服務是否正常：`docker compose logs app`
- 確認 nginx 設定中的 proxy_pass 服務名稱正確
- 確認網路：`docker compose exec web ping app`

### 3. 磁碟空間不足

```
docker system prune -a
docker volume prune
```

### 4. 版本不相容

若出現 `version` 相關錯誤，移除 `version:` 行。

### 5. build 失敗

- 檢查 Dockerfile 語法：`docker build -t test .`
- 檢查 `.dockerignore` 是否排除了必要檔案
- 增加 `--progress=plain` 查看詳細輸出

### 6. app 服務崩潰（502 Bad Gateway）

**模擬方式**（kill process）：

```bash
# 1. 確認 app 容器正常運行
docker compose ps

# 2. 查看 container 內的 Python process
docker compose exec app ps aux

# 3. 強制終止 Python process（模擬服務崩潰）
docker compose exec app kill -9 1

# 4. 測試服務是否已崩潰
curl http://localhost:8080/app/
```

**症狀**：
- `curl http://localhost:8080/app/` 回傳 `502 Bad Gateway`
- `docker compose logs web` 顯示 `connect() failed (111: Connection refused) while connecting to upstream`
- `docker compose ps` 顯示 app 容器狀態為 `Up (unhealthy)`

**排查步驟**：

```bash
# 1. 查看容器狀態
docker compose ps

# 2. 查看 Nginx 日誌（確認 upstream 連線失敗）
docker compose logs web --tail=20

# 3. 手動測試 app 服務是否還在聽
curl http://localhost:5000
```

**恢復方式**：

```bash
# 強制重建 app 容器
docker compose up -d --force-recreate app

# 再次測試
curl http://localhost:8080/app/
```

### 7. Nginx 因 upstream 名稱錯誤拒絕啟動（Connection reset）

**模擬方式**：

```bash
sed -i 's|proxy_pass http://app:5000/;|proxy_pass http://app-wrong:5000/;|' nginx/default.conf
docker compose restart web
```

**症狀**：
- `curl http://localhost:8080/app/` 回傳 `curl: (56) Recv failure: Connection reset by peer`
- `docker compose logs web` 顯示 `[emerg] host not found in upstream "app-wrong"`

**原因**：
- Nginx 在啟動時會解析 `upstream` 中的主機名稱。如果名稱不存在，Nginx 會拒絕啟動。

**解法**：

```bash
# 方法 1：還原備份
cp nginx/default.conf.bak nginx/default.conf

# 方法 2：修正 proxy_pass 為正確的服務名稱
sed -i 's|proxy_pass http://app-wrong:5000/;|proxy_pass http://app:5000/;|' nginx/default.conf

# 重新啟動 compose
docker compose down && docker compose up -d
```


**核心學習點**：

- 容器狀態 `Up` **不等於** 服務正常（`healthy`）
- Healthcheck 是判斷服務是否真正可用的關鍵
- `502 Bad Gateway` 通常代表 Nginx 有啟動，但後端服務沒有正常回應
- `Connection refused` 表示 upstream 服務沒有在監聽指定的 port
- `curl: (56) Connection reset by peer` 不等於 502，它表示服務根本沒啟動
- 502 是 Nginx 有啟動但後端掛掉；Connection reset 是 Nginx 連啟動都沒成功
- 修改設定後，若 Nginx 無法解析 upstream 名稱，會導致啟動失敗，此時應檢查 `proxy_pass` 的目標服務名稱是否正確，且該服務是否已定義在 compose 檔案中。

## 通用除錯流程

1. `docker compose ps` – 查看狀態
2. `docker compose logs --tail=50` – 撈取最新日誌
3. `docker compose config` – 驗證設定檔
4. `docker compose exec <service> sh` – 進入容器手動檢查
