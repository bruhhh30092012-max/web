FROM php:8.2-fpm-alpine
RUN apk update && \
    apk add --no-cache nginx gettext
RUN rm -f /etc/nginx/conf.d/default.conf
COPY . /var/www/html
COPY nginx.conf.template /etc/nginx/conf.d/nginx.conf
RUN chown -R www-data:www-data /var/www/html
CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/default.conf && php-fpm -D && nginx -g 'daemon off;'"

