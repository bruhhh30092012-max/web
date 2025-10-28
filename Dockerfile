# --------------------------------------------
# 🐘 Base image: PHP 8.2 + Apache
# --------------------------------------------
FROM php:8.2-apache

# --------------------------------------------
# 🔧 Cài các extension PHP thường dùng (tuỳ app bạn)
# Nếu bạn không cần, có thể bỏ dòng này
# --------------------------------------------
RUN docker-php-ext-install mysqli pdo pdo_mysql

# --------------------------------------------
# 📂 Copy toàn bộ source vào thư mục web mặc định
# --------------------------------------------
COPY . /var/www/html/

# --------------------------------------------
# ⚙️ Phân quyền để PHP/Apache có thể ghi file (upload, cache, logs…)
# --------------------------------------------
RUN chown -R www-data:www-data /var/www/html

# --------------------------------------------
# 🛠 Cấu hình Apache để lắng nghe cổng Render cung cấp ($PORT)
# Render sẽ truyền biến môi trường PORT (vd: 10000)
# --------------------------------------------
RUN echo "Listen ${PORT:-80}" > /etc/apache2/ports.conf \
 && sed -i 's/:80/:${PORT:-80}/g' /etc/apache2/sites-available/000-default.conf

# --------------------------------------------
# 🌐 Kích hoạt mod_rewrite (nếu bạn dùng Laravel, WordPress, v.v.)
# --------------------------------------------
RUN a2enmod rewrite

# --------------------------------------------
# 🚪 Thông báo cổng container sẽ dùng (Render tự map)
# --------------------------------------------
EXPOSE 80

# --------------------------------------------
# 🚀 Khởi động Apache ở foreground (Render yêu cầu tiến trình chính)
# --------------------------------------------
CMD ["apache2-foreground"]
