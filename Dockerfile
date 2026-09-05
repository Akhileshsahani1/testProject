FROM php:8.4-fpm
WORKDIR /var/www


RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    opcache

RUN rm -rf /var/lib/apt/lists/*


    COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

    COPY . /var/www

    RUN chown -R www-data:www-data /var/www \
        && chmod -R 755 /var/www/storage \
        && chmod -R 755 /var/www/bootstrap/cache
