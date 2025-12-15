# --- GIAI ĐOẠN 1: BUILD REACT ---
# Sử dụng Image Node.js để chạy lệnh npm install và npm run build
FROM node:20-alpine AS build

# Đặt thư mục làm việc (Giả sử source React nằm trong thư mục 'web/')
WORKDIR /app/web

# 1. COPY file cấu hình để cài đặt dependencies
# COPY web/package*.json ./ <-- Cần chỉ rõ COPY từ context build (thư mục gốc)
COPY web/package*.json ./

# 2. Cài đặt các dependencies
# Bước này tận dụng Docker cache nếu package*.json không thay đổi
RUN npm install

# 3. COPY toàn bộ mã nguồn Frontend còn lại
# Đặt sau npm install để đảm bảo mọi thay đổi code đều kích hoạt build lại
COPY web/. .

# 4. Chạy lệnh build (tạo ra các file tĩnh trong thư mục 'dist' mặc định)
RUN npm run build

# --- GIAI ĐOẠN 2: PHỤC VỤ BẰNG NGINX ---
# Sử dụng Image Nginx nhẹ để phục vụ các file tĩnh
FROM nginx:alpine

# Xóa cấu hình mặc định của Nginx
RUN rm -rf /etc/nginx/conf.d

# Copy các file tĩnh đã build từ giai đoạn 'build' vào thư mục phục vụ của Nginx
COPY --from=build /app/web/dist /usr/share/nginx/html

# Mở cổng 80 (cổng HTTP mặc định của Nginx)
EXPOSE 80

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]