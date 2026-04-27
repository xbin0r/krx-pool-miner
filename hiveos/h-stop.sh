#!/usr/bin/env bash

set -euo pipefail

[[ -e /hive/custom/krx-pool-miner/h-manifest.conf ]] && . /hive/custom/krx-pool-miner/h-manifest.conf
[[ -e /hive/miners/custom/krx-pool-miner/h-manifest.conf ]] && . /hive/miners/custom/krx-pool-miner/h-manifest.conf

pkill -f "/${CUSTOM_NAME}/${CUSTOM_MINERBIN}" || true
pkill -f "./${CUSTOM_MINERBIN}" || true
