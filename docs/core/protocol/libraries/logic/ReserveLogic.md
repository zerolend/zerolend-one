# Solidity API

## ReserveLogic

Implements the logic to update the reserves state

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

### getNormalizedIncome

```solidity
function getNormalizedIncome(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized income for the reserve.

_A value of 1e27 means there is no income. As time passes, the income is accrued
A value of 2*1e27 means for each unit of asset one unit of income has been accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized income, expressed in ray |

### getNormalizedDebt

```solidity
function getNormalizedDebt(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized variable debt for the reserve.

_A value of 1e27 means there is no debt. As time passes, the debt is accrued
A value of 2*1e27 means that for each unit of debt, one unit worth of interest has been accumulated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized variable debt, expressed in ray |

### updateState

```solidity
function updateState(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the liquidity cumulative index and the variable borrow index.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### cumulateToLiquidityIndex

```solidity
function cumulateToLiquidityIndex(struct DataTypes.ReserveData reserve, uint256 totalLiquidity, uint256 amount) internal returns (uint256)
```

Accumulates a predefined amount of asset to the reserve as a fixed, instantaneous income. Used for example
to accumulate the flashloan fee to the reserve, and spread it between all the suppliers.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| totalLiquidity | uint256 | The total liquidity available in the reserve |
| amount | uint256 | The amount to accumulate |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The next liquidity index of the reserve |

### init

```solidity
function init(struct DataTypes.ReserveData reserve, address interestRateStrategyAddress) internal
```

Initializes a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### UpdateInterestRatesLocalVars

```solidity
struct UpdateInterestRatesLocalVars {
  uint256 nextLiquidityRate;
  uint256 nextVariableRate;
  uint256 totalVariableDebt;
}
```

### updateInterestRates

```solidity
function updateInterestRates(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, address reserveAddress, uint256 reserveFactor, uint256 liquidityAdded, uint256 liquidityTaken, bytes32 position, bytes data) internal
```

Updates the current variable borrow rate and the current liquidity rate.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |
| reserveAddress | address | The address of the reserve to be updated |
| reserveFactor | uint256 |  |
| liquidityAdded | uint256 | The amount of liquidity added to the protocol (supply or repay) in the previous action |
| liquidityTaken | uint256 | The amount of liquidity taken from the protocol (redeem or borrow) |
| position | bytes32 |  |
| data | bytes |  |

### AccrueToTreasuryLocalVars

```solidity
struct AccrueToTreasuryLocalVars {
  uint256 prevTotalVariableDebt;
  uint256 currTotalVariableDebt;
  uint256 totalDebtAccrued;
  uint256 amountToMint;
}
```

### _accrueToTreasury

```solidity
function _accrueToTreasury(uint256 reserveFactor, struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Mints part of the repaid interest to the reserve treasury as a function of the reserve factor for the
specific asset.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveFactor | uint256 |  |
| reserve | struct DataTypes.ReserveData | The reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### _updateIndexes

```solidity
function _updateIndexes(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the reserve indexes and the timestamp of the update.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The cache layer holding the cached protocol data |

### cache

```solidity
function cache(struct DataTypes.ReserveData reserve) internal view returns (struct DataTypes.ReserveCache)
```

Creates a cache object to avoid repeated storage reads and external contract calls when updating state and
interest rates.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object for which the cache will be filled |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveCache | The cache object |

