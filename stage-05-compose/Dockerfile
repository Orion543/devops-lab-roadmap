FROM nginx:alpine

# 複製自訂網頁
COPY app /usr/share/nginx/html

# 複製 nginx 設定（如果需要的話）
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# 健康檢查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
