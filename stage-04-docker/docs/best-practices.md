# Docker Best Practices

## Dockerfile 最佳實踐

1. **使用特定 tag，避免 latest**
   ```
   FROM nginx:1.25-alpine
   ```

2. **設定 .dockerignore**（類似 .gitignore）

3. **合併 RUN 指令，減少 layer**
   ```
   RUN apt update && apt install -y curl && apt clean
   ```

4. **使用多階段建構**（編譯型應用）

5. **設定 HEALTHCHECK**
   ```
   HEALTHCHECK --interval=30s CMD curl -f http://localhost/ || exit 1
   ```

6. **使用 LABEL 標記**
   ```
   LABEL maintainer="email" version="1.0"
   ```

## 資源限制

```
docker run -d --memory="256m" --cpus="0.5" nginx
```

## Image Tag 命名建議

| 格式 | 範例 |
|------|------|
| 語意化版本 | `myapp:1.2.3` |
| 日期 | `myapp:20260101` |
| git commit | `myapp:git-abc1234` |
| 環境 | `myapp:prod`, `myapp:staging` |

## 清理資源

定期執行 `docker system prune -a` 釋放磁碟空間。

## 為什麼要用 Alpine 版本？

Alpine Linux 非常輕量（基礎 image 僅約 5MB），可以大幅縮小最終 image 體積、減少漏洞攻擊面，同時加快下載與部署速度。

## 為什麼要設定 HEALTHCHECK？

`HEALTHCHECK` 讓 Docker（或 Kubernetes、Swarm）能夠定期檢查容器是否「健康」。
如果檢查失敗，編排系統可以自動重啟容器或切換流量，提高服務可用性。

## 為什麼要使用 .dockerignore？

- **加速 build**：避免將不需要的檔案（如 `.git`、`node_modules`、`*.log`）打包到 build context 中。
- **防止機密洩漏**：避免將 `.env`、金鑰等敏感檔案意外複製進 image。

## 為什麼要避免使用 `latest` tag？

- `latest` 會隨著時間指向不同的 image 版本，造成「昨天還可以，今天突然壞了」的不可預期行為。
- 在正式環境中，應使用語意化版本（如 `1.0.0`）或 git commit hash，確保部署的可重現性。
