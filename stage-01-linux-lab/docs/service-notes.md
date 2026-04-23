# Service Notes (systemd)

## 常用指令

| 指令 | 說明 |
|------|------|
| `systemctl status ssh` | 查看服務狀態 |
| `sudo systemctl start ssh` | 啟動服務 |
| `sudo systemctl stop ssh` | 停止服務 |
| `sudo systemctl restart ssh` | 重啟服務 |
| `sudo systemctl reload ssh` | 重新載入設定 |
| `sudo systemctl enable ssh` | 開機自動啟動 |
| `sudo systemctl disable ssh` | 取消開機自動啟動 |
| `systemctl is-active ssh` | 檢查是否運行中 |
| `systemctl is-enabled ssh` | 檢查是否開機啟動 |

## 自建服務

- 服務名稱：`lab-heartbeat.service`
- 功能：每 60 秒輸出一次心跳訊息
- 路徑：`/etc/systemd/system/lab-heartbeat.service`
