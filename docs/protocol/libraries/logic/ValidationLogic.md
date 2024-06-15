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

### ISOLATED_COLLATERAL_SUPPLIER_ROLE

```solidity
bytes32 ISOLATED_COLLATERAL_SUPPLIER_ROLE
```

_Role identifier for the role allowed to supply isolated reserves as collateral_

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
  address eModePriceSource;
  address siloedBorrowingAddress;
  bool isActive;
  bool isFrozen;
  bool isPaused;
  bool borrowingEnabled;
  bool stableRateBorrowingEnabled;
  bool siloedBorrowingEnabled;
}
```

### validateBorrow

```solidity
function validateBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.ValidateBorrowParams params) internal view
```

Validates a borrow action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.ValidateBorrowParams | Additional params needed for the validation |

### validateRepay

```solidity
function validateRepay(struct DataTypes.ReserveCache reserveCache, uint256 amountSent, enum DataTypes.InterestRateMode interestRateMode, address onBehalfOf, uint256 stableDebt, uint256 variableDebt) internal view
```

Validates a repay action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amountSent | uint256 | The amount sent for the repayment. Can be an actual value or uint(-1) |
| interestRateMode | enum DataTypes.InterestRateMode | The interest rate mode of the debt being repaid |
| onBehalfOf | address | The address of the user msg.sender is repaying for |
| stableDebt | uint256 | The borrow balance of the user |
| variableDebt | uint256 | The borrow balance of the user |

### validateSwapRateMode

```solidity
function validateSwapRateMode(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, struct DataTypes.UserConfigurationMap userConfig, uint256 stableDebt, uint256 variableDebt, enum DataTypes.InterestRateMode currentRateMode) internal view
```

Validates a swap of borrow rate mode.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve state on which the user is swapping the rate |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| userConfig | struct DataTypes.UserConfigurationMap | The user reserves configuration |
| stableDebt | uint256 | The stable debt of the user |
| variableDebt | uint256 | The variable debt of the user |
| currentRateMode | enum DataTypes.InterestRateMode | The rate mode of the debt being swapped |

### validateRebalanceStableBorrowRate

```solidity
function validateRebalanceStableBorrowRate(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, address reserveAddress) internal view
```

Validates a stable borrow rate rebalance action.

_Rebalancing is accepted when depositors are earning <= 90% of their earnings in pure supply/demand market (variable rate only)
For this to be the case, there has to be quite large stable debt with an interest rate below the current variable rate._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve state on which the user is getting rebalanced |
| reserveCache | struct DataTypes.ReserveCache | The cached state of the reserve |
| reserveAddress | address | The address of the reserve |

### validateSetUseReserveAsCollateral

```solidity
function validateSetUseReserveAsCollateral(struct DataTypes.ReserveCache reserveCache, uint256 userBalance) internal pure
```

Validates the action of setting an asset as collateral.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| userBalance | uint256 | The balance of the user |

### validateFlashloan

```solidity
function validateFlashloan(mapping(address => struct DataTypes.ReserveData) reservesData, address[] assets, uint256[] amounts) internal view
```

Validates a flashloan action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| assets | address[] | The assets being flash-borrowed |
| amounts | uint256[] | The amounts for each asset being borrowed |

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
function validateHealthFactor(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address user, uint8 userEModeCategory, uint256 reservesCount, address oracle) internal view returns (uint256, bool)
```

Validates the health factor of a user.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| user | address | The user to validate health factor of |
| userEModeCategory | uint8 | The users active efficiency mode category |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

### validateHFAndLtv

```solidity
function validateHFAndLtv(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address asset, address from, uint256 reservesCount, address oracle, uint8 userEModeCategory) internal view
```

Validates the health factor of a user and the ltv of the asset being withdrawn.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| asset | address | The asset for which the ltv will be validated |
| from | address | The user from which the aTokens are being transferred |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |
| userEModeCategory | uint8 | The users active efficiency mode category |

### validateTransfer

```solidity
function validateTransfer(struct DataTypes.ReserveData reserve) internal view
```

Validates a transfer action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

### validateDropReserve

```solidity
function validateDropReserve(mapping(uint256 => address) reservesList, struct DataTypes.ReserveData reserve, address asset) internal view
```

Validates a drop reserve action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| reserve | struct DataTypes.ReserveData | The reserve object |
| asset | address | The address of the reserve's underlying asset |

### validateSetUserEMode

```solidity
function validateSetUserEMode(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, uint256 reservesCount, uint8 categoryId) internal view
```

Validates the action of setting efficiency mode.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | a mapping storing configurations for all efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reservesCount | uint256 | The total number of valid reserves |
| categoryId | uint8 | The id of the category |

### validateUseAsCollateral

```solidity
function validateUseAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveConfigurationMap reserveConfig) internal view returns (bool)
```

Validates the action of activating the asset as collateral.

_Only possible if the asset has non-zero LTV and the user is not in isolation mode_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reserveConfig | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the asset can be activated as collateral, false otherwise |

### validateAutomaticUseAsCollateral

```solidity
function validateAutomaticUseAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveConfigurationMap reserveConfig, address aTokenAddress) internal view returns (bool)
```

Validates if an asset should be automatically activated as collateral in the following actions: supply,
transfer, mint unbacked, and liquidate

_This is used to ensure that isolated assets are not enabled as collateral automatically_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reserveConfig | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| aTokenAddress | address |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the asset can be activated as collateral, false otherwise |

