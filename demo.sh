#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <chain id> <preset>"
    exit 1
fi

chainId=$1
preset=$2

CANNON=${CANNON:-pnpm cannon}

if [[ "${RPC_URL}" != "" ]] then
    RPC_SETTING="--rpc-url ${RPC_URL}"
fi

set -e
set -x

$CANNON build ${chainId}-${preset}.toml --chain-id ${chainId} $RPC_SETTING --dry-run --impersonate-all --keep-alive --anvil.port 8545 $CANNON_ARGS
