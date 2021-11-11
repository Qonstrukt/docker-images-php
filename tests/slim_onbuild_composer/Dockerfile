ARG BRANCH
ARG BRANCH_VARIANT
ARG PHP_VERSION
ARG TARGETARCH

ARG PHP_EXTENSIONS="gd"
FROM qonstrukt/php:${PHP_VERSION}-${BRANCH}-slim-${BRANCH_VARIANT}

COPY composer.json composer.json

# Let's check that GD is available.
RUN composer install
