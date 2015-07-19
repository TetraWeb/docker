FROM php:5.4

MAINTAINER Dmitry Lukashin <dlukashin@tetraweb.ru>

ENV XDEBUG_VERSION 2.3.3

# Install php extensions
RUN buildDeps=" \
        libmcrypt-dev \
        libssl-dev \
        zlib1g-dev \
    " \
    && echo "deb http://httpredir.debian.org/debian jessie contrib non-free" > /etc/apt/sources.list.d/additional.list \
    && apt-get update && apt-get install -y libmcrypt4 --no-install-recommends \
    && apt-get install -y $buildDeps --no-install-recommends \
    && printf "\n" | pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && docker-php-ext-install gettext mbstring mcrypt pcntl pdo_mysql zip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
    && mkdir /tmp/xdebug && cd /tmp/xdebug \
    && curl -L http://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz | tar -zxf - \
    && cd xdebug-$XDEBUG_VERSION \
    && phpize && ./configure && make && make install \
    && cd / && rm -rf /tmp/xdebug \
    && EXT_DIR=`php -r 'echo ini_get("extension_dir");'` \
    && echo "zend_extension=$EXT_DIR/xdebug.so\n\
xdebug.default_enable=1\n\
xdebug.cli_color=1\n\
xdebug.coverage_enable=1" > /usr/local/etc/php/conf.d/xdebug.ini.disabled

# Install git
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

COPY ../entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]