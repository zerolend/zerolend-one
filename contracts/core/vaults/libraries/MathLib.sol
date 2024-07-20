// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

uint256 constant WAD = 1e18;

/// @title MathLib
/// @author ZeroLend
/// @custom:contact contact@zerolend.xyz
/// @notice Library to manage fixed-point arithmetic.
library MathLib {
  /// @dev Returns (`x` * `y`) / `d` rounded down.
  function mulDivDown(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return (x * y) / d;
  }

  /// @dev Returns (`x` * `y`) / `d` rounded up.
  function mulDivUp(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return (x * y + (d - 1)) / d;
  }
}
