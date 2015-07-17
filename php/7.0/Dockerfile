FROM php:7.0

RUN echo "deb http://httpredir.debian.org/debian jessie contrib non-free" > /etc/apt/sources.list.d/additional.list

RUN apt-get update && apt-get install -y libmcrypt-dev --no-install-recommends

# Additional php extensions
RUN docker-php-ext-install gettext mbstring mcrypt pdo_mysql

# Install git
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put in into $PATH
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/ && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer