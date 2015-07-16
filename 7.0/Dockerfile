FROM php:7.0

# Install git
RUN apt-get update && apt-get install -y git --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install composer and put in into $PATH
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/ && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer