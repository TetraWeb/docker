# TetraWeb PHP CI Kit with Docker

This repository contains a set of utilities for running PHP tests via [Gitlab CI](https://about.gitlab.com/gitlab-ci/).

These tools provide:

1. [Gitlab runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner) deployment script for Ubuntu on VM or metal server. It is not recommended to install runner right on the production system.

2. Set of Docker images for PHP 5.2 - 7.0 based on official Docker PHP images (Few limitations for PHP 5.2)

3. MySQL image with minimized requirements for RAM based on official Docker image

4. Links to redis and mongo official Docker images

The goal of these tools is to automate as much as possible of routine work related to configuring the runner so you can concentrate on writing tests for your code.
Also these tools are trying to be resources savvy, since in most cases huge in-RAM caches are not needed for just running unit tests with some fixtures. So you can use very small VMs for running tests

## Contents of repository
 - [Gitlab-runner bootstrap script](https://github.com/TetraWeb/docker/tree/master/gitlab-runner-vm) for deploying gitlab-runner
 - [PHP Docker images](https://github.com/TetraWeb/docker/tree/master/php) - based on official Docker images, but include addtional modules and also obsolete versions of PHP 5.3 and 5.2
 - [MySQL Docker images](https://github.com/TetraWeb/docker/tree/master/mysql) - with minimized RAM requirements
 - [Example projects](https://github.com/TetraWeb/docker/tree/master/examples) - Example PHP projects

## Quick start

1. Install [Gitlab](https://about.gitlab.com/)
1. Get a server (VM or metal) with minimal Ubuntu-14.04 installed. It will be used for the runner
1. Login as root to a server and execute `curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash` and answer the questions. This script will install docker, Gitlab runner, and configure runner for using these docker images.

Script also installs the cronjob for updating images weekly, so you will always have the latest versions of PHP images (`/etc/cron.weekly/docker-update-images`)

*It's not recommended to run update more often since docker cleanup system of unused images still is not perfect and leave some garbage in your /var/lib/docker*

Runner is limited to `tetraweb/php:*` images for main container (where your repository is cloned) and any service images `*/*` (secondary containers spinned for services like mysql, redis, etc)

If you want to use the server for also running other images (`ruby` or whatever), you should add another runners to `/etc/gitlab-runner/config.toml`, and DO NOT overwrite `allowed_images = ["tetraweb/php:*"]` for this runner, since it is a potential security breach.

## PHP modules
Almost all modules are disabled by default You should enable modules with `docker-php-ext-enable module1 module2`

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

## TODO
 - MySQL with smaller RAM demands
 - Mongo (Maybe smaller initial size to decrease the time of initialization)

## Requirements
 - Gitlab v`7.13.0` and later
 - Gitlab CI v`7.13.0` and later (not needed if you have Gitlab >=8)
 - Gitlab runner v`0.5.0` and later

## Similar projects
 - https://github.com/bobey/docker-gitlab-ci-runner (For old gitlab-ci-runner, misses PHP 5.3)
