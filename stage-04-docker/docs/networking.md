# Docker Networking

## 網路模式

| 模式 | 說明 | 使用情境 |
|------|------|----------|
| `bridge`（預設） | 透過 NAT 與主機通訊 | 單機開發 |
| `host` | 直接使用主機網路 | 效能要求高 |
| `none` | 無網路 | 隔離環境 |
| 自訂 bridge | 容器間可用名稱通訊 | **實務最常用** |

## 自訂 bridge 網路 vs 預設 bridge 的差異

| 特性 | 預設 bridge | 自訂 bridge |
|------|-------------|-------------|
| 容器間自動 DNS 解析 | ❌（需用 `--link`） | ✅（可用容器名稱通訊） |
| 網路隔離 | 較差（所有容器預設互通） | 可建立多個隔離網路 |
| 設定方式 | 無法事後改變 | 彈性高 |

實務上建議使用自訂 bridge 網路，方便容器間通訊與服務發現。

## 常用指令

```
docker network ls
docker network create my-net
docker run --network my-net --name app1 nginx
docker exec app1 ping app2
docker network inspect my-net
docker network rm my-net
```

## 自訂網路的優點

- 自動 DNS 解析（容器名稱即可通訊）
- 更好的隔離性
- 可指定 subnet、gateway
