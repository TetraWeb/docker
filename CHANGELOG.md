# Changelog TetraWeb docker images

`2015-03-13`
 - [PHP] update PHP7 xdebug version to stable 2.4.0

`2015-03-04`
 - [VM] Disable updating docker images via cron since gitlab-runner is doing that itself

`2015-01-10`
 - [PHP] Add xdebug for PHP 7
 - [PHP] Disable xdebug by default for PHP 5.2

`2015-01-09`
 - [HHVM] Preliminary hhvm release

`2015-01-06`
- [PHP] *WARNING: Images with `-cli` tags are not supported anymore* to decrease docker hub building overhead. So use `tetraweb/php:5.6` instead of `tetraweb/php:5.6-cli`, they are equal
- [PHP] Add missing libicu library for `intl` extension
- [PHP] Add new `mongodb` to 5.4+ images including 7.0

