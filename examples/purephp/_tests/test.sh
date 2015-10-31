#!/bin/bash

set -xe

composer self-update

composer --version
phpunit --version

php -i