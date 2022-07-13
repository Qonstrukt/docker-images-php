#!/usr/bin/env bash

set -eE -o functrace

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

OWNER="${OWNER:-thecodingmachine}"

# Let's replace the "." by a "-" with some bash magic
BRANCH_VARIANT="${VARIANT//./-}"

if [ -z "$NATIVE_ARCH" ]
then
  NATIVE_ARCH=`dpkg --print-architecture`
fi

# Let's also tag PHP patch releases
PHP_PATCH_VERSION=`docker run --rm ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-${NATIVE_ARCH} php -v | head -n1 | grep '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' -Eo | head -n1`
echo "Combining patch release $PHP_PATCH_VERSION"

export DOCKER_BUILDKIT=1 # Force use of BuildKit

docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-v4-slim-${BRANCH_VARIANT}

docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-v4-slim-${BRANCH_VARIANT}

docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}

docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}

docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node14

docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node14

docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node16

docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node16

docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node18 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node18-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node18-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-v4-${BRANCH_VARIANT}-node18

docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node18 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node18-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node18-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-v4-${BRANCH_VARIANT}-node18
