# Docker Notes

## 安裝與設定

```
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

## 常用指令速查

| 指令 | 說明 |
|------|------|
| `docker ps` | 列出運行中的容器 |
| `docker ps -a` | 列出所有容器 |
| `docker images` | 列出本機 image |
| `docker run -d image` | 背景執行容器 |
| `docker stop/start/restart id` | 停止/啟動/重啟 |
| `docker rm id` | 刪除容器 |
| `docker rmi image` | 刪除 image |
| `docker logs id` | 查看日誌 |
| `docker exec -it id bash` | 進入容器 |
| `docker network ls` | 列出網路 |
| `docker volume ls` | 列出 volume |

## Port Mapping

`-p 主機埠:容器埠`，例如 `-p 8080:80` 將主機 8080 對應到容器 80。

## 資源限制

```
--memory="256m" --cpus="0.5"
```

## 清理指令

```
docker system prune -a
docker container prune
docker image prune
docker volume prune
```

## 為什麼要將使用者加入 docker group？

加入 `docker` group 可以讓你執行 `docker` 指令時不需要每次輸入 `sudo`，提升操作效率。  
**但請注意**：這等同於賦予該使用者 root 權限（因為可以控制 Docker daemon）。
在正式環境中，應謹慎管理 `docker` group 的成員。

## 為什麼要用 `-d` 參數？

`docker run -d` 表示「detach」模式，讓容器在背景執行，不會佔住終端機。
適合長期運行的服務（如 web server）。若不加 `-d`，容器會在前景執行，按 `Ctrl+C` 就會停止。




