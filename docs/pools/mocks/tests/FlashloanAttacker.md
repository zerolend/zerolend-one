# Solidity API

## FlashloanAttacker

### _provider

```solidity
contract IPoolAddressesProvider _provider
```

### _pool

```solidity
contract IPool _pool
```

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) public
```

### supplyAsset

```solidity
function supplyAsset(address asset, uint256 amount) public
```

### _innerBorrow

```solidity
function _innerBorrow(address asset) internal
```

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address, bytes) public returns (bool)
```

