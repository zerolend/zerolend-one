# Solidity API

## PoolStorage

Contract used as storage of the Pool contract.

_It defines the storage layout of the Pool contract._

### _reserves

```solidity
mapping(address => struct DataTypes.ReserveData) _reserves
```

### _usersConfig

```solidity
mapping(bytes32 => struct DataTypes.UserConfigurationMap) _usersConfig
```

### _balances

```solidity
mapping(address => mapping(bytes32 => uint256)) _balances
```

### _debts

```solidity
mapping(address => mapping(bytes32 => uint256)) _debts
```

### _totalSupplies

```solidity
mapping(address => uint256) _totalSupplies
```

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

### _flashLoanPremiumTotal

```solidity
uint128 _flashLoanPremiumTotal
```

### _reservesCount

```solidity
uint16 _reservesCount
```

### _assetsSources

```solidity
mapping(address => contract IAggregatorInterface) _assetsSources
```

### configurator

```solidity
address configurator
```

