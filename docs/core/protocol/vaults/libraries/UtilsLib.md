# Solidity API

## UtilsLib

Library exposing helpers.

_Inspired by https://github.com/morpho-org/morpho-utils._

### exactlyOneZero

```solidity
function exactlyOneZero(uint256 x, uint256 y) internal pure returns (bool z)
```

_Returns true if there is exactly one zero among `x` and `y`._

### min

```solidity
function min(uint256 x, uint256 y) internal pure returns (uint256 z)
```

_Returns the min of `x` and `y`._

### toUint128

```solidity
function toUint128(uint256 x) internal pure returns (uint128)
```

_Returns `x` safely cast to uint128._

### zeroFloorSub

```solidity
function zeroFloorSub(uint256 x, uint256 y) internal pure returns (uint256 z)
```

_Returns max(0, x - y)._

