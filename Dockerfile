# --- Giai đoạn 1: Build Ứng dụng React/Vite ---
# Đặt tên stage là 'builder' để tránh xung đột với tên image bên ngoài
FROM node:20-alpine AS builder 

WORKDIR /app

# Sao chép và cài đặt dependencies
COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .
RUN npm run build

# 🚨 LỆNH KIỂM TRA TẠM THỜI 🚨
RUN cat dist/index.html 
RUN ls -l dist/assets

FROM nginx:alpine AS production-stage

RUN rm -rf /etc/nginx/conf.d

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]