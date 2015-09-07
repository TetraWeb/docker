FROM tetraweb/php:5.2-vanilla

MAINTAINER Dmitry Lukashin <dlukashin@tetraweb.ru>

ENV XDEBUG_VERSION 2.2.7

# Install php extensions
RUN buildDeps=" \
        freetds-dev \
        libbz2-dev \
        libc-client-dev \
        libenchant-dev \
        libfreetype6-dev \
        libgmp3-dev \
        libicu-dev \
        libjpeg62-dev \
        libkrb5-dev \
        libldap2-dev \
        libmcrypt-dev \
        libpng12-dev \
        libpq-dev \
        libpspell-dev \
        libsasl2-dev \
        libsnmp-dev \
        libssl-dev \
        libtidy-dev \
        libxml2-dev \
        libxpm-dev \
        libxslt1-dev \
        zlib1g-dev \
    " \
    && phpModules=" \
        bcmath bz2 calendar dba exif ftp gd gettext imap ldap mbstring mysql mysqli pdo_dblib pdo_pgsql pgsql pspell shmop snmp soap sockets sysvmsg sysvsem sysvshm tidy wddx xmlrpc xsl \
    " \
    && echo "deb http://httpredir.debian.org/debian wheezy contrib non-free" > /etc/apt/sources.list.d/additional.list \
    && apt-get update && apt-get install -y libmcrypt4 --no-install-recommends \
    && apt-get install -y $buildDeps --no-install-recommends \
    && cd /usr/src/php/ext/ \
    && curl -L http://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz | tar -zxf - \
    && mv xdebug-$XDEBUG_VERSION xdebug \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-xpm-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure ldap --with-ldap-sasl \
    && docker-php-ext-install $phpModules \
    && echo "xdebug.default_enable=1\n\
xdebug.cli_color=1\n\
xdebug.coverage_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && printf "\n" | pecl install mongo && docker-php-ext-enable mongo \
    && pecl install ZendOpcache && docker-php-ext-enable opcache \
    && pecl install phar && docker-php-ext-enable phar \
    && pecl install redis && docker-php-ext-enable redis \
    && for ext in $phpModules; do \
           rm -f /usr/local/etc/php/conf.d/docker-php-ext-$ext.ini; \
       done

# Install git & msmtp
RUN apt-get update && apt-get install -y git msmtp-mta --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put binary into $PATH
#RUN curl -sS https://getcomposer.org/installer | php \
#    && mv composer.phar /usr/local/bin/ \
#    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install phpunit and put binary into $PATH
#RUN curl -sSo phpunit.phar https://phar.phpunit.de/phpunit.phar \
#    && chmod 755 phpunit.phar \
#    && mv phpunit.phar /usr/local/bin/ \
#    && ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit

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