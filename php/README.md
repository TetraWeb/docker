# PHP for CI

PHP Docker images for continuous integration and running tests. These images were created for using with Gitlab CI.
Although they can be used with any automated testing system or as standalone services.

Images do not have `VOLUME` directories since fresh version of sources is supposed to be downloaded into image each time before running tests

These images are built from [Docker official php images](https://registry.hub.docker.com/_/php/), but additionally include:

 - All extensions are compiled and ready for loading with `docker-php-ext-enable`
 - External extensions: redis, mongo
 - sendmail command via msmtp, configured as relay to localhost. Check `/etc/msmtprc` to setup relay server
 - Git client from official debian repo
 - Composer
 - PHPUnit - latest stable version for php >= 5.6 and PHPUnit 4.8 for php < 5.6
 - PHP Code Sniffer - latest stable version of `phpcs` and `phpcbf` commands

See below for details

## Advantages of these images

 - Builds are based on the official Docker php images
 - Automatically rebuilt when official images are updated, so this repository always contains the latest versions
 - PHP 5.3 image is based on Docker Debian Wheezy images. No surprises here since support of PHP 5.3 is discontinued by PHP
 - PHP 5.2 image is based on Docker Debian Squeeze images. Without support of `mongo` extension, `composer` and `phpunit`. This image is intended for the support of really old projects.

# Quick start guide

Check the [Quick start guide](https://github.com/TetraWeb/docker/blob/master/README.md#quick-start)

## PHP modules
Some modules are enabled by default (compiled-in) and some you have to enable in your .gitlab-ci.yml `before-script` section with `docker-php-ext-enable module1 module2`

### Compiled-in modules
```
ctype curl date dom ereg fileinfo filter hash iconv json libxml mysqlnd openssl pcre pdo pdo_sqlite phar posix readline recode reflection session simplexml spl sqlite3 standard tokenizer xml xmlreader xmlwriter zlib
```

### Available core modules
```
bcmath bz2 calendar dba enchant exif ftp gd gettext gmp imap intl ldap mbstring mcrypt mssql mysql mysqli opcache pcntl pdo pdo_dblib pdo_mysql pdo_pgsql pgsql pspell shmop snmp soap sockets sysvmsg sysvsem sysvshm tidy wddx xmlrpc xsl zip
```

### Available PECL modules
```
memcache memcached mongo redis xdebug
```

# Supported tags and respective `Dockerfile` links

-	[`5.2-cli`, `5.2` (*5.2/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.2/Dockerfile)
-	[`5.3-cli`, `5.3` (*5.3/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.3/Dockerfile)
-	[`5.4-cli`, `5.4` (*5.4/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.4/Dockerfile)
-	[`5.5-cli`, `5.5` (*5.5/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.5/Dockerfile)
-	[`5.6-cli`, `5.6`, `latest` (*5.6/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.6/Dockerfile)
-	[`7.0-cli`, `7.0`, (*7.0/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/7.0/Dockerfile)


For more information check the [Github repository](https://github.com/TetraWeb/docker/)

## Environment variables

There are environment variables which can be passed to images on docker run

 - `WITH_XDEBUG=1` - enables xdebug extension
 - `TIMEZONE=America/New_York` - set system and `php.ini` timezone. You can also set timezone in .gitlab-ci.yml - check [Example](https://github.com/TetraWeb/docker/blob/master/examples/purephp/.gitlab-ci.yml)
 - `COMPOSER_GITHUB=<YOUR_GITHUB_TOKEN>` - Adds Github oauth token for composer which allows composer to get unlimited repositories from Github without blocking non-interactive mode with request for authorization. You can obtain your token at [https://github.com/settings/tokens](https://github.com/settings/tokens)

    [Composer documentation about Github API rate limit](https://getcomposer.org/doc/articles/troubleshooting.md#api-rate-limit-and-oauth-tokens)
