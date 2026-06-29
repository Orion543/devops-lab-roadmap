# Docker Compose Best Practices

## 1. 使用 `.env` 管理環境變數

將敏感資訊或環境參數放入 `.env`，並確保 `.env` 在 `.gitignore` 中（或使用範例檔 `.env.example`）。

## 2. 設定資源限制

避免單一服務耗盡主機資源：

```yaml
deploy:
  resources:
    limits:
      cpus: '0.5'
      memory: 256M
```

## 3. 使用健康檢查

幫助 Docker 判斷容器是否就緒：

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 30s
  timeout: 3s
  retries: 3
```

## 4. 固定基礎映像版本

避免使用 `latest`，改用 `alpine` 或明確版本號。

## 5. 使用 `depends_on` 控制啟動順序

但僅確保先啟動，不保證服務就緒。搭配 `healthcheck` 使用更佳。

## 6. 善用 profiles（開發/生產分離）

```yaml
services:
  dev-tools:
    profiles: ["dev"]
    ...
  prod-app:
    profiles: ["prod"]
    ...
```

啟動時指定 profile：

```
docker compose --profile dev up
```

## 7. 定期清理

```
docker compose down -v
docker system prune -a
```

## 8. 使用 .dockerignore 加速 build 並保護機密

類似 `.gitignore`，`.dockerignore` 用來排除不需要複製進 image 的檔案，避免：
- 將 `.env`、`*.key` 等機密檔案意外打包進 image
- 將 `node_modules`、`__pycache__` 等大檔案或暫時檔案傳送給 Docker daemon，拖慢 build 速度

**範例**：

```dockerignore
.git/
.gitignore
README.md
*.md
.env
.venv
__pycache__
*.log
```
