# Container vs VM

## 對比表

| 特性 | Container | Virtual Machine |
|------|-----------|-----------------|
| 啟動速度 | 秒級 | 分鐘級 |
| 大小 | MB 級 | GB 級 |
| 資源佔用 | 少量 | 完整 OS |
| 隔離層級 | 程序級 | 硬體虛擬化 |
| 核心共用 | 共用 host 核心 | 各自獨立核心 |

## Container 優勢

- 輕量、快速、可攜
- 適合微服務、CI/CD
- 開發與正式環境一致

## Volume 為什麼重要？

Container 本身是暫時性的，刪除後內部資料會消失。Volume 提供持久化儲存。
