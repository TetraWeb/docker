# Changelog TetraWeb docker images

`2016-04-26`
 - [PHP] Uncomment enabling xdebug from environment variables for PHP7.0 (thanks to @vikpe)

`2016-03-27`
 - [PHP] Remove PHP 5.2 since Debian 6.0 image is not available on Docker hub anymore

`2016-03-13`
 - [PHP] Update PHP7 xdebug version to stable 2.4.0

`2016-03-04`
 - [VM] Disable updating docker images via cron since gitlab-runner is doing that itself

`2016-01-10`
 - [PHP] Add xdebug for PHP 7
 - [PHP] Disable xdebug by default for PHP 5.2

`2016-01-09`
 - [HHVM] Preliminary hhvm release

`2016-01-06`
- [PHP] *WARNING: Images with `-cli` tags are not supported anymore* to decrease docker hub building overhead. So use `tetraweb/php:5.6` instead of `tetraweb/php:5.6-cli`, they are equal
- [PHP] Add missing libicu library for `intl` extension
- [PHP] Add new `mongodb` to 5.4+ images including 7.0

