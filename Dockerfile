# PHP 8.4 FPM base image
FROM php:8.4-fpm

# Install OS dependencies required for all PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libicu-dev \
    libxml2-dev \
    libonig-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure GD with JPEG & Freetype support
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-freetype

# Install PHP extensions
RUN docker-php-ext-install \
    zip \
    intl \
    pdo_mysql \
    gd \
    xml \
    bcmath \
    soap \
    ftp \
    sockets \
    xsl \
    mbstring \
    ctype \
    simplexml \
    iconv

    # Increase memory limit
RUN echo "memory_limit=5G" > /usr/local/etc/php/conf.d/memory-limit.ini

# Install Composer 2.8 (official method)
COPY --from=composer/composer:2.8-bin /composer /usr/bin/composer

WORKDIR /var/www/html

CMD ["php-fpm"]
