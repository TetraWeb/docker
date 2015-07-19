# PHP for CI

These images are built from [Docker official php images](https://registry.hub.docker.com/_/php/), but additionally include:

 - External extensions: redis, mongo, xdebug (disabled by default)
 - Core extensions: gettext, mbstring, mcrypt, pcntl, pdo_mysql, zip
 - Git client from official jessie repo
 - composer
 - `docker-php-ext-enable` and `docker-php-ext-disable` will enable and disable extensions

See below for details

# Supported tags and respective `Dockerfile` links

-	[`5.3-cli`, `5.3` (*5.3/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.3/Dockerfile)
-	[`5.4-cli`, `5.4` (*5.4/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.4/Dockerfile)
-	[`5.5-cli`, `5.5` (*5.5/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.5/Dockerfile)
-	[`5.6-cli`, `5.6`, `latest` (*5.6/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/5.6/Dockerfile)
-	[`7.0-cli`, `7.0`, (*7.0/Dockerfile*)](https://github.com/TetraWeb/docker/blob/master/php/7.0/Dockerfile)


For more information check the [Github repository](https://github.com/TetraWeb/docker/)

## Environment variables

There are environment variables which can be passed to images on docker run

 - `$WITH_XDEBUG=1` - enables xdebug extension
 - `$COMPOSER_GITHUB=<YOUR_GITHUB_TOKEN>` - Adds Github oauth token for composer which allows composer to get unlimited repositories from Github without blocking non-interactive mode with request for authorization. You can obtain your token at [https://github.com/settings/tokens](https://github.com/settings/tokens)

## Advantages of these images

 - Builds are based on official Docker php images
 - Automatically rebuilds when official images are updated, so this repository always contain the latest versions
 - PHP 5.3 added based on Docker Debian Wheezy images. No surprises here since support of PHP 5.3 is discontinued by PHP
