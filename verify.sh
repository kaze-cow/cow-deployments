#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <chain id> <preset>"
    exit 1
fi

chainId=$1
preset=$2

CANNON=${CANNON:-pnpm cannon}
export CANNON_ETHERSCAN_API_KEY=${CANNON_ETHERSCAN_API_KEY:-unusedaaaaaaaaaaaaaaaaaaaaaaaaaaaa}

set -e
set -x

cannon verify cow-omnibus:0.1.0@${preset} --chain-id $chainId
