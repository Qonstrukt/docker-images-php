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
PHP_PATCH_VERSION=`docker run --rm ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-${NATIVE_ARCH} php -v | head -n1 | grep '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' -Eo | head -n1`
echo "Combining patch release $PHP_PATCH_VERSION"

export DOCKER_BUILDKIT=1 # Force use of BuildKit

# php:8.3-v7-slim-apache
docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}

# php:8.3.0-v7-slim-apache
docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}

# php:8.3-v7-apache
docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}

# php:8.3.0-v7-apache
docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT} \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}

# php:8.3-v7-apache-node18
docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18

# php:8.3.0-v7-apache-node18
docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node18

# php:8.3-v7-apache-node20
docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20

# php:8.3.0-v7-apache-node20
docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node20

# php:8.3-v7-apache-node22
docker manifest create \
    ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-amd64 \
    --amend ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-arm64
docker manifest push ${OWNER}/php:${PHP_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22

# php:8.3.0-v7-apache-node22
docker manifest create \
    ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-amd64 \
    --amend ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22-arm64
docker manifest push ${OWNER}/php:${PHP_PATCH_VERSION}-${BRANCH}-${BRANCH_VARIANT}-node22
