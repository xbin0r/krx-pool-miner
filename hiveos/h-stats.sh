#!/usr/bin/env bash

set -euo pipefail

. /hive/miners/custom/krx-pool-miner/h-manifest.conf

log_file="${CUSTOM_LOG_BASENAME}.log"
max_delay=120
time_now=$(date +%s)
diff_time=999999

if [[ -f "$log_file" ]]; then
  time_rep=$(stat -c %Y "$log_file")
  diff_time=$((time_now - time_rep))
fi

to_khs() {
  local value="${1:-0}"
  local unit="${2:-hash/s}"
  case "$unit" in
    hash/s) awk "BEGIN{printf \"%.0f\", ${value}/1000}" ;;
    Khash/s) awk "BEGIN{printf \"%.0f\", ${value}}" ;;
    Mhash/s) awk "BEGIN{printf \"%.0f\", ${value}*1000}" ;;
    Ghash/s) awk "BEGIN{printf \"%.0f\", ${value}*1000000}" ;;
    Thash/s) awk "BEGIN{printf \"%.0f\", ${value}*1000000000}" ;;
    *) echo 0 ;;
  esac
}

stats_raw=""
if [[ -f "$log_file" ]]; then
  stats_raw=$(grep -F "Current hashrate is" "$log_file" | tail -n 1 || true)
fi

if [[ -n "$stats_raw" && "$diff_time" -lt "$max_delay" ]]; then
  total_rate=$(awk '{print $(NF-1)}' <<<"$stats_raw")
  total_unit=$(awk '{print $NF}' <<<"$stats_raw")
  total_hashrate=$(to_khs "$total_rate" "$total_unit")

  gpu_stats=$(<"$GPU_STATS_JSON")
  readarray -t gpu_meta < <(jq --slurp -r -c '.[] | .busids, .brand, .temp, .fan | join(" ")' "$GPU_STATS_JSON" 2>/dev/null)
  busids=(${gpu_meta[0]:-})
  brands=(${gpu_meta[1]:-})
  temps=(${gpu_meta[2]:-})
  fans=(${gpu_meta[3]:-})
  gpu_count=${#busids[@]}

  hash_arr=()
  busid_arr=()
  fan_arr=()
  temp_arr=()

  if [[ $(gpu-detect NVIDIA) -gt 0 ]]; then
    brand_miner="nvidia"
  elif [[ $(gpu-detect AMD) -gt 0 ]]; then
    brand_miner="amd"
  else
    brand_miner=""
  fi

  for ((i = 0; i < gpu_count; i++)); do
    [[ -n "$brand_miner" && "${brands[i]}" != "$brand_miner" ]] && continue
    [[ "${busids[i]}" =~ ^([A-Fa-f0-9]+): ]] || continue
    busid_arr+=($((16#${BASH_REMATCH[1]})))
    temp_arr+=("${temps[i]}")
    fan_arr+=("${fans[i]}")

    gpu_raw=$(grep -F "Device #${i}:" "$log_file" | tail -n 1 || true)
    if [[ -n "$gpu_raw" && "$gpu_raw" != *"0 hash/s"* ]]; then
      gpu_rate=$(awk '{print $(NF-1)}' <<<"$gpu_raw")
      gpu_unit=$(awk '{print $NF}' <<<"$gpu_raw")
      hashrate=$(to_khs "$gpu_rate" "$gpu_unit")
    else
      hashrate=0
    fi
    hash_arr+=("$hashrate")
  done

  hash_json=$(printf '%s\n' "${hash_arr[@]:-0}" | jq -cs '.')
  bus_numbers=$(printf '%s\n' "${busid_arr[@]:-0}" | jq -cs '.')
  fan_json=$(printf '%s\n' "${fan_arr[@]:-0}" | jq -cs '.')
  temp_json=$(printf '%s\n' "${temp_arr[@]:-0}" | jq -cs '.')
  uptime=$((time_now - $(stat -c %Y "$CUSTOM_CONFIG_FILENAME")))

  stats=$(jq -nc \
    --argjson hs "$hash_json" \
    --arg ver "$CUSTOM_VERSION" \
    --arg ths "$total_hashrate" \
    --argjson bus_numbers "$bus_numbers" \
    --argjson fan "$fan_json" \
    --argjson temp "$temp_json" \
    --arg uptime "$uptime" \
    '{hs:$hs, hs_units:"khs", algo:"keryxhash", ver:$ver, ths:$ths, bus_numbers:$bus_numbers, temp:$temp, fan:$fan, uptime:$uptime}')
  khs=$total_hashrate
else
  khs=0
  stats="null"
fi

[[ -z "${khs:-}" ]] && khs=0
[[ -z "${stats:-}" ]] && stats="null"

echo "{\"khs\":$khs,\"stats\":$stats}"
