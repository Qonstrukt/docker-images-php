#!/usr/bin/env bash

set -e
export DEV_DEPENDENCIES="librdkafka-dev"
export DEPENDENCIES="librdkafka1"
export PECL_EXTENSION=rdkafka 
export PIE_EXTENSION=rdkafka/rdkafka 

../docker-install.sh
