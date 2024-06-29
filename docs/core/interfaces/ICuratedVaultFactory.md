# Solidity API

## ICuratedVaultFactory

### VaultCreated

```solidity
event VaultCreated(contract ICuratedVault vault, uint256 index, address creator)
```

### ImplementationUpdated

```solidity
event ImplementationUpdated(address old, address updated, address owner)
```

### createVault

```solidity
function createVault(address initialOwner, address initialProxyOwner, uint256 initialTimelock, address asset, string name, string symbol, bytes32 salt) external returns (contract ICuratedVault pool)
```

### vaults

```solidity
function vaults(uint256 index) external view returns (contract ICuratedVault)
```

### isVault

```solidity
function isVault(address vault) external view returns (bool)
```

### vaultsLength

```solidity
function vaultsLength() external view returns (uint256)
```

### setImplementation

```solidity
function setImplementation(address updated) external
```

