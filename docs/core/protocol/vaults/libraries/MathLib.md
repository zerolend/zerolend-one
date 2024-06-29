# Solidity API

## WAD

```solidity
uint256 WAD
```

## MathLib

Library to manage fixed-point arithmetic.

### wMulDown

```solidity
function wMulDown(uint256 x, uint256 y) internal pure returns (uint256)
```

_Returns (`x` * `y`) / `WAD` rounded down._

### wDivDown

```solidity
function wDivDown(uint256 x, uint256 y) internal pure returns (uint256)
```

_Returns (`x` * `WAD`) / `y` rounded down._

### wDivUp

```solidity
function wDivUp(uint256 x, uint256 y) internal pure returns (uint256)
```

_Returns (`x` * `WAD`) / `y` rounded up._

### mulDivDown

```solidity
function mulDivDown(uint256 x, uint256 y, uint256 d) internal pure returns (uint256)
```

_Returns (`x` * `y`) / `d` rounded down._

### mulDivUp

```solidity
function mulDivUp(uint256 x, uint256 y, uint256 d) internal pure returns (uint256)
```

_Returns (`x` * `y`) / `d` rounded up._

### wTaylorCompounded

```solidity
function wTaylorCompounded(uint256 x, uint256 n) internal pure returns (uint256)
```

_Returns the sum of the first three non-zero terms of a Taylor expansion of e^(nx) - 1, to approximate a
continuous compound interest rate._

