# Docker Volume

## 三種掛載方式

| 類型 | 指令 | 管理方式 | 使用情境 |
|------|------|----------|----------|
| bind mount | `-v /host/path:/container/path` | 使用者 | 開發、設定檔 |
| named volume | `-v volume-name:/container/path` | Docker | **正式環境、資料持久化** |
| tmpfs | `--tmpfs /container/path` | Docker | 暫存資料 |


## Bind Mount vs Named Volume 的選擇

| 類型 | 適用情境 | 優點 | 缺點 |
|------|----------|------|------|
| bind mount | 開發環境、設定檔 | 直接修改本機檔案，立即生效 | 依賴本機路徑，可攜性差 |
| named volume | 正式環境、資料庫 | Docker 管理，備份/還原容易，跨主機友善 | 無法直接用編輯器修改內容 |

**建議**：開發時用 bind mount，正式上線用 named volume。


## Named Volume 操作

```
docker volume create my-data
docker volume ls
docker volume inspect my-data
docker run -v my-data:/data alpine
docker volume prune
docker volume rm my-data
```

## 備份与還原

```
# 備份 volume 內容
docker run --rm -v my-data:/source -v $(pwd):/backup alpine tar czf /backup/my-data-backup.tar.gz -C /source .

# 還原
docker run --rm -v my-data:/target -v $(pwd):/backup alpine tar xzf /backup/my-data-backup.tar.gz -C /target
```
