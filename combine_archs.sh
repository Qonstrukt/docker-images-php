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
echo "Combining patch release $PHP_PATCH_VERSION"

export DOCKER_BUILDKIT=1 # Force use of BuildKit

docker manifest create \
    php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} \
    --amend php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-amd64 \
    --amend php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-arm64
docker manifest create \
    php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT} \
    --amend php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}-amd64 \
    --amend php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}-arm64

docker manifest create \
    php:${PHP_VERSION}-v4-${BRANCH_VARIANT} \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-amd64 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-arm64
docker manifest create \
    php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT} \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-amd64 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-arm64

docker manifest create \
    php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node12 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node12-amd64 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node12-arm64
docker manifest create \
    php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12-amd64 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node12-arm64

docker manifest create \
    php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14-amd64 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14-arm64
docker manifest create \
    php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14-amd64 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14-arm64

docker manifest create \
    php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16-amd64 \
    --amend php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16-arm64
docker manifest create \
    php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16-amd64 \
    --amend php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16-arm64

docker push --all-tags ${OWNER}/php