// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

import {DataTypes} from '../protocol/libraries/types/DataTypes.sol';

/**
 * @title IReserveInterestRateStrategy

 * @notice Interface for the calculation of the interest rates
 */
interface IReserveInterestRateStrategy {
  /**
   * @notice Calculates the interest rates depending on the reserve's state and configurations
   * @param params The parameters needed to calculate interest rates
   * @return liquidityRate The liquidity rate expressed in rays
   * @return variableBorrowRate The variable borrow rate expressed in rays
   */
  function calculateInterestRates(
    address user,
    bytes memory extraData,
    DataTypes.CalculateInterestRatesParams memory params
  ) external view returns (uint256, uint256);
}
