# krx-pool-miner

Public download repository for the `krx-pool-miner` Linux binaries.

This repository is intentionally kept minimal:

- no source code is published here
- no development branches are maintained here
- GitHub is used only for downloadable release artifacts
- release notes and binaries only

## Download

Download the latest Linux build from the Releases page:

- `krx-pool-miner-v*-linux-x86_64.tar.gz`

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

## Notes

- This repository is release-only.
- Source code is not mirrored here.
- Future releases in this repository are Linux-first.

## Support

- Discord: https://discord.gg/K75jXbVBwd
- Email: xbinoro@proton.me
