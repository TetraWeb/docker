# TetraWeb PHP CI Kit with Docker

[![Build Status](https://travis-ci.org/TetraWeb/docker.svg?branch=master)](https://travis-ci.org/TetraWeb/docker)

This repository contains a set of utilities for running PHP tests via [Gitlab CI](https://about.gitlab.com/gitlab-ci/).

These tools provide:

1. [Gitlab runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner) deployment script for Ubuntu on VM or metal server. It is not recommended to install runner right on the production system.

2. Set of Docker images for PHP 5.5 - 7.1 based on official Docker PHP images with additional modules and Node.js

The goal of these tools is to automate as much as possible of routine work related to configuring the runner so you can concentrate on writing tests for your code.
Also these tools are trying to be resources savvy, since in most cases huge in-RAM caches are not needed for just running unit tests with some fixtures. So you can use very small VMs for running tests

## Contents of repository
 - [Gitlab-runner bootstrap script](https://github.com/TetraWeb/docker/tree/master/gitlab-runner-vm) for deploying gitlab-runner
 - [PHP Docker images](https://github.com/TetraWeb/docker/tree/master/php) - based on official Docker images, but include addtional modules and also obsolete versions of PHP 5.3 and PHP 5.4
 - [Example projects](https://github.com/TetraWeb/docker/tree/master/examples) - Example PHP projects

## Quick start

1. Install [Gitlab](https://about.gitlab.com/)
1. Get a server (VM or metal) with minimal Ubuntu-14.04 installed. It will be used for the runner
1. Login as root to a server and execute `curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash` and answer the questions. This script will install docker, Gitlab runner, and configure runner for using these docker images.

Runner is limited to `tetraweb/php:*` images for main container (where your repository is cloned) and any service images `*/*` (secondary containers spinned for services like mysql, redis, etc)

If you want to use the server for also running other images (`ruby` or whatever), you should add another runners to `/etc/gitlab-runner/config.toml`, and DO NOT overwrite `allowed_images = ["tetraweb/php:*"]` for this runner, since it is a potential security breach.

## Requirements
 - Gitlab v`9.0` and later
 - Gitlab runner v`9.0` and later

## Similar projects
 - https://github.com/bobey/docker-gitlab-ci-runner (For old gitlab-ci-runner, misses PHP 5.3)
