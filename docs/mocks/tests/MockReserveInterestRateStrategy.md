# Solidity API

## MockReserveInterestRateStrategy

### OPTIMAL_USAGE_RATIO

```solidity
uint256 OPTIMAL_USAGE_RATIO
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

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

### _stableRateSlope1

```solidity
uint256 _stableRateSlope1
```

### _stableRateSlope2

```solidity
uint256 _stableRateSlope2
```

### MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO
```

### MAX_EXCESS_USAGE_RATIO

```solidity
uint256 MAX_EXCESS_USAGE_RATIO
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO
```

### _liquidityRate

```solidity
uint256 _liquidityRate
```

### _stableBorrowRate

```solidity
uint256 _stableBorrowRate
```

### _variableBorrowRate

```solidity
uint256 _variableBorrowRate
```

### constructor

```solidity
constructor(uint256 optimalUsageRatio, uint256 baseVariableBorrowRate, uint256 variableRateSlope1, uint256 variableRateSlope2) internal
```

### setLiquidityRate

```solidity
function setLiquidityRate(uint256 liquidityRate) public
```

### setStableBorrowRate

```solidity
function setStableBorrowRate(uint256 stableBorrowRate) public
```

### setVariableBorrowRate

```solidity
function setVariableBorrowRate(uint256 variableBorrowRate) public
```

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams) external view returns (uint256 liquidityRate, uint256 variableBorrowRate)
```

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

### getStableRateSlope1

```solidity
function getStableRateSlope1() external view returns (uint256)
```

### getStableRateSlope2

```solidity
function getStableRateSlope2() external view returns (uint256)
```

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

