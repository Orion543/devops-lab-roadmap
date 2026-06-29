# Stage 05 - Docker Compose（業界實務版）

## 目標

安裝 Docker Compose，掌握多服務管理、Volume 掛載、Service Name 通訊、資源限制、健康檢查、環境變數與自動化腳本。

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 |
| web-01 | 192.168.0.111 | Compose 實作主場 |

## 完成項目

- ✅ Docker Compose 安裝與驗證
- ✅ 第一個 `docker-compose.yml`（nginx 單服務）
- ✅ Volume 掛載自訂網頁
- ✅ 多服務架構（nginx → app）
- ✅ Compose network 與 service name 通訊
- ✅ 資源限制（memory、cpu）
- ✅ 健康檢查（healthcheck）
- ✅ 環境變數與 `.env` 檔案
- ✅ Build 本地 image 整合
- ✅ 操作腳本 `up.sh`、`down.sh`
- ✅ 清理指令（`down -v`、`prune`）

## 執行方式

```bash
# 啟動服務（含 build）
./scripts/up.sh

# 停止服務
./scripts/down.sh

# 查看日誌
./scripts/logs.sh
```

## 參考文件

- [compose-notes.md](docs/compose-notes.md)
- [networking.md](docs/networking.md)
- [troubleshooting.md](docs/troubleshooting.md)
- [best-practices.md](docs/best-practices.md)

## 證據目錄

- `evidence/compose-version.txt`
- `evidence/compose-ps.txt`
- `evidence/test-result.txt`
- `evidence/compose-logs.txt`
- `evidence/compose-build-ps.txt`

## 驗收標準

- ✅ `docker compose` 可正常使用
- ✅ 有第一個 `docker-compose.yml`
- ✅ nginx 可透過 8080 存取
- ✅ 能用 volume 掛自訂內容
- ✅ 完成 nginx → app 多服務架構
- ✅ 理解 service name 通訊
- ✅ 會用 `docker compose logs`、`ps`、`exec`
- ✅ 會用 `up` / `down` / `restart`
- ✅ 有 `up.sh` / `down.sh`
- ✅ 熟悉資源限制、環境變數、健康檢查
- ✅ repo 內有完整文件與證據
