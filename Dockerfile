FROM php:8.4-fpm
WORKDIR /var/www


RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        opcache \
    && rm -rf /var/lib/apt/lists/*


    COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

    COPY . /var/www

    RUN chown -R www-data:www-data /var/www \
        && chmod -R 755 /var/www/storage \
        && chmod -R 755 /var/www/bootstrap/cache
