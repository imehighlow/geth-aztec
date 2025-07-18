#!/bin/bash

echo "Waiting for Geth execution node to be synced..."

# Wait for Geth HTTP server to be ready
until curl -s -f http://geth:8545 > /dev/null 2>&1; do
    echo "Waiting for Geth HTTP server..."
    sleep 5
done

echo "Geth HTTP server is ready. Checking sync status..."

# Wait for Geth to be synced
while true; do
    SYNC_STATUS=$(curl -s -X POST -H "Content-Type: application/json" \
        -d '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' \
        http://geth:8545)
    
    if echo "$SYNC_STATUS" | grep -q '"result":false'; then
        echo "Geth is synced!"
        break
    elif echo "$SYNC_STATUS" | grep -q '"result":'; then
        echo "Geth is still syncing..."
        sleep 30
    else
        echo "Error checking sync status, retrying..."
        sleep 10
    fi
done

echo "Waiting for Prysm beacon node to be ready..."

# Wait for Prysm beacon HTTP server to be ready
until curl -s -f http://prysm-beacon:3500/eth/v1/node/health > /dev/null 2>&1; do
    echo "Waiting for Prysm beacon HTTP server..."
    sleep 5
done

echo "Prysm beacon is ready! Starting Aztec..."

# Start the original Aztec command
exec node --no-warnings /usr/src/yarn-project/aztec/dest/bin/index.js start --network alpha-testnet start --node --archiver --sequencer 