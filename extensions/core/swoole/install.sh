#!/usr/bin/env bash

set -e
if [[ "${TARGETARCH}" == "arm64" ]]; then
   # 176 seconds to execute onto arm64 arch
   >&2 echo "swoole is not included with arm64 version (because build time is too long)"
   exit 0;
 fi
export DEV_DEPENDENCIES="zlib1g-dev"
export DEPENDENCIES="zlib1g"
export USE_PECL=1
PECL_EXTENSION=swoole ../docker-install.sh
