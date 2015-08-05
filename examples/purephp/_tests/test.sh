#!/bin/bash

set -xe

composer self-update
phpunit --self-update

composer --version
phpunit --version

php -i