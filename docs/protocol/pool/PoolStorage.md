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
mapping(address => struct DataTypes.UserConfigurationMap) _usersConfig
```

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

### _eModeCategories

```solidity
mapping(uint8 => struct DataTypes.EModeCategory) _eModeCategories
```

### _usersEModeCategory

```solidity
mapping(address => uint8) _usersEModeCategory
```

### _bridgeProtocolFee

```solidity
uint256 _bridgeProtocolFee
```

### _flashLoanPremiumTotal

```solidity
uint128 _flashLoanPremiumTotal
```

### _flashLoanPremiumToProtocol

```solidity
uint128 _flashLoanPremiumToProtocol
```

### _maxStableRateBorrowSizePercent

```solidity
uint64 _maxStableRateBorrowSizePercent
```

### _reservesCount

```solidity
uint16 _reservesCount
```

