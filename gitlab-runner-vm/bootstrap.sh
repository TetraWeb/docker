#!/bin/bash

###############################################################################
#
# This is a bootstrap script for quickly setting up gitlab-runner
# on virtual (or even metal) machine with Ubuntu-14.04
#
# gitlab-runner is configured below to run the separate 
# docker container (runner) for each version of php
#
# TODO:
# System-related variables:
# TZ="Europe/Moscow" for setting timezone (Is it really needed?)
# USE_SWAP="1G" for creating swap
#
# Runner-related variables:
# CI_URL - URL of Gitlab-CI installation
# CI_TOKEN - Token for adding runner. Can be found ($CI_URL/admin/runners)
# CONCURRENT=1 Number of runners which can be executed simultaneously
# COMPOSER_GITHUB="TOKEN" - Github oauth token passed to each container
#
# Usage:
# 1. Install fresh ubuntu distribution
# 2.1 Non-interactive mode (doesn't require any input):
#     # export CI_URL=http://ci.example.com CI_TOKEN=12345abcdef[ OTHER_VAR=VALUE ...]; curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash
# OR
# 2.2 Interactive mode (script will ask for all variables to be typed while run)
#     # curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash
#
###############################################################################

while [ -z "$CI_URL" ]; do
    echo -n "Enter URL of your Gitlab CI installation: "
    read CI_URL < /dev/tty
done

while [ -z "$CI_TOKEN" ]; do
    echo -n "Enter API key (find it at $CI_URL/admin/runners:) "
    read CI_TOKEN < /dev/tty
done

if [ ! -z "$TZ" ]; then
    echo "$TZ" > /etc/timezone
    ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime
fi

# Create swap
# dd if=/dev/zero of=/swapfile bs=1024 count=1024k
# mkswap /swapfile
# swapon /swapfile
# echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab
# echo 10 | tee /proc/sys/vm/swappiness
# echo vm.swappiness = 10 | tee -a /etc/sysctl.conf
# chown root:root /swapfile
# chmod 0600 /swapfile

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get -y upgrade
apt-get -y install mc htop ntpdate git curl wget openssh-server

# Install docker
wget -qO- https://get.docker.com/ | sh

# Install multi-runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash

apt-get install gitlab-ci-multi-runner
cd ~gitlab_ci_multi_runner
cronjob = "#!/bin/bash\n"
for phpver in 5.3 5.4 5.5 5.6 7.0
do
    sudo -u gitlab_ci_multi_runner -H gitlab-ci-multi-runner register -n -r "$CI_TOKEN" -u "$CI_URL" -t "php-$phpver,mysql,redis" -e 'docker' --docker-image tetraweb/php:$phpver --docker-mysql latest --docker-redis latest
    cronjob+="docker pull tetraweb/php:$phpver\n"
done

# Cleanup orphaned images
cronjob+="docker rmi $(docker images | grep none | awk '{print $3}')\n"
echo $cronjob > /etc/cron.daily/docker-update-images
chmod 755 /etc/cron.daily/docker-update-images