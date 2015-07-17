FROM php:5.6

MAINTAINER Dmitry Lukashin <dlukashin@tetraweb.ru>

# Install php extensions
RUN echo "deb http://httpredir.debian.org/debian jessie contrib non-free" > /etc/apt/sources.list.d/additional.list  && \
    apt-get update && apt-get install -y libmcrypt-dev libssl-dev --no-install-recommends && \
    printf "\n" | pecl install mongo && \
    echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini && \
    pecl install redis && \
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    docker-php-ext-install gettext mbstring mcrypt pcntl pdo_mysql

# Install git
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/ && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer