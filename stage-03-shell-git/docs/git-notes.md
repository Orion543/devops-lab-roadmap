# Git Notes - 基礎與進階操作

## 基本設定

```
git config --global user.name "你的名字"
git config --global user.email "你的信箱"
git config --global --list
```

## Git 別名（節省時間）

```
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.last "log -1 HEAD"
git config --global alias.unstage "reset HEAD --"

# 差異工具
git config --global merge.tool vimdiff
git config --global diff.tool vimdiff

# 自動修正打錯的指令
git config --global help.autocorrect 10
```

## 基本工作流程

| 指令 | 說明 |
|------|------|
| `git status` | 查看目前狀態 |
| `git add .` | 加入所有變更到暫存區 |
| `git commit -m "訊息"` | 提交版本 |
| `git push` | 推送到 GitHub |
| `git pull` | 從 GitHub 拉回最新內容 |
| `git log --oneline` | 查看簡潔歷史 |

## 分支操作

```
# 查看分支
git branch

# 建立並切換到新分支
git checkout -b feature/分支名稱

# 切換分支
git checkout main

# 合併分支
git merge feature/分支名稱

# 刪除分支
git branch -d feature/分支名稱
```

## 常用指令速查

| 指令 | 說明 |
|------|------|
| `git diff` | 查看未暫存的變更 |
| `git diff --staged` | 查看已暫存的變更 |
| `git log --oneline -10` | 最近 10 筆 commit |
| `git show commit-hash` | 查看特定 commit 內容 |
| `git remote -v` | 查看遠端設定 |

## Commit 訊息規範（Conventional Commits）

為了讓 Git 歷史一目瞭然，並且能自動產生版本紀錄，建議依照以下格式撰寫 commit 訊息：

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

> **注意**：括號內的 `stage-03` 可以替換成實際的階段編號（如 `stage-01`、`stage-02`）。

### 為什麼要這樣寫？

- **方便搜尋**：用 `git log --grep="feat"` 可以快速找出所有新增功能。
- **自動產生 Changelog**：許多工具可以根據這些前綴自動產生版本更新紀錄。
- **團隊協作**：讓其他人一眼看出這個 commit 的性質。

### 如何修正不符合規範的 commit？

```
# 修改最近一次 commit 的訊息
git commit --amend -m "feat(stage-03): add proper message"

# 修改更早的 commit（互動式 rebase）
git rebase -i HEAD~3
# 將要修改的 commit 前面的 pick 改為 reword（或 r），存檔後修改訊息
```

### 練習建議

從現在開始，每次下達 `git commit` 時，都依照這份規範撰寫訊息。你會發現歷史紀錄變得乾淨又有條理。
