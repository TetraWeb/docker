# PHP for CI

PHP Docker images for continuous integration and running tests. These images were created for using with Gitlab CI.
Although they can be used with any automated testing system or as standalone services.

Images do not have `VOLUME` directories since fresh version of sources is supposed to be downloaded into image each time before running tests

These images are built from [Docker official php images](https://registry.hub.docker.com/_/php/), but additionally include:

 - External extensions: redis, mongo. Disabled by default: opcache, xdebug (Opcache is compiled as core extension in PHP 5.5+)
 - Core extensions: gettext, mbstring, mcrypt, pcntl, pdo_mysql, zip
 - Git client from official jessie repo
 - Composer
 - PHPUnit - latest stable version
 - `docker-php-ext-enable` and `docker-php-ext-disable` will enable and disable extensions (load modules in additional ini files)

See below for details

## Advantages of these images

 - Builds are based on official Docker php images
 - Automatically rebuilt when official images are updated, so this repository always contains the latest versions
 - PHP 5.3 added based on Docker Debian Wheezy images. No surprises here since support of PHP 5.3 is discontinued by PHP
 - PHP 5.2 added based on Docker Debian Squeeze images. No surprises here as well

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
 - `COMPOSER_GITHUB=<YOUR_GITHUB_TOKEN>` - Adds Github oauth token for composer which allows composer to get unlimited repositories from Github without blocking non-interactive mode with request for authorization. You can obtain your token at [https://github.com/settings/tokens](https://github.com/settings/tokens)
   
    [Composer documentation about Github API rate limit](https://getcomposer.org/doc/articles/troubleshooting.md#api-rate-limit-and-oauth-tokens)
