# Merge Conflict Resolution - 衝突解決實戰

## 什麼是衝突？

當兩個分支修改了同一個檔案的同一行，Git 無法自動決定要保留哪一個版本時，就會產生衝突。

## 衝突標記說明

```
<<<<<<< HEAD
目前分支（main）的內容
=======
要合併進來的分支內容
>>>>>>> feature/分支名稱
```

| 標記 | 說明 |
|------|------|
| `<<<<<<< HEAD` | 目前分支的內容開始 |
| `=======` | 兩個版本的分隔線 |
| `>>>>>>> 分支名` | 要合併進來的分支內容結束 |

## 解決衝突的步驟

### Step 1：查看衝突檔案

```
git status
# 會顯示 both modified 的檔案
```

### Step 2：手動編輯衝突檔案

打開衝突檔案，刪除衝突標記（`<<<<<<<`、`=======`、`>>>>>>>`），保留你想要的最終內容。

### Step 3：標記為已解決

```
git add <衝突檔案>
```

### Step 4：完成合併

```
git commit -m "fix: resolve merge conflict"
```

## 實戰演練

### 建立衝突場景

```
# 從 main 建立功能分支
git checkout -b feature/conflict-test

# 在功能分支寫入內容
echo "Line from feature" > conflict.txt
git add conflict.txt
git commit -m "feat: add conflict.txt from feature"

# 切回 main
git checkout main

# 在 main 寫入不同內容
echo "Line from main" > conflict.txt
git add conflict.txt
git commit -m "docs: add conflict.txt from main"

# 觸發衝突
git merge feature/conflict-test
```

### 解決衝突

```
# 查看衝突內容
cat conflict.txt

# 手動編輯，刪除衝突標記
vim conflict.txt

# 標記為已解決
git add conflict.txt

# 完成合併
git commit -m "fix: resolve merge conflict in conflict.txt"

# 清理
git branch -d feature/conflict-test
rm conflict.txt
```

## 避免衝突的最佳實踐

| 做法 | 說明 |
|------|------|
| 經常 pull | 保持分支與 main 同步 |
| 小批量 commit | 減少衝突範圍 |
| 溝通協調 | 避免多人同時改同一檔案 |
| 使用 feature branch | 完成後再 merge 回 main |

## 衝突解決工具

```
# 使用 vimdiff 解決衝突
git mergetool

# 使用 VS Code 解決衝突（需要安裝）
code --wait conflict.txt
```
