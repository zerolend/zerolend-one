# Solidity API

## IPoolConfigurator

Defines the basic interface for a Pool configurator.

### ReserveInitialized

```solidity
event ReserveInitialized(address asset, address aToken, address variableDebtToken, address interestRateStrategyAddress)
```

_Emitted when a reserve is initialized._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| aToken | address | The address of the associated aToken contract |
| variableDebtToken | address | The address of the associated variable rate debt token |
| interestRateStrategyAddress | address | The address of the interest rate strategy for the reserve |

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

### ReserveFlashLoaning

```solidity
event ReserveFlashLoaning(address asset, bool enabled)
```

_Emitted when flashloans are enabled or disabled on a reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if flashloans are enabled, false otherwise |

### CollateralConfigurationChanged

```solidity
event CollateralConfigurationChanged(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus)
```

_Emitted when the collateralization risk parameters for the specified asset are updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| ltv | uint256 | The loan to value of the asset when used as collateral |
| liquidationThreshold | uint256 | The threshold at which loans using this asset as collateral will be considered undercollateralized |
| liquidationBonus | uint256 | The bonus liquidators receive to liquidate this asset |

### ReserveActive

```solidity
event ReserveActive(address asset, bool active)
```

_Emitted when a reserve is activated or deactivated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| active | bool | True if reserve is active, false otherwise |

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

### ReservePaused

```solidity
event ReservePaused(address asset, bool paused)
```

_Emitted when a reserve is paused or unpaused_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| paused | bool | True if reserve is paused, false otherwise |

### ReserveDropped

```solidity
event ReserveDropped(address asset)
```

_Emitted when a reserve is dropped._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

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

### LiquidationProtocolFeeChanged

```solidity
event LiquidationProtocolFeeChanged(address asset, uint256 oldFee, uint256 newFee)
```

_Emitted when the liquidation protocol fee of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldFee | uint256 | The old liquidation protocol fee, expressed in bps |
| newFee | uint256 | The new liquidation protocol fee, expressed in bps |

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

### ATokenUpgraded

```solidity
event ATokenUpgraded(address asset, address proxy, address implementation)
```

_Emitted when an aToken implementation is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| proxy | address | The aToken proxy address |
| implementation | address | The new aToken implementation |

### VariableDebtTokenUpgraded

```solidity
event VariableDebtTokenUpgraded(address asset, address proxy, address implementation)
```

_Emitted when the implementation of a variable debt token is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| proxy | address | The variable debt token proxy address |
| implementation | address | The new aToken implementation |

### DebtCeilingChanged

```solidity
event DebtCeilingChanged(address asset, uint256 oldDebtCeiling, uint256 newDebtCeiling)
```

_Emitted when the debt ceiling of an asset is set._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldDebtCeiling | uint256 | The old debt ceiling |
| newDebtCeiling | uint256 | The new debt ceiling |

### BridgeProtocolFeeUpdated

```solidity
event BridgeProtocolFeeUpdated(uint256 oldBridgeProtocolFee, uint256 newBridgeProtocolFee)
```

_Emitted when the bridge protocol fee is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldBridgeProtocolFee | uint256 | The old protocol fee, expressed in bps |
| newBridgeProtocolFee | uint256 | The new protocol fee, expressed in bps |

### FlashloanPremiumTotalUpdated

```solidity
event FlashloanPremiumTotalUpdated(uint128 oldFlashloanPremiumTotal, uint128 newFlashloanPremiumTotal)
```

_Emitted when the total premium on flashloans is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldFlashloanPremiumTotal | uint128 | The old premium, expressed in bps |
| newFlashloanPremiumTotal | uint128 | The new premium, expressed in bps |

### FlashloanPremiumToProtocolUpdated

```solidity
event FlashloanPremiumToProtocolUpdated(uint128 oldFlashloanPremiumToProtocol, uint128 newFlashloanPremiumToProtocol)
```

_Emitted when the part of the premium that goes to protocol is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldFlashloanPremiumToProtocol | uint128 | The old premium, expressed in bps |
| newFlashloanPremiumToProtocol | uint128 | The new premium, expressed in bps |

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

### configureReserveAsCollateral

```solidity
function configureReserveAsCollateral(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus) external
```

Configures the reserve collateralization parameters.

_All the values are expressed in bps. A value of 10000, results in 100.00%
The `liquidationBonus` is always above 100%. A value of 105% means the liquidator will receive a 5% bonus_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| ltv | uint256 | The loan to value of the asset when used as collateral |
| liquidationThreshold | uint256 | The threshold at which loans using this asset as collateral will be considered undercollateralized |
| liquidationBonus | uint256 | The bonus liquidators receive to liquidate this asset |

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

### setReserveFactor

```solidity
function setReserveFactor(address pool, address asset, uint256 newReserveFactor) external
```

Updates the reserve factor of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| newReserveFactor | uint256 | The new reserve factor of the reserve |

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

