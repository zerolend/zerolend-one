// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {PendingAddress, PendingUint192} from '../../../interfaces/ICuratedVault.sol';

/// @title PendingLib
/// @author Morpho Labs
/// @custom:contact security@morpho.org
/// @notice Library to manage pending values and their validity timestamp.
library PendingLib {
  /// @dev Updates `pending`'s value to `newValue` and its corresponding `validAt` timestamp.
  /// @dev Assumes `timelock` <= `MAX_TIMELOCK`.
  function update(PendingUint192 storage pending, uint184 newValue, uint256 timelock) internal {
    pending.value = newValue;
    // Safe "unchecked" cast because timelock <= MAX_TIMELOCK.
    pending.validAt = uint64(block.timestamp + timelock);
  }

  /// @dev Updates `pending`'s value to `newValue` and its corresponding `validAt` timestamp.
  /// @dev Assumes `timelock` <= `MAX_TIMELOCK`.
  function update(PendingAddress storage pending, address newValue, uint256 timelock) internal {
    pending.value = newValue;
    // Safe "unchecked" cast because timelock <= MAX_TIMELOCK.
    pending.validAt = uint64(block.timestamp + timelock);
  }
}
