## What's new

- fixed the stratum reconnect loop caused by dev fee rotation
- fixed stable operation when running with `--devfund-percent 0`
- Linux x86_64 release with bundled CUDA and OpenCL plugins
- HiveOS custom miner package with wrapper scripts and stats integration
- aligned HiveOS package layout with common custom miner bundles
- added Ubuntu 22 Linux and HiveOS release assets

## Pool quick start

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --threads 0
```

To disable the dev fee:

```bash
./keryx-miner \
  --keryxd-address stratum+tcp://eu.miningcrib.com:7212 \
  --mining-address keryx:YOUR_WALLET_ADDRESS \
  --devfund-percent 0
```
