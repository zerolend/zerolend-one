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
function validateSupply(struct DataTypes.ReserveCache reserveCache, struct DataTypes.ReserveData reserve, uint256 amount) internal view
```

Validates a supply action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| reserve | struct DataTypes.ReserveData |  |
| amount | uint256 | The amount to be supplied |

### validateWithdraw

```solidity
function validateWithdraw(struct DataTypes.ReserveCache reserveCache, uint256 amount, uint256 userBalance) internal pure
```

Validates a withdraw action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
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
  bool isActive;
  bool isFrozen;
  bool isPaused;
  bool borrowingEnabled;
}
```

### validateBorrow

```solidity
function validateBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.ValidateBorrowParams params) internal view
```

Validates a borrow action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.ValidateBorrowParams | Additional params needed for the validation |

### validateRepay

```solidity
function validateRepay(struct DataTypes.ReserveCache reserveCache, uint256 amountSent, bytes32 onBehalfOfPosition, uint256 variableDebt) internal view
```

Validates a repay action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amountSent | uint256 | The amount sent for the repayment. Can be an actual value or uint(-1) |
| onBehalfOfPosition | bytes32 | The address of the user msg.sender is repaying for |
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
function validateHealthFactor(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, bytes32 position, uint256 reservesCount, address oracle) internal view returns (uint256, bool)
```

Validates the health factor of a user.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| position | bytes32 | The user to validate health factor of |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

### validateHFAndLtv

```solidity
function validateHFAndLtv(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, address asset, bytes32 fromPosition, uint256 reservesCount, address oracle) internal view
```

Validates the health factor of a user and the ltv of the asset being withdrawn.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| asset | address | The asset for which the ltv will be validated |
| fromPosition | bytes32 | The user from which the aTokens are being transferred |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

