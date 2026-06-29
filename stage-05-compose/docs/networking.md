# Docker Compose Networking

## 預設網路

Compose 會為專案建立一個預設網路（命名為 `目錄名_default`），所有服務自動加入。

## Service Name 作為 DNS 名稱

- 服務之間可以透過 `service name` 互相連線。
- 例如 `nginx` 服務可存取 `http://app:5000`，Compose 會自動解析到 app 容器的 IP。

## 自訂網路

```yaml
networks:
  app-network:
    driver: bridge

services:
  web:
    networks:
      - app-network
  app:
    networks:
      - app-network
```

## 驗證 DNS 解析

```
docker compose exec web sh
apk add curl
curl http://app:5000
```
