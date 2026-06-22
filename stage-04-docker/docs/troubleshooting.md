# Troubleshooting - Docker

## 常見錯誤與解法

### 1. port already allocated

**錯誤：** `port is already allocated`

**解法：**
```
# 找出佔用 port 的容器
docker ps | grep 8080
docker stop <id>
# 或改用其他 port
docker run -d -p 8081:80 nginx
```

### 2. permission denied (docker.sock)

**錯誤：** `Got permission denied while trying to connect to the Docker daemon socket`

**解法：**
```
sudo usermod -aG docker $USER
# 重新登入
exit
ssh user@host
```

### 3. COPY failed: file not found

**錯誤：** `COPY failed: file not found in build context`

**解法：**
- 確認檔案路徑相對於 build context 正確
- 檢查 `.dockerignore` 是否排除該檔案

### 4. Unable to find image locally

**錯誤：** `Unable to find image 'my-nginx:latest' locally`

**解法：**
```
docker images
docker build -t my-nginx:latest .
```

### 5. container 一直重啟

**檢查：**
```
docker ps -a
docker logs <id>
docker inspect <id> | grep -A 5 "State"
```

### 6. no space left on device

**錯誤：** Docker 磁碟空間不足

**解法：**
```
docker system prune -a
docker system df
```

## 通用排查流程

1. `docker ps -a` - 容器狀態
2. `docker logs <id>` - 查看日誌
3. `docker inspect <id>` - 詳細資訊
4. `docker system df` - 磁碟空間
