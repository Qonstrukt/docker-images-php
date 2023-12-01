#!/bin/bash

set -e
set -x

# Let's disable autoclean of package list after apt install
mv /etc/apt/apt.conf.d/docker-clean /tmp/docker-clean

apt update

/usr/bin/real_php /usr/local/bin/install_selected_extensions.php

# Let's enable autoclean again
mv /tmp/docker-clean /etc/apt/apt.conf.d/docker-clean

apt purge -y php-pear build-essential php${PHP_VERSION}-dev pkg-config
apt autoremove -y
apt clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
