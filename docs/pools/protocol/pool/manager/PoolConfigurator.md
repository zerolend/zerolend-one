# Solidity API

## PoolConfigurator

_Implements the configuration methods for the Aave protocol_

### initReserves

```solidity
function initReserves(address pool, struct ConfiguratorInputTypes.InitReserveInput[] input) external
```

Initializes multiple reserves.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| input | struct ConfiguratorInputTypes.InitReserveInput[] | The array of initialization parameters |

### setReserveBorrowing

```solidity
function setReserveBorrowing(address pool, address asset, bool enabled) external
```

Configures borrowing on a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if borrowing needs to be enabled, false otherwise |

### setReserveFreeze

```solidity
function setReserveFreeze(address pool, address asset, bool freeze) external
```

Freeze or unfreeze a reserve. A frozen reserve doesn't allow any new supply, borrow
or rate swap but allows repayments, liquidations, rate rebalances and withdrawals.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| freeze | bool | True if the reserve needs to be frozen, false otherwise |

### setBorrowCap

```solidity
function setBorrowCap(address pool, address asset, uint256 newBorrowCap) external
```

Updates the borrow cap of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| newBorrowCap | uint256 | The new borrow cap of the reserve |

### setSupplyCap

```solidity
function setSupplyCap(address pool, address asset, uint256 newSupplyCap) external
```

Updates the supply cap of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| newSupplyCap | uint256 | The new supply cap of the reserve |

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address pool, address asset, address newRateStrategyAddress) external
```

Sets the interest rate strategy of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| newRateStrategyAddress | address | The address of the new interest strategy contract |

