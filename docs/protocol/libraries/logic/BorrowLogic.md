# Solidity API

## BorrowLogic

Implements the base logic for all the actions related to borrowing

### Borrow

```solidity
event Borrow(address reserve, address user, address onBehalfOf, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 borrowRate, uint16 referralCode)
```

### Repay

```solidity
event Repay(address reserve, address user, address repayer, uint256 amount, bool useATokens)
```

### RebalanceStableBorrowRate

```solidity
event RebalanceStableBorrowRate(address reserve, address user)
```

### SwapBorrowRateMode

```solidity
event SwapBorrowRateMode(address reserve, address user, enum DataTypes.InterestRateMode interestRateMode)
```

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### executeBorrow

```solidity
function executeBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteBorrowParams params) public
```

Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
Aave protocol proportionally to their collateralization power. For isolated positions, it also increases the
isolated debt.

_Emits the `Borrow()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteBorrowParams | The additional parameters needed to execute the borrow function |

### executeRepay

```solidity
function executeRepay(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteRepayParams params) external returns (uint256)
```

Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
equivalent amount of debt for the user by burning the corresponding debt token. For isolated positions, it also
reduces the isolated debt.

_Emits the `Repay()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteRepayParams | The additional parameters needed to execute the repay function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount being repaid |

### executeRebalanceStableBorrowRate

```solidity
function executeRebalanceStableBorrowRate(struct DataTypes.ReserveData reserve, address asset, address user) external
```

Implements the rebalance stable borrow rate feature. In case of liquidity crunches on the protocol, stable
rate borrows might need to be rebalanced to bring back equilibrium between the borrow and supply APYs.

_The rules that define if a position can be rebalanced are implemented in `ValidationLogic.validateRebalanceStableBorrowRate()`
Emits the `RebalanceStableBorrowRate()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the reserve of the asset being repaid |
| asset | address | The asset of the position being rebalanced |
| user | address | The user being rebalanced |

### executeSwapBorrowRateMode

```solidity
function executeSwapBorrowRateMode(struct DataTypes.ReserveData reserve, struct DataTypes.UserConfigurationMap userConfig, address asset, enum DataTypes.InterestRateMode interestRateMode) external
```

Implements the swap borrow rate feature. Borrowers can swap from variable to stable positions at any time.

_Emits the `Swap()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The of the reserve of the asset being repaid |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| asset | address | The asset of the position being swapped |
| interestRateMode | enum DataTypes.InterestRateMode | The current interest rate mode of the position being swapped |

