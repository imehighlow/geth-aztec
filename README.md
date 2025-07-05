# Geth + Aztec Node Setup

This repository contains Docker Compose configuration to run a Geth Sepolia node with an Aztec node.

## Setup

1. **Copy environment file:**
   ```bash
   cp env.example .env
   ```

2. **Edit `.env` file:**
   - Set your `VALIDATOR_PRIVATE_KEY`
   - Set your `P2P_IP`

3. **Start services:**
   ```bash
   docker compose up -d
   ```

## Services

- **Geth**: Sepolia testnet node (ports 8545, 8551, 30303)
- **Aztec**: Aztec node (ports 40400, 8080)

## Security Notes

- Never commit `.env` file with real private keys
- Data directories are excluded from git
- Consider firewall rules for exposed ports

## Data Directories

- `geth-data-sepolia/`: Geth blockchain data
- `aztec-data/`: Aztec node data

These are created automatically and excluded from git. 