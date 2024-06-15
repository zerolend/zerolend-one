# Solidity API

## LiquidationLogic

Implements actions involving management of collateral in the protocol, the main one being the liquidations

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, bytes32 position)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, bytes32 position)
```

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, bytes32 user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator)
```

### DEFAULT_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 DEFAULT_LIQUIDATION_CLOSE_FACTOR
```

_Default percentage of borrower's debt to be repaid in a liquidation.
Percentage applied when the users health factor is above `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 0.5e4 results in 50.00%_

### MAX_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 MAX_LIQUIDATION_CLOSE_FACTOR
```

_Maximum percentage of borrower's debt to be repaid in a liquidation
Percentage applied when the users health factor is below `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 1e4 results in 100.00%_

### CLOSE_FACTOR_HF_THRESHOLD

```solidity
uint256 CLOSE_FACTOR_HF_THRESHOLD
```

_This constant represents below which health factor value it is possible to liquidate
an amount of debt corresponding to `MAX_LIQUIDATION_CLOSE_FACTOR`.
A value of 0.95e18 results in 0.95_

### LiquidationCallLocalVars

```solidity
struct LiquidationCallLocalVars {
  uint256 userCollateralBalance;
  uint256 userVariableDebt;
  uint256 userTotalDebt;
  uint256 actualDebtToLiquidate;
  uint256 actualCollateralToLiquidate;
  uint256 liquidationBonus;
  uint256 healthFactor;
  uint256 liquidationProtocolFeeAmount;
  address collateralPriceSource;
  address debtPriceSource;
  address asset;
  struct DataTypes.ReserveCache debtReserveCache;
}
```

### executeLiquidationCall

```solidity
function executeLiquidationCall(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(address => mapping(bytes32 => uint256)) _balances, mapping(bytes32 => struct DataTypes.UserConfigurationMap) usersConfig, struct DataTypes.ExecuteLiquidationCallParams params) external
```

Function to liquidate a position if its Health Factor drops below 1. The caller (liquidator)
covers `debtToCover` amount of debt of the user getting liquidated, and receives
a proportional amount of the `collateralAsset` plus a bonus to cover market risk

_Emits the `LiquidationCall()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; uint256)) |  |
| usersConfig | mapping(bytes32 &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |

### _burnCollateralATokens

```solidity
function _burnCollateralATokens(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the collateral aTokens and transfers the underlying to the liquidator.

_The function also updates the state and the interest rate of the collateral reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | The executeLiquidationCall() function local vars |

### _burnDebtTokens

```solidity
function _burnDebtTokens(struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the debt tokens of the user up to the amount being repaid by the liquidator.

_The function alters the `debtReserveCache` state in `vars` to update the debt related data._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | the executeLiquidationCall() function local vars |

### _calculateDebt

```solidity
function _calculateDebt(struct DataTypes.ReserveCache debtReserveCache, struct DataTypes.ExecuteLiquidationCallParams params, uint256 healthFactor) internal view returns (uint256, uint256, uint256)
```

Calculates the total debt of the user and the actual amount to liquidate depending on the health factor
and corresponding close factor.

_If the Health Factor is below CLOSE_FACTOR_HF_THRESHOLD, the close factor is increased to MAX_LIQUIDATION_CLOSE_FACTOR_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| debtReserveCache | struct DataTypes.ReserveCache | The reserve cache data object of the debt reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| healthFactor | uint256 | The health factor of the position |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable debt of the user |
| [1] | uint256 | The total debt of the user |
| [2] | uint256 | The actual debt to liquidate as a function of the closeFactor |

### AvailableCollateralToLiquidateLocalVars

```solidity
struct AvailableCollateralToLiquidateLocalVars {
  uint256 collateralPrice;
  uint256 debtAssetPrice;
  uint256 maxCollateralToLiquidate;
  uint256 baseCollateral;
  uint256 bonusCollateral;
  uint256 debtAssetDecimals;
  uint256 collateralDecimals;
  uint256 collateralAssetUnit;
  uint256 debtAssetUnit;
  uint256 collateralAmount;
  uint256 debtAmountNeeded;
  uint256 liquidationProtocolFeePercentage;
  uint256 liquidationProtocolFee;
}
```

### _calculateAvailableCollateralToLiquidate

```solidity
function _calculateAvailableCollateralToLiquidate(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ReserveCache debtReserveCache, address collateralAsset, address debtAsset, uint256 debtToCover, uint256 userCollateralBalance, uint256 liquidationBonus, uint256 collateralPrice, uint256 debtAssetPrice) internal view returns (uint256, uint256, uint256)
```

Calculates how much of a specific collateral can be liquidated, given
a certain amount of debt asset.

_This function needs to be called after all the checks to validate the liquidation have been performed,
  otherwise it might fail._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| debtReserveCache | struct DataTypes.ReserveCache | The cached data of the debt reserve |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| userCollateralBalance | uint256 | The collateral balance for the specific `collateralAsset` of the user being liquidated |
| liquidationBonus | uint256 | The collateral bonus percentage to receive as result of the liquidation |
| collateralPrice | uint256 |  |
| debtAssetPrice | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum amount that is possible to liquidate given all the liquidation constraints (user balance, close factor) |
| [1] | uint256 | The amount to repay with the liquidation |
| [2] | uint256 | The fee taken from the liquidation bonus amount to be paid to the protocol |

