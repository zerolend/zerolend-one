# Solidity API

## ValidationLogic

Implements functions to validate the different actions of the protocol

### REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD

```solidity
uint256 REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD
```

### MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

### HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

_Minimum health factor to consider a user position healthy
A value of 1e18 results in 1_

### validateSupply

```solidity
function validateSupply(struct DataTypes.ReserveCache reserveCache, struct DataTypes.ReserveData reserve, struct DataTypes.ExecuteSupplyParams params, address pool) internal view
```

Validates a supply action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| reserve | struct DataTypes.ReserveData |  |
| params | struct DataTypes.ExecuteSupplyParams | The amount to be supplied |
| pool | address |  |

### validateWithdraw

```solidity
function validateWithdraw(uint256 amount, uint256 userBalance) internal pure
```

Validates a withdraw action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount to be withdrawn |
| userBalance | uint256 | The balance of the user |

### ValidateBorrowLocalVars

```solidity
struct ValidateBorrowLocalVars {
  uint256 currentLtv;
  uint256 collateralNeededInBaseCurrency;
  uint256 userCollateralInBaseCurrency;
  uint256 userDebtInBaseCurrency;
  uint256 availableLiquidity;
  uint256 healthFactor;
  uint256 totalDebt;
  uint256 totalSupplyVariableDebt;
  uint256 reserveDecimals;
  uint256 borrowCap;
  uint256 amountInBaseCurrency;
  uint256 assetUnit;
  bool isFrozen;
  bool borrowingEnabled;
}
```

### validateBorrow

```solidity
function validateBorrow(mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.ValidateBorrowParams params) internal view
```

Validates a borrow action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.ValidateBorrowParams | Additional params needed for the validation |

### validateRepay

```solidity
function validateRepay(uint256 amountSent, uint256 variableDebt) internal pure
```

Validates a repay action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amountSent | uint256 | The amount sent for the repayment. Can be an actual value or uint(-1) |
| variableDebt | uint256 | The borrow balance of the user |

### validateFlashloanSimple

```solidity
function validateFlashloanSimple(struct DataTypes.ReserveData reserve) internal view
```

Validates a flashloan action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the reserve |

### ValidateLiquidationCallLocalVars

```solidity
struct ValidateLiquidationCallLocalVars {
  bool collateralReserveActive;
  bool collateralReservePaused;
  bool principalReserveActive;
  bool principalReservePaused;
  bool isCollateralEnabled;
}
```

### validateLiquidationCall

```solidity
function validateLiquidationCall(struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveData collateralReserve, struct DataTypes.ValidateLiquidationCallParams params) internal view
```

Validates the liquidation action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping |
| collateralReserve | struct DataTypes.ReserveData | The reserve data of the collateral |
| params | struct DataTypes.ValidateLiquidationCallParams | Additional parameters needed for the validation |

### validateHealthFactor

```solidity
function validateHealthFactor(mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, bytes32 position, uint256 reservesCount, address oracle) internal view returns (uint256, bool)
```

Validates the health factor of a user.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| position | bytes32 | The user to validate health factor of |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

### validateHFAndLtv

```solidity
function validateHFAndLtv(mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteWithdrawParams params) internal view
```

Validates the health factor of a user and the ltv of the asset being withdrawn.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| params | struct DataTypes.ExecuteWithdrawParams | The params to calculate HF and Ltv for |

### validateUseAsCollateral

```solidity
function validateUseAsCollateral(struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveConfigurationMap reserveConfig) internal view returns (bool)
```

Validates the action of activating the asset as collateral.

_Only possible if the asset has non-zero LTV and the user is not in isolation mode_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reserveConfig | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the asset can be activated as collateral, false otherwise |

