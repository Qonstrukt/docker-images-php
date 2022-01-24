#!/usr/bin/env bash

set -eE -o functrace

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

# Let's replace the "." by a "-" with some bash magic
BRANCH_VARIANT="${VARIANT//./-}"
CURRENT_ARCH="${PLATFORM//*\/}"

# Let's also tag PHP patch releases
PHP_PATCH_VERSION=`docker run --rm ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-${CURRENT_ARCH} php -v | head -n1 | grep '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' -Eo | head -n1`
echo "Tagging patch release $PHP_PATCH_VERSION"

export DOCKER_BUILDKIT=1 # Force use of BuildKit

docker tag ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node12-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16-${CURRENT_ARCH}

docker push --all-tags ${OWNER}/php