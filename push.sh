#!/usr/bin/env bash

set -eE -o functrace

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

OWNER="${OWNER:-thecodingmachine}"
PLATFORM="${PLATFORM:-linux/amd64}"

# Let's replace the "." by a "-" with some bash magic
BRANCH_VARIANT="${VARIANT//./-}"
CURRENT_ARCH="${PLATFORM//*\/}"

# Let's also tag PHP patch releases
PHP_PATCH_VERSION=`docker run --rm ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-${CURRENT_ARCH} php -v | head -n1 | grep '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' -Eo | head -n1`
echo "Tagging patch release $PHP_PATCH_VERSION"

export DOCKER_BUILDKIT=1 # Force use of BuildKit

docker tag ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-${CURRENT_ARCH}
docker tag ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-${CURRENT_ARCH} ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-${CURRENT_ARCH}

docker push --all-tags ${OWNER}/php