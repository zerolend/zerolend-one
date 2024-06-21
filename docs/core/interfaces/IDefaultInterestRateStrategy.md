# Solidity API

## IDefaultInterestRateStrategy

Defines the basic interface of the DefaultReserveInterestRateStrategy

### OPTIMAL_USAGE_RATIO

```solidity
function OPTIMAL_USAGE_RATIO() external view returns (uint256)
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The optimal usage ratio, expressed in ray. |

### MAX_EXCESS_USAGE_RATIO

```solidity
function MAX_EXCESS_USAGE_RATIO() external view returns (uint256)
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The max excess usage ratio, expressed in ray. |

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

