# Solidity API

## MockReserveConfiguration

### configuration

```solidity
struct DataTypes.ReserveConfigurationMap configuration
```

### setLtv

```solidity
function setLtv(uint256 ltv) external
```

### getLtv

```solidity
function getLtv() external view returns (uint256)
```

### setLiquidationBonus

```solidity
function setLiquidationBonus(uint256 bonus) external
```

### getLiquidationBonus

```solidity
function getLiquidationBonus() external view returns (uint256)
```

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(uint256 threshold) external
```

### getLiquidationThreshold

```solidity
function getLiquidationThreshold() external view returns (uint256)
```

### setDecimals

```solidity
function setDecimals(uint256 decimals) external
```

### getDecimals

```solidity
function getDecimals() external view returns (uint256)
```

### setFrozen

```solidity
function setFrozen(bool frozen) external
```

### getFrozen

```solidity
function getFrozen() external view returns (bool)
```

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(bool enabled) external
```

### getBorrowingEnabled

```solidity
function getBorrowingEnabled() external view returns (bool)
```

### setBorrowCap

```solidity
function setBorrowCap(uint256 borrowCap) external
```

### getBorrowCap

```solidity
function getBorrowCap() external view returns (uint256)
```

### setSupplyCap

```solidity
function setSupplyCap(uint256 supplyCap) external
```

### getSupplyCap

```solidity
function getSupplyCap() external view returns (uint256)
```

### getFlags

```solidity
function getFlags() external view returns (bool, bool, bool)
```

### getParams

```solidity
function getParams() external view returns (uint256, uint256, uint256, uint256, uint256)
```

