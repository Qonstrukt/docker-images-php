#!/bin/bash

set -e

exec "sudo" "-E" "/usr/local/bin/tini" "-g" "-s" "--" "/usr/local/bin/docker-entrypoint-as-root.sh" "$@";
