# Troubleshooting Notes

## 常見問題

### SSH 連線失敗

| 現象 | 可能原因 | 解法 |
|------|----------|------|
| `Connection refused` | SSH 服務未啟動 | `sudo systemctl start ssh` |
| `Permission denied` | 密碼錯誤或 key 錯誤 | 檢查 `~/.ssh/authorized_keys` |
| `Host key verification failed` | 主機公鑰變更 | `ssh-keygen -R hostname` |

### systemd 服務無法啟動

```
journalctl -u 服務名稱 -xe
```

### 網路不通

```
ip a          # 確認 IP
ip route      # 確認路由
ping 8.8.8.8  # 測試對外連線
```

## 本次 Lab 遇到的錯誤

### piix4_smbus 錯誤

- 錯誤訊息：`piix4_smbus 0000:00:07.3: SMBus Host Controller not enabled`
- 原因：VMware 虛擬機的已知問題
- 影響：無，可以忽略 
