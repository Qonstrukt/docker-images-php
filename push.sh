#!/usr/bin/env bash

set -eE -o functrace

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

# Let's replace the "." by a "-" with some bash magic
BRANCH_VARIANT=`echo "$VARIANT" | sed 's/\./-/g'`

# Let's also tag PHP patch releases
PHP_PATCH_VERSION=`docker run --rm ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} php -v | head -n1 | grep '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]' -Eo | head -n1`
echo "Tagging patch release $PHP_PATCH_VERSION"

docker tag ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16

docker push --all-tags ${OWNER}/php