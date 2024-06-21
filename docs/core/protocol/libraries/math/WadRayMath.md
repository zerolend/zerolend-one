# Solidity API

## WadRayMath

Provides functions to perform calculations with Wad and Ray units

_Provides mul and div function for wads (decimal numbers with 18 digits of precision) and rays (decimal numbers
with 27 digits of precision)
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### WAD

```solidity
uint256 WAD
```

### HALF_WAD

```solidity
uint256 HALF_WAD
```

### RAY

```solidity
uint256 RAY
```

### HALF_RAY

```solidity
uint256 HALF_RAY
```

### WAD_RAY_RATIO

```solidity
uint256 WAD_RAY_RATIO
```

### wadMul

```solidity
function wadMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Multiplies two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a*b, in wad |

### wadDiv

```solidity
function wadDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Divides two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a/b, in wad |

### rayMul

```solidity
function rayMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Multiplies two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raymul b |

### rayDiv

```solidity
function rayDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Divides two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raydiv b |

### rayToWad

```solidity
function rayToWad(uint256 a) internal pure returns (uint256 b)
```

_Casts ray down to wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted to wad, rounded half up to the nearest wad |

### wadToRay

```solidity
function wadToRay(uint256 a) internal pure returns (uint256 b)
```

_Converts wad up to ray
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted in ray |

