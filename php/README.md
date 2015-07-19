# PHP for CI

This image is built from official php image, but additionally includes:

 - External extensions: redis, mongo, xdebug (disabled by default)
 - Core extensions: gettext, mbstring, mcrypt, pcntl, pdo_mysql, zip
 - Git client from official jessie repo
 - composer
 - `docker-php-ext-enable` and `docker-php-ext-disable` will enable and disable extensions

## Environment variables

There are environment variables which can be passed to images on docker run

 - `$WITH_XDEBUG=1` - enables xdebug extension
 - `$COMPOSER_GITHUB=<YOUR_GITHUB_TOKEN>` - Adds Github oauth token for composer which allows composer to get unlimited repositories from Github without blocking non-interactive mode with request for authorization. You can obtain your token at https://github.com/settings/tokens

## Advantages of these images

 - Builds are based on official Docker php images
 - Automatically rebuilt when official images updated, so this repository always contain the latest versions
 - PHP 5.3 added based on Docker Debian Wheezy images. No surprises here since support of PHP 5.3 is discontinued by PHP