#!/usr/bin/env bash

set -e
export DEPENDENCIES="php${PHP_VERSION}-igbinary php${PHP_VERSION}-msgpack"
export EXTENSION=memcached

# we need to do some weird stuff to get memcached working
phpdismod igbinary
phpenmod igbinary

../docker-install.sh

phpdismod igbinary