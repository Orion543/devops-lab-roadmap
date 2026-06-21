# 使用特定版本 + alpine（較小）
FROM nginx:1.25-alpine

# 維護者資訊
LABEL maintainer="orion@lab.com"
LABEL version="1.0.0"
LABEL description="Custom nginx image for stage 04"

# 設定工作目錄
WORKDIR /usr/share/nginx/html

# 複製靜態檔案
COPY html/ .

# 暴露 port（僅供文件說明）
EXPOSE 80

# 健康檢查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# 啟動指令（繼承自 base image，可省略）
CMD ["nginx", "-g", "daemon off;"]
