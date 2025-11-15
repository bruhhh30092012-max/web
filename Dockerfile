# 1. Chọn base image: Dùng phiên bản PHP 8.2 (hoặc mới hơn) với Alpine (nhỏ gọn) và FPM
FROM php:8.2-fpm-alpine

# 2. Cài đặt Web Server Nginx (sẽ dùng để phục vụ code PHP)
RUN apk update && \
    apk add --no-cache nginx

# 3. Cấu hình Nginx
# Xóa cấu hình mặc định của Nginx và thêm cấu hình mới
RUN rm /etc/nginx/conf.d/default.conf

# Sao chép file cấu hình Nginx tùy chỉnh của bạn
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 4. Sao chép code của bạn vào thư mục phục vụ web (document root)
# Dấu chấm (.) đại diện cho tất cả các file trong thư mục hiện tại (ngang hàng)
COPY . /var/www/html

# 5. Thiết lập quyền sở hữu cho Nginx và PHP-FPM
# Rất quan trọng để PHP có quyền GHI dữ liệu vào data.txt
RUN chown -R www-data:www-data /var/www/html

# 6. Mở cổng 8080 (cổng tiêu chuẩn cho các Web Service)
EXPOSE 8080

# 7. Khởi chạy PHP-FPM và Nginx khi container bắt đầu
# Chạy đồng thời PHP-FPM (xử lý PHP) và Nginx (xử lý kết nối)
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]