#!/bin/bash
set -e

if [[ "$WITH_XDEBUG" == 1 ]]
then
  mv /usr/local/etc/php/conf.d/xdebug.ini.disabled /usr/local/etc/php/conf.d/xdebug.ini
fi

exec "$@"