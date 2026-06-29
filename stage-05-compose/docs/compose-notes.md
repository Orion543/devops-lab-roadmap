# Docker Compose Notes

## 安裝與驗證

```
sudo apt install -y docker-compose-plugin
docker compose version
```

## 常用指令

| 指令 | 說明 |
|------|------|
| `docker compose up -d` | 背景啟動服務 |
| `docker compose down` | 停止並移除服務 |
| `docker compose down -v` | 同時移除 volumes |
| `docker compose ps` | 查看服務狀態 |
| `docker compose logs` | 查看日誌 |
| `docker compose exec <service> sh` | 進入容器 |
| `docker compose restart` | 重啟服務 |
| `docker compose build` | 重建映像 |
| `docker compose config` | 驗證設定檔 |

## Build 與快取

- `docker compose build`：重建 image（會使用快取）
- `docker compose build --no-cache`：**強制重建，不使用任何快取**，確保 `COPY` 等指令確實執行。
- `docker compose up -d --build`：重建 image 並啟動服務（等同 `build` + `up -d`）

> **實務提醒**：當你修改了 `Dockerfile` 或 `COPY` 的檔案內容，
但 `docker compose up -d` 沒有反應時，可能是快取導致。請使用 `--no-cache` 強制重建。

## docker-compose.yml 基本結構

```yaml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./app:/usr/share/nginx/html
    environment:
      - VAR=value
    env_file:
      - .env
    depends_on:
      - app
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M
```

## 現代語法無需 `version` 欄位

自 Compose V2 起，直接以 `services` 開頭即可。
