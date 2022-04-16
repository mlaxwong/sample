FROM php:8.1.3-apache

# ENV
ENV APACHE_DOCUMENT_ROOT=/app/public

# App
WORKDIR /
COPY . .

# Change Apache Document Root
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Permission
RUN chmod -R 755 ${APACHE_DOCUMENT_ROOT}
RUN chown -R www-data:www-data ${APACHE_DOCUMENT_ROOT} \
    && a2enmod rewrite

EXPOSE 80

HEALTHCHECK --interval=5s --timeout=3s --retries=2\
    CMD curl --fail http://localhost:80 || exit 1