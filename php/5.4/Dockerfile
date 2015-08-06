FROM php:5.4

MAINTAINER Dmitry Lukashin <dlukashin@tetraweb.ru>

COPY docker-php-ext-* /usr/local/bin/

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
    && docker-php-ext-install gettext mbstring mcrypt pcntl pdo_mysql zip \
    && printf "\n" | pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && EXT_DIR=`php -r 'echo ini_get("extension_dir");'` \
    && pecl install ZendOpcache \
    && echo "zend_extension=$EXT_DIR/opcache.so" > /usr/local/etc/php/conf.d/opcache.ini.disabled \
    && mkdir /tmp/xdebug && cd /tmp/xdebug \
    && curl -L http://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz | tar -zxf - \
    && cd xdebug-$XDEBUG_VERSION \
    && phpize && ./configure && make && make install \
    && cd / && rm -rf /tmp/xdebug \
    && EXT_DIR=`php -r 'echo ini_get("extension_dir");'` \
    && echo "zend_extension=$EXT_DIR/xdebug.so\n\
xdebug.default_enable=1\n\
xdebug.cli_color=1\n\
xdebug.coverage_enable=1" > /usr/local/etc/php/conf.d/xdebug.ini.disabled \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps

# Install git
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install phpunit and put binary into $PATH
RUN curl -sSo phpunit.phar https://phar.phpunit.de/phpunit.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit

# Install PHP Code sniffer
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod 755 phpcs.phar \
    && mv phpcs.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
    && curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
    && chmod 755 phpcbf.phar \
    && mv phpcbf.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php", "-a"]