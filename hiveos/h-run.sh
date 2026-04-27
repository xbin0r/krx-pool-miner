#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

[ -t 1 ] && . colors || true

. ./h-manifest.conf
config_file="${CUSTOM_CONFIG_FILENAME:-config.ini}"
[[ "$config_file" = /* ]] || config_file="${SCRIPT_DIR}/${config_file}"

[[ -z "${CUSTOM_LOG_BASENAME:-}" ]] && echo "No CUSTOM_LOG_BASENAME is set" && exit 1
[[ ! -f "$config_file" ]] && echo "Custom config $config_file is not found" && exit 1

mkdir -p "$(dirname "$CUSTOM_LOG_BASENAME")"

./"$CUSTOM_MINERBIN" $(<"$config_file") "$@" 2>&1 | tee "${CUSTOM_LOG_BASENAME}.log"
