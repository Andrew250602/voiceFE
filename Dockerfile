# --- Giai đoạn 1: Build Ứng dụng React/Vite ---
# Đặt tên stage là 'builder' để tránh xung đột với tên image bên ngoài
FROM node:20-alpine AS builder 

WORKDIR /app

# Sao chép và cài đặt dependencies
COPY package.json .
COPY package-lock.json .
RUN npm install

# Sao chép code và build
COPY . .
RUN npm run build

# --- Giai đoạn 2: Phục vụ Tệp tĩnh bằng Nginx ---
FROM nginx:alpine AS production-stage

# Xóa cấu hình Nginx mặc định
RUN rm -rf /etc/nginx/conf.d

# THÊM CẤU HÌNH TÙY CHỈNH CHO SPA (Bước khắc phục Connection Reset)
# File nginx.conf phải được tạo ra (xem mục 2)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sao chép các tệp tĩnh đã build (thư mục 'dist')
# Quan trọng: Đã sửa tên stage thành 'builder'
COPY --from=builder /app/dist /usr/share/nginx/html

# Mở cổng 80 (cổng HTTP mặc định của Nginx)
EXPOSE 80

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]