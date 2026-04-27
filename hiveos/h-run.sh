#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -z "${MINER_DIR:-}" || -z "${CUSTOM_MINER:-}" ]]; then
  MINER_PATH="$SCRIPT_DIR"
else
  MINER_PATH="$MINER_DIR/$CUSTOM_MINER"
fi

. "${MINER_PATH}/h-manifest.conf"
config_file="${CUSTOM_CONFIG_FILENAME:-config.ini}"
[[ "$config_file" = /* ]] || config_file="${MINER_PATH}/${config_file}"

[[ -z "${CUSTOM_LOG_BASENAME:-}" ]] && echo "No CUSTOM_LOG_BASENAME is set" && exit 1
[[ ! -f "$config_file" ]] && echo "Custom config $config_file is not found" && exit 1

mkdir -p "$(dirname "$CUSTOM_LOG_BASENAME")"

cd "$MINER_PATH"
./"$CUSTOM_MINERBIN" $(<"$config_file") "$@" 2>&1 | tee "${CUSTOM_LOG_BASENAME}.log"
