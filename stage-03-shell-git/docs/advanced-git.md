# Advanced Git - 進階操作

## Git Stash（暫存工作目錄）

暫時放下目前的工作，去處理其他任務。

```
# 暫存目前進度
git stash save "WIP: 說明文字"

# 查看 stash 清單
git stash list

# 恢復最新的 stash（同時刪除）
git stash pop

# 恢復最新的 stash（保留）
git stash apply

# 查看特定 stash 內容
git stash show stash@{0}

# 丟掉最新的 stash
git stash drop

# 清空所有 stash
git stash clear
```

## Git Rebase（整理 commit 歷史）

讓 commit 歷史更乾淨，沒有額外的 merge commit。

```
# 修改最近一次 commit 訊息
git commit --amend -m "新的訊息"

# 互動式 rebase（修改最近 3 個 commit）
git rebase -i HEAD~3
```

### rebase 常用指令（互動模式）

| 指令 | 說明 |
|------|------|
| `pick` | 保留這個 commit |
| `squash` | 合併到前一個 commit |
| `drop` | 刪除這個 commit |
| `reword` | 修改 commit 訊息 |
| `edit` | 修改 commit 內容 |

### rebase vs merge

| 方式 | 效果 | 使用時機 |
|------|------|----------|
| `merge` | 保留完整歷史，多一個 merge commit | 多人協作、正式環境 |
| `rebase` | 歷史變乾淨，沒有額外 merge commit | 個人整理、feature 分支 |

## Git Reflog（救回遺失的 commit）

Git 的「時光機」，所有 HEAD 變動都會被記錄。

```
# 查看所有 HEAD 變動
git reflog

# 救回誤刪的 commit
git reset --hard <commit-hash>

# 救回誤刪的分支
git checkout -b <分支名> <commit-hash>
```

### 常見救回情境

| 情境 | 解法 |
|------|------|
| 誤刪 commit | `git reflog` → `git reset --hard hash` |
| 誤刪分支 | `git reflog` → `git checkout -b 分支名 hash` |
| 誤 merge | `git reflog` → `git reset --hard 合併前的 hash` |

## Git Reset vs Revert（復原變更）

| 指令 | 效果 | 影響歷史 | 使用時機 |
|------|------|----------|----------|
| `git reset --soft HEAD~1` | 保留變更，取消 commit | ✅ 改寫歷史 | 個人分支、未 push |
| `git reset --mixed HEAD~1` | 取消 commit 和暫存 | ✅ 改寫歷史 | 個人分支、未 push |
| `git reset --hard HEAD~1` | 完全刪除 commit 和變更 | ✅ 改寫歷史 | 個人分支、確定不要了 |
| `git revert HEAD` | 新增 commit 來取消變更 | ❌ 不影響歷史 | 已 push、多人協作 |

### 實例

```
# 錯誤 commit（尚未 push）
git reset --soft HEAD~1
# 變更回到暫存區，重新 commit

# 錯誤 commit（已經 push）
git revert HEAD
# 新增一個 commit 來取消
```

## Git Remote 管理

```
# 查看遠端
git remote -v

# 新增遠端
git remote add backup https://github.com/帳號/repo-backup.git

# 推送到不同遠端
git push backup main

# 修改遠端 URL
git remote set-url origin https://github.com/新帳號/repo.git

# 移除遠端
git remote remove backup
```

## Git Fetch（不自動合併的遠端更新）

`git fetch` 與 `git pull` 功能相似，都是將遠端倉庫的更新拉取到本地，但有一個關鍵差異：

| 指令 | 行為 | 何時使用 |
|------|------|----------|
| `git fetch` | 只下載更新，**不自動合併** | 想先查看遠端變更，確認後再手動合併 |
| `git pull` | 下載更新並**自動合併**到當前分支 | 日常工作，信任遠端更新 |

### 使用情境

假設你與同事協作，他在 `main` 分支上推送了新的 commit。  
你想先在本地查看這些變更的內容，而不立即改變你目前的工作目錄。

```
# 1. 下載遠端 main 分支的更新，但不合併
git fetch upstream main

# 2. 查看遠端 main 與當前本地的差異
git diff main upstream/main

# 3. 確認沒問題後，再手動合併
git checkout main
git merge upstream/main
```

### 為什麼需要 fetch？

- **安全**：避免自動合併造成衝突，尤其是你不確定遠端變更是否與你的工作相容時。
- **檢查**：可以先 `diff`，確認修改內容後再決定是否合併。
- **乾淨**：不會影響你當前的工作區，`pull` 則會直接修改你的檔案。

### 實戰建議

- **平時多用 `git pull`**（因為快速方便）。
- **想謹慎檢查時，先用 `git fetch` + `git diff`，再決定是否 `git merge`**。

### 與 `git pull` 的關係

```
git pull = git fetch + git merge
```

所以 `git pull` 是 `fetch` 加上 `merge` 的簡化寫法。
