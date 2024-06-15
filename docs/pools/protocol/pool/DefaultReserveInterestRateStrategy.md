# Solidity API

## DefaultReserveInterestRateStrategy

Implements the calculation of the interest rates depending on the reserve state

_The model of interest rate is based on 2 slopes, one before the `OPTIMAL_USAGE_RATIO`
point of usage and another from that one to 100%.
- An instance of this same contract, can't be used across different Aave markets, due to the caching
  of the PoolAddressesProvider_

### OPTIMAL_USAGE_RATIO

```solidity
uint256 OPTIMAL_USAGE_RATIO
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### MAX_EXCESS_USAGE_RATIO

```solidity
uint256 MAX_EXCESS_USAGE_RATIO
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### _baseVariableBorrowRate

```solidity
uint256 _baseVariableBorrowRate
```

### _variableRateSlope1

```solidity
uint256 _variableRateSlope1
```

### _variableRateSlope2

```solidity
uint256 _variableRateSlope2
```

### constructor

```solidity
constructor(uint256 optimalUsageRatio, uint256 baseVariableBorrowRate, uint256 variableRateSlope1, uint256 variableRateSlope2) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| optimalUsageRatio | uint256 | The optimal usage ratio |
| baseVariableBorrowRate | uint256 | The base variable borrow rate |
| variableRateSlope1 | uint256 | The variable rate slope below optimal usage ratio |
| variableRateSlope2 | uint256 | The variable rate slope above optimal usage ratio |

### getVariableRateSlope1

```solidity
function getVariableRateSlope1() external view returns (uint256)
```

Returns the variable rate slope below optimal usage ratio

_It's the variable rate when usage ratio > 0 and <= OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getVariableRateSlope2

```solidity
function getVariableRateSlope2() external view returns (uint256)
```

Returns the variable rate slope above optimal usage ratio

_It's the variable rate when usage ratio > OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getBaseVariableBorrowRate

```solidity
function getBaseVariableBorrowRate() external view returns (uint256)
```

Returns the base variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The base variable borrow rate, expressed in ray |

### getMaxVariableBorrowRate

```solidity
function getMaxVariableBorrowRate() external view returns (uint256)
```

Returns the maximum variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum variable borrow rate, expressed in ray |

### CalcInterestRatesLocalVars

```solidity
struct CalcInterestRatesLocalVars {
  uint256 availableLiquidity;
  uint256 totalDebt;
  uint256 currentVariableBorrowRate;
  uint256 currentLiquidityRate;
  uint256 borrowUsageRatio;
  uint256 supplyUsageRatio;
  uint256 availableLiquidityPlusDebt;
}
```

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams params) public view returns (uint256, uint256)
```

Calculates the interest rates depending on the reserve's state and configurations

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address |  |
| extraData | bytes |  |
| params | struct DataTypes.CalculateInterestRatesParams | The parameters needed to calculate interest rates |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | liquidityRate The liquidity rate expressed in rays |
| [1] | uint256 | variableBorrowRate The variable borrow rate expressed in rays |

### _getOverallBorrowRate

```solidity
function _getOverallBorrowRate(uint256 totalVariableDebt, uint256 currentVariableBorrowRate) internal pure returns (uint256)
```

_Calculates the overall borrow rate as the weighted average between the total variable debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalVariableDebt | uint256 | The total borrowed from the reserve at a variable rate |
| currentVariableBorrowRate | uint256 | The current variable borrow rate of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The weighted averaged borrow rate |

