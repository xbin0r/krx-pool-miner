#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -z "${MINER_DIR:-}" || -z "${CUSTOM_MINER:-}" ]]; then
  MINER_PATH="$SCRIPT_DIR"
else
  MINER_PATH="$MINER_DIR/$CUSTOM_MINER"
fi

. "${MINER_PATH}/h-manifest.conf"

pkill -f "/${MINER_NAME}/${CUSTOM_MINERBIN}" || true
pkill -f "${MINER_PATH}/${CUSTOM_MINERBIN}" || true
pkill -f "./${CUSTOM_MINERBIN}" || true
