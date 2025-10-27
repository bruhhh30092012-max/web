# Dùng image PHP có sẵn Apache
FROM php:8.2-apache

# Copy toàn bộ file vào thư mục web
COPY . /var/www/html/

# Cho phép PHP ghi file (qkll.txt)
RUN chown -R www-data:www-data /var/www/html

# Mở cổng 80 (Render dùng)
EXPOSE 80
