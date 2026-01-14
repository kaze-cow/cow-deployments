# CoW Protocol Deployments

This repository contains [Cannon](https://usecannon.com/) deployment configurations for CoW Protocol contracts, including the settlement layer, fee mechanisms, and auxiliary contracts.

## Prerequisites

- Node.js (v18 or later recommended)
- pnpm (the package manager used by this project)

## Installing Dependencies

Install the required dependencies using pnpm:

```bash
pnpm install
```

This will install [Cannon CLI](https://usecannon.com/learn/cli) and its dependencies, which are used to build and deploy smart contracts.

## Configuration Files

Deployment configurations are defined in TOML files:

- `<chain id>-<preset>.toml` - network deployment configuration. For example, `1-main.toml` is the mainnet deployment on `main` (production) preset.
- `shared/*.toml` - frequently reused configurations that can be `include`d into the top level network configurations.

Each configuration specifies which contracts to deploy, their versions, and initialization parameters.

## Using `demo.sh` - Network Build (Dry Run)

The `demo.sh` script performs a **dry-run deployment** simulation without actually sending transactions. This is useful for testing your deployment configuration.

### Usage

```bash
./demo.sh <chain-id> <preset>
```

Note that the corresponding `.toml` file must exist in the repository to work.

### Parameters

- `<chain-id>` - The blockchain network ID (e.g., `10` for Optimism mainnet, `1` for Ethereum mainnet)
- `<preset>` - The configuration preset name (e.g., `main` for `57073-main.toml`)

### Example

```bash
./demo.sh 1 main
```

This will simulate a deployment of the CoW Protocol contracts to the mainnet network using the configuration in `1-main.toml`, without making any actual changes on-chain.

### Environment Variables

- `RPC_URL` (optional) - JSON-RPC endpoint URL. If not set, a public RPC URL in the viem database will be used
- `CANNON` (optional) - Command to execute Cannon CLI, defaults to `pnpm cannon`
- `CANNON_ARGS` (optional) - Additional arguments to pass to Cannon

## Using `deploy.sh` - Actual Deployment

The `deploy.sh` script performs the **actual deployment** of contracts to the specified network.

### Usage

```bash
./deploy.sh <chain-id> <preset>
```

### Parameters

- `<chain-id>` - The blockchain network ID
- `<preset>` - The configuration preset name

### Example

```bash
./deploy.sh 57073 main
```

This will deploy the CoW Protocol contracts to the INK network using the configuration in `57073-main.toml`.


### Prerequisites for Deployment

- Private key or hardware wallet access for signing transactions. The private key will be asked via standard input at the beginning of deployment. For CoW network deployments, this can generally be any private key with gas token.
- Sufficient native token balance to cover gas fees
- (reccomended) Proper `RPC_URL` configured to connect to the target network

### Environment Variables

Same as `demo.sh`

## Using `verify.sh` - Etherscan Verification

The `verify.sh` script verifies deployed contracts on Etherscan-compatible block explorers.

### Usage

```bash
./verify.sh <chain-id> <preset>
```

### Parameters

- `<chain-id>` - The blockchain network ID
- `<preset>` - The configuration preset name

### Example

```bash
./verify.sh 57073 main
```

This will verify the contracts deployed using the `57073-main` configuration on the explorer for that network.

### Verification Details

- Verifies the `cow-omnibus:0.1.0` deployment (built by the toml files) against the specified chain-id preset
- Uses the Explorer API configured for the target network
- For INK network, uses `https://explorer.inkonchain.com/api`

### Environment Variables

- `CANNON_ETHERSCAN_API_KEY` (optional) - API key for the block explorer. Defaults to a dummy value that may be acceptable on some block explorers
- `CANNON_ETHERSCAN_API_URL` (optional) - API URL for the block explorer. Defaults to the default URL recongized by viem.

## Typical Workflow

1. **Test your configuration** with a dry run:
   ```bash
   ./demo.sh 57073 main
   ```

2. **Deploy to the network** (once confident):
   ```bash
   RPC_URL=https://your-rpc-endpoint ./deploy.sh 57073 main
   ```

3. **Verify contracts** on the explorer:
   ```bash
   ./verify.sh 57073 main
   ```

## Troubleshooting

- **"Usage: ./demo.sh \<chain id\> \<preset\>"** - You forgot to provide both required arguments
- **RPC connection errors** - Check your `RPC_URL` environment variable and network connectivity
- **Dry run succeeds but deploy fails** - Verify you have sufficient balance and proper signing setup
- **Verification fails** - Ensure the contracts were successfully deployed before attempting verification

## References

- [Cannon Documentation](https://usecannon.com/learn)
- [CoW Protocol](https://cow.fi/)
