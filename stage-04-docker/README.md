# Stage 04 - Docker（業界實務版）

## 目標

安裝 Docker，掌握容器生命週期、網路、Volume、Dockerfile 最佳實踐、資源限制與自動化腳本。

## 完成項目

- ✅ Docker 安裝與 group 設定
- ✅ container 基本操作（run、start、stop、rm、exec、logs）
- ✅ port mapping
- ✅ Docker 網路（bridge、自訂網路）
- ✅ Volume（bind mount + named volume）
- ✅ Dockerfile 最佳實踐（.dockerignore、HEALTHCHECK、LABEL）
- ✅ 資源限制（memory、cpu）
- ✅ 自動化腳本（build.sh、run.sh、clean.sh）
- ✅ 清理資源與排錯

## 執行方式

```
# Build image
./scripts/build.sh 1.0.0

# Run container
./scripts/run.sh

# Clean everything
./scripts/clean.sh
```

## 參考文件

- [docker-notes.md](docs/docker-notes.md)
- [container-vs-vm.md](docs/container-vs-vm.md)
- [networking.md](docs/networking.md)
- [volume.md](docs/volume.md)
- [best-practices.md](docs/best-practices.md)
- [troubleshooting.md](docs/troubleshooting.md)

## 證據目錄

- `evidence/docker-version.txt` - 版本與 info
- `evidence/docker-ps.txt` - 容器列表
- `evidence/docker-images.txt` - image 列表
- `evidence/docker-stats.txt` - 資源統計
- `evidence/docker-network.txt` - 網路資訊
- `evidence/docker-volume.txt` - Volume 列表
