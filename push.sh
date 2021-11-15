#!/usr/bin/env bash

set -eE -o functrace

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

BRANCH_VARIANT=`echo "$VARIANT" | sed 's/\./-/g'`

# Let's also tag PHP patch releases
PHP_PATCH_VERSION=`docker run --rm qonstrukt/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} php -v | head -n1 | grep '[[:digit:]+]\.[[:digit:]+]\.[[:digit:]+]' -o | head -n1`
echo "Tagging patch release $PHP_PATCH_VERSION"

docker tag qonstrukt/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} qonstrukt/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}
docker tag qonstrukt/php:${PHP_VERSION}-v4-${BRANCH_VARIANT} qonstrukt/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}
docker tag qonstrukt/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 qonstrukt/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12
docker tag qonstrukt/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 qonstrukt/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14
docker tag qonstrukt/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 qonstrukt/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16

docker push --all-tags qonstrukt/php