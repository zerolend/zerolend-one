# Solidity API

## IPoolConfigurator

Defines the basic interface for a Pool configurator.

### ReserveBorrowing

```solidity
event ReserveBorrowing(address asset, bool enabled)
```

_Emitted when borrowing is enabled or disabled on a reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if borrowing is enabled, false otherwise |

### ReserveFrozen

```solidity
event ReserveFrozen(address asset, bool frozen)
```

_Emitted when a reserve is frozen or unfrozen_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| frozen | bool | True if reserve is frozen, false otherwise |

### ReserveFactorChanged

```solidity
event ReserveFactorChanged(address asset, uint256 oldReserveFactor, uint256 newReserveFactor)
```

_Emitted when a reserve factor is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldReserveFactor | uint256 | The old reserve factor, expressed in bps |
| newReserveFactor | uint256 | The new reserve factor, expressed in bps |

### BorrowCapChanged

```solidity
event BorrowCapChanged(address asset, uint256 oldBorrowCap, uint256 newBorrowCap)
```

_Emitted when the borrow cap of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldBorrowCap | uint256 | The old borrow cap |
| newBorrowCap | uint256 | The new borrow cap |

### SupplyCapChanged

```solidity
event SupplyCapChanged(address asset, uint256 oldSupplyCap, uint256 newSupplyCap)
```

_Emitted when the supply cap of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldSupplyCap | uint256 | The old supply cap |
| newSupplyCap | uint256 | The new supply cap |

### ReserveInterestRateStrategyChanged

```solidity
event ReserveInterestRateStrategyChanged(address asset, address oldStrategy, address newStrategy)
```

_Emitted when a reserve interest strategy contract is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldStrategy | address | The address of the old interest strategy contract |
| newStrategy | address | The address of the new interest strategy contract |

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

### initRoles

```solidity
function initRoles(address pool, address admin) external
```

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

### setPoolFreeze

```solidity
function setPoolFreeze(address pool, bool freeze) external
```

Freezes the pool reserves. In the frozen state only withdraw and repay can be done

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| freeze | bool | True if protocol needs to be frozen, false otherwise |

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

