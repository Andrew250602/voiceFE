# ... (Giai đoạn 1 giữ nguyên)

# --- Giai đoạn 2: Phục vụ Tệp tĩnh bằng Nginx ---
FROM nginx:alpine AS production-stage

# Xóa cấu hình Nginx mặc định
RUN rm -rf /etc/nginx/conf.d

# THÊM CẤU HÌNH NGINX TÙY CHỈNH (Bước Sửa chữa quan trọng!)
# Sao chép file nginx.conf vừa tạo vào thư mục cấu hình mặc định
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sao chép các tệp tĩnh đã build (thư mục 'dist')
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Mở cổng 80 (cổng HTTP mặc định của Nginx)
EXPOSE 80

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]