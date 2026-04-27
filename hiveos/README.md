# HiveOS Custom Miner

This package lets you add `krx-pool-miner` to HiveOS as a custom miner.

## Flight sheet values

Use these values in HiveOS:

- `Wallet / Template`: your `keryx:` wallet address
- `Pool URL`: `stratum+tcp://eu.miningcrib.com:7212`
- `Alternative pool URL`: `stratum+tcp://eu.miningcrib.com:7213`
- `Extra config arguments`:
  - optional: `--devfund-percent 0`

Port `7212` is the standard Keryx pool endpoint.

Port `7213` starts at a higher fixed difficulty and can ramp with VarDiff up to `5,000,000,000`.

## Package contents

The HiveOS package includes:

- `keryx-miner`
- `libkeryxcuda.so`
- `libkeryxopencl.so`
- `h-manifest.conf`
- `h-config.sh`
- `h-run.sh`
- `h-stop.sh`
- `h-stats.sh`

## Notes

- GPU plugins are loaded automatically from the miner directory.
- To disable the dev fee, append `--devfund-percent 0` in extra config arguments.
- CPU mining is disabled by default in the HiveOS wrapper with `--threads 0`.
