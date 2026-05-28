
# 公司 Git 協作流程補充說明（Fork / PR / Review / Merge）

本文件說明在團隊開發中（例如公司專案），如何使用 Git 與 GitHub / GitLab 進行協作。  
**Stage 03 主流程只練習基本指令，不強制使用這些流程，但建議了解。**

---

## 零、如何 Fork 公司倉庫（GitHub 網頁操作）

Fork 是將公司的原始倉庫複製一份到你個人 GitHub 帳號下的動作。  
**你只需要做一次 Fork**，之後所有修改都透過自己的 Fork 進行。

### Step 1：進入公司倉庫頁面

- 登入你的個人 GitHub 帳號。
- 在瀏覽器網址列輸入公司倉庫的網址，或透過公司組織頁面點擊倉庫名稱進入。

### Step 2：找到 Fork 按鈕

在倉庫頁面的右上角，你會看到三個按鈕：**Watch**、**Fork**、**Star**。  
如果頁面下方直接顯示 **「+ Create a new fork」** 連結，也可點擊。

```
Fork 按鈕位置示意圖：

[Watch] [Fork] [Star]
         ↑
       點這裡
```

### Step 3：設定 Fork 參數

點擊後會進入 `Create a new fork` 頁面：

- **Owner**：選擇你的個人帳號（而非公司組織）
- **Repository name**：通常保持與原倉庫相同名稱
- **Description**：自動帶入，不需修改
- **Copy the master branch only**：建議勾選（只複製主分支，節省時間）

### Step 4：建立 Fork

點擊綠色的 **Create fork** 按鈕。  
等待幾秒後，GitHub 會自動跳轉到你個人帳號下的新倉庫頁面，網址變成：  
`https://github.com/你的帳號/倉庫名稱`

頁面頂端會顯示：**forked from 公司組織/原始倉庫**

### Step 5：將 Fork 複製到本機（後續操作）

```bash
git clone https://github.com/你的帳號/倉庫名稱.git
cd 倉庫名稱
git remote add upstream https://github.com/公司組織/原始倉庫.git
git remote -v   # 確認 origin 和 upstream 都存在
```

完成以上步驟後，你就可以在自己的 Fork 上自由修改，並透過 PR 將變更提交回公司倉庫。

---

## 一、核心名詞解釋

| 名詞 | 說明 |
|------|------|
| **Upstream** | 公司組織的「原始儲存庫」（你通常沒有直接寫入權限） |
| **Origin** | 你從公司儲存庫 **Fork** 到自己帳號下的「個人副本」（有完整權限） |
| **Fork** | 在 GitHub 網頁上將公司的儲存庫複製一份到你自己的帳號下 |
| **Pull Request (PR)** | 請求將你個人副本中的修改，合併回公司的原始儲存庫 |
| **Review** | 其他團隊成員檢查你的 PR，給予評論、要求修改或批准 |
| **Merge** | 有權限的人（或自動化規則）將 PR 的程式碼真正合併進主分支（如 `main`） |

## 二、完整協作流程圖

```mermaid
flowchart LR
    subgraph 上游
        A[公司原始倉庫<br>(upstream)]
    end
    
    subgraph 你個人
        B[你 Fork 後的倉庫<br>(origin)]
        C[你的本機開發環境]
    end
    
    subgraph 協作
        D[開 Pull Request]
        E[同儕 Review]
        F[合併 upstream]
    end
    
    A -->|Fork| B
    B -->|clone| C
    C -->|push| B
    B -->|gh pr create| D
    D --> E -->|Approve| F
    F --> A
```

## 三、基礎操作（終端機版，使用 GitHub CLI `gh`）

### 3.1 第一次設定（只需做一次）

```bash
# 安裝 gh (GitHub CLI)
sudo apt install gh

# 登入你的 GitHub 帳號
gh auth login

# 將公司原始倉庫設定為 upstream
git remote add upstream https://github.com/公司組織/專案.git
```

### 3.2 日常開發流程

```bash
# 1. 同步 upstream 最新狀態
git checkout main
git pull upstream main
git push origin main

# 2. 建立功能分支
git checkout -b feature/你的功能

# 3. 修改、提交、推送
git add .
git commit -m "feat: 說明修改"
git push origin feature/你的功能

# 4. 開 PR (終端機)
gh pr create --base main --head 你的帳號:feature/你的功能 \
  --title "PR 標題" \
  --body "PR 說明"
```

### 3.3 審查他人的 PR

```bash
# 查看待審的 PR
gh pr list --review-requested @me

# 取得 PR 編號後，審查
gh pr review 123 --approve               # 批准
gh pr review 123 --comment -b "建議修改..."   # 評論
gh pr review 123 --request-changes -b "需要調整"  # 要求修改
```

### 3.4 合併 PR（需要合併權限）

```bash
gh pr merge 123 --merge   # 或 --squash
```

## 四、常見問答

### Q1：我 approve 了，但是程式碼沒有被合併？

**A**：`Approve` 只是表示你同意這個 PR，真正要合併需要「有合併權限的人」點擊 Merge。這是一種責任分離的機制。

### Q2：什麼時候會發生衝突？如何解決？

當你的 PR 與 upstream 最新進度有相同檔案的不同修改時。

**解法**：

```bash
git checkout feature/你的功能
git fetch upstream
git merge upstream/main
# 手動編輯衝突檔案
git add .
git commit -m "fix: resolve conflict"
git push origin feature/你的功能
```

### Q3：為什麼不能用 `git push origin main` 直接推送？

因為你對公司 upstream 的 `main` 分支通常沒有寫入權限。即使有權限，也建議透過 PR 讓同事審查，避免直接修改主分支。

### Q4：PR 和一般的 merge 有什麼不同？

PR 是 GitHub 的功能，不是 Git 的原生命令。一般的 merge 是直接把變結合併進去；PR 則是需要經過討論、審核、CI 檢查通過後，才會真正被合併。

### Q5：一個 PR 可以包含多個 commit 嗎？

可以。通常一個 PR 可以包含多個 commit，代表一個完整的修改任務。建議不要在同一個 PR 裡做太多不相關的事情。

## 五、總結

| 你的角色 | 主要動作 |
|----------|----------|
| **貢獻者** | Fork → clone → 開功能分支 → push → 開 PR → 根據 review 修改 → 等待合併 |
| **審閱者** | 查看 PR → 評論 / 批准 / 要求修改 |
| **維護者** | 審閱 + 合併 PR |

這些流程在公司環境中非常常見，但 **Stage 03 主練習只要求你學會基礎 Git 指令**，本文件作為補充參考。
