# PHP for CI

This image is built from official php image, but additionally includes:

 - External extensions: redis, mongo, xdebug
 - Core extensions: gettext, mbstring, mcrypt, pcntl, pdo_mysql, zip
 - Git client from official jessie repo
 - composer (Good practice to run composer self-update)