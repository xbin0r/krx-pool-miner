# krx-pool-miner

Public download repository for the `krx-pool-miner` Linux binaries, Windows builds, and HiveOS custom miner package.

This repository is intentionally kept minimal:

- no source code is published here
- no development branches are maintained here
- GitHub is used only for downloadable release artifacts
- release notes and binaries only

## Download

Download the latest builds from the Releases page:

- `krx-pool-miner-v*-linux-x86_64.tar.gz`
- `krx-pool-miner-v*-windows-x86_64.zip`

Latest release includes:

- `--min-payout` support for requesting a higher pool payout threshold over Stratum
- OPoI escrow public-key option for direct gRPC mining experiments
- Linux/HiveOS binaries rebuilt with Ubuntu 22 glibc baseline for wider compatibility
- panic guard for plugin option parsing (avoids full crash if one plugin panics)
- reconnect immediately when the stratum submit channel dies
- stop hashing stale work after a dead stratum session instead of running until manual restart
- fix for the stratum reconnect loop caused by dev fee rotation
- reconnect when the stratum pool goes idle or disappears silently
- fix for unexpected graceful reconnect loops during long-running stratum sessions
- `--password` support for custom stratum passwords and fixed diff
- stable behavior with `--devfund-percent 0`
- Windows build with bundled runtime files
- HiveOS custom miner package
- HiveOS package layout aligned with common custom miner bundles
- Ubuntu 22 Linux and HiveOS assets

## Quick start

1. Download and extract the latest Linux archive or Windows zip.
2. Start the miner against the MiningCrib pool:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --threads 0
```

`--threads 0` lets the miner auto-pick CPU threads. GPU plugins are loaded automatically when available.

For fixed difficulty on Miningcore-compatible pools, pass a stratum password such as:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7213 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --password 'x;d=1000000000'
```

To request a higher pool payout threshold on supported pools:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --min-payout 1000
```

On Windows, use the bundled `mine.bat` as a starting point and replace `YOUR_WALLET_ADDRESS` before first launch.

## Dev fee

The miner includes a dev fee by default.

You can disable it explicitly:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --devfund-percent 0
```

Latest versions no longer enter a reconnect loop when the dev fee rotation boundary is reached.

## HiveOS

HiveOS users can use the bundled custom miner package from Releases:

- `krx-pool-miner-v*-linux-hiveos.tar.gz`
- `krx-pool-miner-v*-linux-ubuntu22-hiveos.tar.gz`

Recommended pool URLs:

- standard port: `stratum+tcp://eu.miningcrib.com:7212`
- higher-difficulty port: `stratum+tcp://eu.miningcrib.com:7213`

Wallet/template should be your `keryx:` address.

Optional extra config:

```bash
--devfund-percent 0
```

For fixed diff in HiveOS extra config, you can also use:

```bash
--password 'x;d=1000000000'
```

For a custom payout threshold in HiveOS extra config:

```bash
--min-payout 1000
```

## Notes

- This repository is release-only.
- Source code is not mirrored here.
- Release assets may include Linux, Windows, and HiveOS packages depending on the version.

## Support

- Discord: https://discord.gg/K75jXbVBwd
- Email: xbinoro@proton.me
