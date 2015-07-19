#!/bin/bash
set -e

# With env variable WITH_XDEBUG=1 xdebug extension will be enabled
if [[ "$WITH_XDEBUG" == 1 && -f /usr/local/etc/php/conf.d/xdebug.ini.disabled ]]
then
  mv /usr/local/etc/php/conf.d/xdebug.ini.disabled /usr/local/etc/php/conf.d/xdebug.ini
fi

# Provide github token if you are using composer a lot in non-interactive mode
# Otherwise one day it will get stuck with request for authorization
# https://github.com/settings/tokens
if [[ ! -z "$COMPOSER_GITHUB" ]]
then
  composer config --global github-oauth.github.com "$COMPOSER_GITHUB"
fi

exec "$@"