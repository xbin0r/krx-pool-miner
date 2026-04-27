# krx-pool-miner

Public download repository for the `krx-pool-miner` Linux binaries and HiveOS custom miner package.

This repository is intentionally kept minimal:

- no source code is published here
- no development branches are maintained here
- GitHub is used only for downloadable release artifacts
- release notes and binaries only

## Download

Download the latest Linux build from the Releases page:

- `krx-pool-miner-v*-linux-x86_64.tar.gz`

Latest release includes:

- fix for the stratum reconnect loop caused by dev fee rotation
- stable behavior with `--devfund-percent 0`
- HiveOS custom miner package
- HiveOS package layout fix for direct custom miner installs
- Ubuntu 22 Linux and HiveOS assets

## Quick start

1. Download and extract the latest Linux archive.
2. Start the miner against the MiningCrib pool:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --threads 0
```

`--threads 0` lets the miner auto-pick CPU threads. GPU plugins are loaded automatically when available.

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

## Notes

- This repository is release-only.
- Source code is not mirrored here.
- Future releases in this repository are Linux-first.

## Support

- Discord: https://discord.gg/K75jXbVBwd
- Email: xbinoro@proton.me
