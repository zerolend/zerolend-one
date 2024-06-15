// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {DataTypes} from '../types/DataTypes.sol';

/**
 * @title Helpers library
 * @author Aave
 */
library Helpers {
  /**
   * @notice Fetches the user current stable and variable debt balances
   * @param position The user address
   * @param reserveCache The reserve cache data object
   * @return The stable debt balance
   * @return The variable debt balance
   */
  function getUserCurrentDebt(
    bytes32 position,
    DataTypes.ReserveCache memory reserveCache
  ) internal view returns (uint256, uint256) {
    return (
      0,
      0 // IERC20(reserveCache.stableDebtTokenAddress).balanceOf(user),
      // IERC20(reserveCache.variableDebtTokenAddress).balanceOf(user)
    );
  }
}
