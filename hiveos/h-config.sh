#!/usr/bin/env bash

set -euo pipefail

[[ -e /hive/custom/krx-pool-miner/h-manifest.conf ]] && . /hive/custom/krx-pool-miner/h-manifest.conf
[[ -e /hive/miners/custom/krx-pool-miner/h-manifest.conf ]] && . /hive/miners/custom/krx-pool-miner/h-manifest.conf

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

mkdir -p "$(dirname "$CUSTOM_CONFIG_FILENAME")"
printf '%s\n' "$conf" > "$CUSTOM_CONFIG_FILENAME"
printf '%s\n' "$conf"
