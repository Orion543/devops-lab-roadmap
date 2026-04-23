# Stage 01 Command Cheatsheet


## 系統資訊

```
hostnamectl          # 查看主機名稱
ip a                 # 查看 IP
df -h                # 查看磁碟
free -h              # 查看記憶體
```

## systemd 服務管理

```
systemctl status ssh
sudo systemctl start ssh
sudo systemctl stop ssh
sudo systemctl restart ssh
sudo systemctl enable ssh
sudo systemctl disable ssh
systemctl is-active ssh
systemctl is-enabled ssh
```

## journalctl 日誌查詢

```
journalctl -u ssh -n 50 --no-pager
journalctl -u ssh -f
journalctl -p err -b
```

## 檔案傳輸

```
scp local.txt orion@web-01:/tmp/
rsync -av local/ orion@web-01:/tmp/
```
