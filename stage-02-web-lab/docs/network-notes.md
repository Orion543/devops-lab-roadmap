# Network Notes - HTTP / Port / Firewall (iptables)

## 核心觀念

### 從 Client 到 Web Server 的請求路徑

Client → 主機 IP → iptables INPUT 規則 → Port 80 → Nginx

- **Nginx listen 80**：服務準備好了，正在監聽
- **iptables 放行 80**：封包進得來
- **兩者都要對**，外部才打得到

## 檢查指令

### 檢查 Nginx 是否在監聽 80

```
ss -tulpen | grep :80
```

預期輸出：`LISTEN`、`*:80` 或 `0.0.0.0:80`、進程名為 `nginx`

### 檢查 iptables 規則

```
sudo iptables -L -n -v
sudo iptables -L INPUT -n -v --line-numbers
sudo iptables -S
```

## iptables 實戰操作

### 允許必要服務

```
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT   # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT   # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # HTTPS
```

### 允許本機和已建立連線

```
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### 設定預設 DROP（小心！會斷線）

```
sudo iptables -P INPUT DROP
```

### 儲存規則（Ubuntu）

```
sudo apt install -y iptables-persistent
sudo netfilter-persistent save
```

## 外部打不到的排查順序

1. 服務是否啟動？ `systemctl status nginx`
2. Port 80 是否在 listen？ `ss -tulpen | grep :80`
3. iptables 有沒有阻擋 80？ `sudo iptables -L INPUT -n -v`
4. IP 是否正確？ `ip a`

## 關鍵名詞

| 名詞 | 說明 |
|------|------|
| LISTEN | 服務正在監聽指定 Port |
| iptables | Linux 核心防火牆，控制封包進出 |
| INPUT chain | 進入本機的封包規則 |
| default policy | 預設行為（ACCEPT / DROP） |
