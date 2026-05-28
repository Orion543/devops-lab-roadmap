# Stage 03 - Shell Script + Git（業界實務版）

## 目標

建立 Git 版本控制習慣，寫出第一批可用的 Shell Script，並具備完整的錯誤處理與跨主機可攜能力。

## 環境資訊

| 主機 | IP | 角色 |
|------|-----|------|
| devops-admin | 192.168.0.101 | 管理主機 / Git 操作 |
| web-01 | 192.168.0.111 | 被檢查與備份的服務主機 |
| web-02 | 192.168.0.112 | 跨主機驗證 |

## 完成項目

### Git 技能
- ✅ 基礎操作：status、add、commit、push、pull、branch、merge
- ✅ 進階操作：stash、rebase、reflog、reset、revert
- ✅ 衝突解決實戰
- ✅ Commit 規範（feat、fix、docs、chore）
- ✅ Git 別名設定
- ✅ .gitignore 進階配置

### Shell Script 技能
- ✅ 3 支腳本：`sysinfo.sh`、`healthcheck.sh`、`backup.sh`
- ✅ 理解 shebang、`set -euo pipefail`
- ✅ 變數、條件判斷、exit code
- ✅ Script 權限與執行
- ✅ 錯誤處理與模擬測試

### 實務能力
- ✅ Script 跨主機可攜性
- ✅ Git + Script 整合工作流
- ✅ 完整文件與證據留存

## 執行方式

```
# 顯示系統資訊
./stage-03-shell-git/scripts/sysinfo.sh

# 檢查 web-01 服務健康狀態
./stage-03-shell-git/scripts/healthcheck.sh

# 備份（可指定目錄）
./stage-03-shell-git/scripts/backup.sh
./stage-03-shell-git/scripts/backup.sh /tmp/backups
```

## Commit 訊息規範

為了讓 Git 歷史一目瞭然，請依照以下格式撰寫 commit 訊息：

```
<type>(stage-<編號>): <簡短說明>
```

### 常用 type 類型

| 類型 | 用途 | 範例 |
|------|------|------|
| `feat` | 新增功能、腳本 | `feat(stage-03): add healthcheck script` |
| `fix` | 修正錯誤 | `fix(stage-03): fix permission issue` |
| `docs` | 文件更新 | `docs(stage-03): update scripting notes` |
| `chore` | 雜項（設定、依賴） | `chore(stage-03): update gitignore` |
| `refactor` | 重構（不改功能） | `refactor(stage-03): simplify healthcheck logic` |

> **注意**：括號內的 `stage-03` 可替換為實際階段編號（如 `stage-01`、`stage-02`）。

### 如何修正不符合規範的 commit？

```
# 修改最近一次 commit 的訊息
git commit --amend -m "feat(stage-03): add proper message"

# 修改更早的 commit（互動式 rebase）
git rebase -i HEAD~3
# 將要修改的 commit 前面的 pick 改為 reword（或 r），存檔後修改訊息
```

## 參考文件

- [git-notes.md](docs/git-notes.md)
- [scripting-notes.md](docs/scripting-notes.md)
- [troubleshooting.md](docs/troubleshooting.md)
- [conflict-resolution.md](docs/conflict-resolution.md)
- [advanced-git.md](docs/advanced-git.md)

## 證據目錄

- `evidence/git-config.txt` - Git 設定
- `evidence/git-log.txt` - Git 歷史
- `evidence/script-run.txt` - Script 執行輸出
- `evidence/error-case.txt` - 錯誤案例
- `evidence/conflict-test.txt` - 衝突解決測試
- `evidence/stash-test.txt` - Stash 測試
