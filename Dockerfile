# PHP 8.4 FPM base image
FROM php:8.4-fpm

# Install basic dependencies और PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    && docker-php-ext-install \
        zip \
        intl \
        pdo_mysql \
        gd \
        xml

# Work directory
WORKDIR /var/www/html

# Container start message (optional)
CMD ["php-fpm"]
