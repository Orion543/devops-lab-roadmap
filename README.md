# DevOps Lab Roadmap

> 從 Linux 基礎到自動化部署的 12 階段實作學習之旅

## 專案目的

這是我個人 DevOps 技能養成的實作紀錄。目標不是背指令，而是建立一套**可重現、可驗證、可維護**的實戰能力。

最終期望達成：
- ✅ 會建環境
- ✅ 會部署
- ✅ 會自動化
- ✅ 會排錯
- ✅ 會監控
- ✅ 會把過程整理成可維護的工程專案

---

## Lab 環境

| 項目 | 規格 |
|------|------|
| 虛擬化 | VMware / VirtualBox |
| OS | Ubuntu Server 24.04 LTS |
| 管理機 | devops-admin (192.168.0.101) |
| 節點 1 | web-01 (192.168.0.111) |
| 節點 2 | web-02 (192.168.0.112) |
| 管理帳號 | orion |

---

## Repository 結構

| 目錄 | 主題 | 說明 |
|------|------|------|
| `stage-01-linux-lab/` | Linux 基礎 | 主機安裝、SSH、systemd、journalctl |
| `stage-02-web-lab/` | Web 服務 | nginx、reverse proxy、防火牆 |
| `stage-03-shell-git/` | Shell + Git | 腳本撰寫、版本控制習慣 |
| `stage-04-docker/` | Docker | container、image、Dockerfile |
| `stage-05-compose/` | Docker Compose | 多服務管理 |
| `stage-06-ci/` | CI | GitHub Actions 自動化 |
| `stage-07-ansible/` | Ansible | 自動化配置管理 |
| `stage-08-deploy/` | Deploy | CI + Ansible 串接部署 |
| `stage-09-cloud/` | Cloud | 雲端基礎概念 |
| `stage-10-terraform/` | Terraform | Infrastructure as Code |
| `stage-11-monitoring/` | Monitoring | 監控與觀測 |
| `stage-12-final-project/` | Final Project | 整合專案 |

---

## 學習路線

| Stage | 完成後會學到 |
|-------|--------------|
| 01 | 主機安裝、固定 IP、SSH Key 管理、systemd、journalctl |
| 02 | nginx 安裝與管理、reverse proxy、防火牆 |
| 03 | Git 基本操作、Shell Script 撰寫 |
| 04 | Docker 基本操作、Dockerfile 撰寫 |
| 05 | docker-compose 多服務管理 |
| 06 | GitHub Actions CI 流程 |
| 07 | Ansible 自動化配置 |
| 08 | 自動部署流程 |
| 09 | 雲端基礎 |
| 10 | Terraform IaC |
| 11 | 監控與告警 |
| 12 | 整合以上能力完成專案 |

---

## 使用方式

### 每個 Stage 的目錄結構
stage-XX-xxx/
├── README.md
├── docs/
├── scripts/
├── systemd/
└── evidence/
text

### 維護原則

1. 每完成一個小段落，就做一次 commit
2. 文件重點記錄：做了什麼、為什麼、怎麼驗證、如何排錯
3. 進度追蹤使用外部 Google Sheet
4. 本 repo 只保留正式產出（文件、腳本、設定、證據）

---

## 目前進度

- 📍 當前階段：Stage 01 - Linux Lab（進行中）
- 📊 詳細進度：追蹤於 Google Sheet
- 🎯 下一目標：完成 Stage 01 並進入 Stage 02

---

## Commit Convention

| 類型 | 用途 | 範例 |
|------|------|------|
| `init(...)` | 初始化結構 | `init(stage-01): create linux lab structure` |
| `feat(...)` | 新增功能/腳本/設定 | `feat(stage-04): add first custom dockerfile` |
| `docs(...)` | 文件更新 | `docs(stage-07): finalize ansible lab notes` |
| `fix(...)` | 修正錯誤 | `fix(stage-01): correct netplan config` |

---

## 作者

- GitHub: [Orion543](https://github.com/Orion543)
- 學習目標：DevOps 工程師技能養成

---

## License

本專案僅供個人學習使用。
