# Solidity API

## PercentageMath

Provides functions to perform percentage calculations

_Percentages are defined by default with 2 decimals of precision (100.00). The precision is indicated by PERCENTAGE_FACTOR
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### PERCENTAGE_FACTOR

```solidity
uint256 PERCENTAGE_FACTOR
```

### HALF_PERCENTAGE_FACTOR

```solidity
uint256 HALF_PERCENTAGE_FACTOR
```

### percentMul

```solidity
function percentMul(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage multiplication

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentmul percentage |

### percentDiv

```solidity
function percentDiv(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage division

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentdiv percentage |

