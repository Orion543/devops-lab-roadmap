# Stage 01 - Linux Lab

## 目標

建立 DevOps Lab 的基礎 Linux 環境，熟悉系統管理與自動化基本工具。

## 完成項目

- ✅ 三台 Ubuntu Server 24.04 LTS VM（devops-admin、web-01、web-02）
- ✅ 固定 IP 設定（Netplan）
- ✅ SSH Key 管理（多把 key + SSH config）
- ✅ 基礎初始化腳本（bootstrap.sh）
- ✅ systemd 服務管理（systemctl）
- ✅ journald 日誌查詢（journalctl）
- ✅ 自建 systemd service（lab-heartbeat.service）
- ✅ 檔案傳輸（scp / rsync）

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 |
| web-01 | 192.168.0.111 | Web 服務主機 |
| web-02 | 192.168.0.112 | 第二節點 |

## 證據目錄

- `evidence/` 包含所有指令輸出證明
- `systemd/` 包含自建 service 檔案
- `scripts/` 包含 bootstrap.sh

## 參考文件

- [lab-topology.md](docs/lab-topology.md)
- [access-notes.md](docs/access-notes.md)
- [service-notes.md](docs/service-notes.md)
- [troubleshooting.md](docs/troubleshooting.md)
- [command-cheatsheet.md](docs/command-cheatsheet.md)
