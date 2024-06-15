# Solidity API

## BlastPool

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) public
```

### init

```solidity
function init(contract IPoolAddressesProvider provider) external virtual
```

### claimGas

```solidity
function claimGas(address whom, address to) external
```

### claimERC20yields

```solidity
function claimERC20yields(address token, address dest) external
```

### compoundYields

```solidity
function compoundYields(address reserve) external
```

