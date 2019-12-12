FROM php:7.4.0

RUN apt-get update

# development packages
RUN apt-get update && apt-get install -y \
    && apt-get install -y libfreetype6-dev \
    && apt-get install -y libjpeg62-turbo-dev \
    && apt-get install -y libmcrypt-dev \
    && apt-get install -y libpng-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libxml2-dev \
    && apt-get install -y libzip-dev \
    && apt-get install -y libonig-dev \
    && apt-get install -y libcurl3-dev \
    && apt-get install -y libpq-dev \
    && apt-get install -y graphviz

# start with base php config, then add extensions
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install ctype \
    && docker-php-ext-install zip \
    && docker-php-ext-install opcache \
    && docker-php-ext-install curl \
    && docker-php-source delete

ENV COMPOSER_HOME=/composer
ENV PATH=./vendor/bin:/composer/vendor/bin:/root/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

