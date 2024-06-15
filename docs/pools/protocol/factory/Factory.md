# Solidity API

## Factory

### getPool

```solidity
mapping(address => mapping(address => address)) getPool
```

### allPools

```solidity
address[] allPools
```

### implementation

```solidity
address implementation
```

_Must return an address that can be used as a delegate call target.

{BeaconProxy} will check that this address is a contract._

### PoolCreated

```solidity
event PoolCreated(address pool, uint256 index, address creator)
```

### ImplementationUpdated

```solidity
event ImplementationUpdated(address oldImpl, address newImpl, address owner)
```

### constructor

```solidity
constructor(address impl) public
```

### poolsLength

```solidity
function poolsLength() external view returns (uint256)
```

### createPool

```solidity
function createPool(bytes _data) external returns (address pool)
```

### setImplementation

```solidity
function setImplementation(address impl) public
```

