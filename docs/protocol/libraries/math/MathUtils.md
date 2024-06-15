# Solidity API

## MathUtils

Provides functions to perform linear and compounded interest calculations

### SECONDS_PER_YEAR

```solidity
uint256 SECONDS_PER_YEAR
```

_Ignoring leap years_

### calculateLinearInterest

```solidity
function calculateLinearInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Function to calculate the interest accumulated using a linear interest rate formula_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate linearly accumulated during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp, uint256 currentTimestamp) internal pure returns (uint256)
```

_Function to calculate the interest using a compounded interest rate formula
To avoid expensive exponentiation, the calculation is performed using a binomial approximation:

 (1+x)^n = 1+n*x+[n/2*(n-1)]*x^2+[n/6*(n-1)*(n-2)*x^3...

The approximation slightly underpays liquidity providers and undercharges borrowers, with the advantage of great
gas cost reductions. The whitepaper contains reference to the approximation and a table showing the margin of
error per different time periods_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |
| currentTimestamp | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Calculates the compounded interest between the timestamp of the last update and the current block timestamp_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate (in ray) |
| lastUpdateTimestamp | uint40 | The timestamp from which the interest accumulation needs to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded between lastUpdateTimestamp and current block timestamp, in ray |

