ARG BRANCH
ARG BRANCH_VARIANT
ARG PHP_VERSION
ARG OWNER

ARG PHP_EXTENSIONS="gd"
FROM ${OWNER}/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}-${TARGETARCH}

COPY composer.json composer.json

# Let's check that GD is available.
RUN composer install
