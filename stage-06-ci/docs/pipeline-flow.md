# CI Pipeline Flow

## 流程圖

```text
Developer pushes code to main
         │
         ▼
GitHub Actions workflow triggered
         │
         ▼
Runner checks out repository (actions/checkout@v5)
         │
         ▼
Shell script executed (sysinfo.sh)
         │
         ▼
Docker image built (docker build)
         │
         ▼
Container started (docker run -d -p 8080:80)
         │
         ▼
Healthcheck script executed (healthcheck-ci.sh)
         │
         ▼
   ┌─────┴─────┐
   │           │
Success     Failure
(exit 0)    (exit 1)
   │           │
   ▼           ▼
  Pass        Fail
```

## 關鍵決策點

| 步驟 | 成功條件 | 失敗條件 |
|------|----------|----------|
| Checkout | repo 可被正常 clone | 權限不足、repo 不存在 |
| Shell script | exit code = 0 | exit code ≠ 0 |
| Docker build | Dockerfile 語法正確、檔案存在 | 路徑錯誤、COPY 檔案不存在 |
| Run container | port 可用、image 存在 | port 已被佔用、image 載入失敗 |
| Healthcheck | HTTP 200 | HTTP 非 200、連線逾時 |

## 各步驟說明

| 步驟 | 執行內容 | 對應檔案 |
|------|----------|----------|
| Checkout | 將 repo 內容下載到 runner | `actions/checkout@v5` |
| Shell script | 執行系統資訊檢查 | `stage-03-shell-git/scripts/sysinfo.sh` |
| Docker build | 建構自訂 Nginx image | `stage-04-docker/docker/Dockerfile` |
| Run container | 啟動容器並對應 port 8080 | `docker run -d -p 8080:80` |
| Healthcheck | 檢查服務是否正常回應 | `stage-06-ci/scripts/healthcheck-ci.sh` |

## CI 與本地執行的差異

| 項目 | 本地執行 | CI 執行 |
|------|----------|---------|
| 環境 | 你的 devops-admin | GitHub 的 ubuntu-latest runner |
| Docker | 需自行安裝 | 預設已安裝 |
| 檔案路徑 | 絕對路徑或相對路徑 | 相對於 repo 根目錄 |
| 執行權限 | 你已設定好 | 每次需重新賦予（chmod +x） |
| 持久化 | 檔案會保留 | 每次都是全新的環境 |
