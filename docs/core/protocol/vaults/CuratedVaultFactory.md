# Solidity API

## CuratedVaultFactory

### implementation

```solidity
address implementation
```

_Must return an address that can be used as a delegate call target.

{BeaconProxy} will check that this address is a contract._

### vaults

```solidity
contract ICuratedVault[] vaults
```

### isVault

```solidity
mapping(address => bool) isVault
```

### constructor

```solidity
constructor(address _implementation) public
```

### vaultsLength

```solidity
function vaultsLength() external view returns (uint256)
```

### createVault

```solidity
function createVault(address initialOwner, address initialProxyOwner, uint256 initialTimelock, address asset, string name, string symbol, bytes32 salt) external returns (contract ICuratedVault pool)
```

### setImplementation

```solidity
function setImplementation(address impl) external
```

