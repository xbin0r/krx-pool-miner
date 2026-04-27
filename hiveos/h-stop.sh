#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/h-manifest.conf"

pkill -f "/${CUSTOM_NAME}/${CUSTOM_MINERBIN}" || true
pkill -f "./${CUSTOM_MINERBIN}" || true
