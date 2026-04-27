#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/h-manifest.conf"
config_file="${CUSTOM_CONFIG_FILENAME:-config.ini}"
[[ "$config_file" = /* ]] || config_file="${SCRIPT_DIR}/${config_file}"

pool_url="${CUSTOM_URL:-}"

if [[ -z "$pool_url" && -n "${CUSTOM_HOST:-}" ]]; then
  if [[ -n "${CUSTOM_PORT:-}" ]]; then
    pool_url="stratum+tcp://${CUSTOM_HOST}:${CUSTOM_PORT}"
  else
    pool_url="stratum+tcp://${CUSTOM_HOST}"
  fi
fi

if [[ -z "$pool_url" ]]; then
  pool_url="stratum+tcp://eu.miningcrib.com:7212"
fi

conf=""
conf+=" --keryxd-address=${pool_url}"
conf+=" --mining-address ${CUSTOM_TEMPLATE}"
conf+=" --threads 0"

if [[ -n "${CUSTOM_USER_CONFIG:-}" ]]; then
  conf+=" ${CUSTOM_USER_CONFIG}"
fi

mkdir -p "$(dirname "$config_file")"
printf '%s\n' "$conf" > "$config_file"
printf '%s\n' "$conf"
