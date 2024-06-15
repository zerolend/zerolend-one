# Solidity API

## PoolConfigurator

_Implements the configuration methods for the Aave protocol_

### initReserves

```solidity
function initReserves(address pool, struct ConfiguratorInputTypes.InitReserveInput[] input) external
```

### setReserveBorrowing

```solidity
function setReserveBorrowing(address pool, address asset, bool enabled) external
```

### configureReserveAsCollateral

```solidity
function configureReserveAsCollateral(address pool, address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus) external
```

### setReserveFreeze

```solidity
function setReserveFreeze(address pool, address asset, bool freeze) external
```

### setReserveFactor

```solidity
function setReserveFactor(address pool, address asset, uint256 newReserveFactor) external
```

### setBorrowCap

```solidity
function setBorrowCap(address pool, address asset, uint256 newBorrowCap) external
```

### setSupplyCap

```solidity
function setSupplyCap(address pool, address asset, uint256 newSupplyCap) external
```

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address pool, address asset, address newRateStrategyAddress) external
```

