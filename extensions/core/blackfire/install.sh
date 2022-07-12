#!/usr/bin/env bash

set -e
set -ex

# Install Blackfire
curl -sL https://packages.blackfire.io/gpg.key | sudo apt-key add -
echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list
sudo apt update -y
sudo apt install -y --no-install-recommends blackfire-agent blackfire-php
touch /var/lib/php/modules/${PHP_VERSION}/registry/blackfire

# Let's test it
/usr/bin/real_php -m | grep blackfire
