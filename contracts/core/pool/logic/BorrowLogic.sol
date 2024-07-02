// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IPool} from '../../../interfaces/IPool.sol';
import {DataTypes} from '../configuration/DataTypes.sol';
import {PositionBalanceConfiguration} from '../configuration/PositionBalanceConfiguration.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';

import {UserConfiguration} from '../configuration/UserConfiguration.sol';
import {ReserveLogic} from './ReserveLogic.sol';
import {ValidationLogic} from './ValidationLogic.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';

/**
 * @title BorrowLogic library
 * @notice Implements the base logic for all the actions related to borrowing
 */
library BorrowLogic {
  using ReserveLogic for DataTypes.ReserveCache;
  using ReserveLogic for DataTypes.ReserveData;
  using SafeERC20 for IERC20;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using PositionBalanceConfiguration for DataTypes.PositionBalance;
  using SafeCast for uint256;

  // See `IPool` for descriptions
  event Borrow(address indexed reserve, address user, bytes32 indexed position, uint256 amount, uint256 borrowRate);
  event Repay(address indexed reserve, bytes32 indexed position, address indexed repayer, uint256 amount);

  /**
   * @notice Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
   * protocol proportionally to their collateralization power.
   * @dev  Emits the `Borrow()` event
   * @param reservesData The state of all the reserves
   * @param reservesList The addresses of all the active reserves
   * @param userConfig The user configuration mapping that tracks the supplied/borrowed assets
   * @param params The additional parameters needed to execute the borrow function
   */
  function executeBorrow(
    mapping(address => DataTypes.ReserveData) storage reservesData,
    mapping(uint256 => address) storage reservesList,
    DataTypes.UserConfigurationMap storage userConfig,
    mapping(address => mapping(bytes32 => DataTypes.PositionBalance)) storage _balances,
    DataTypes.ReserveSupplies storage totalSupplies,
    DataTypes.ExecuteBorrowParams memory params
  ) public {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory cache = reserve.cache(totalSupplies);

    reserve.updateState(params.reserveFactor, cache);

    ValidationLogic.validateBorrow(
      _balances,
      reservesData,
      reservesList,
      DataTypes.ValidateBorrowParams({
        cache: cache,
        userConfig: userConfig,
        asset: params.asset,
        position: params.position,
        amount: params.amount,
        reservesCount: params.reservesCount,
        pool: params.pool
      })
    );

    // mint debt tokens
    DataTypes.PositionBalance storage b = _balances[params.asset][params.position];
    (bool isFirstBorrowing,) = b.borrowDebt(totalSupplies, params.amount, cache.nextBorrowIndex);

    // if first borrowing, flag that
    if (isFirstBorrowing) userConfig.setBorrowing(reserve.id, true);

    reserve.updateInterestRates(
      totalSupplies,
      cache,
      params.asset,
      IPool(params.pool).getReserveFactor(),
      0,
      params.amount,
      params.position,
      params.data.interestRateData
    );

    // DataTypes.ReserveData storage _reserve,
    // DataTypes.ReserveCache memory _cache,
    // address _reserveAddress,
    // uint256 _reserveFactor,
    // uint256 _liquidityAdded,
    // uint256 _liquidityTaken,
    // bytes32 _position,
    // bytes memory _data

    IERC20(params.asset).safeTransfer(params.user, params.amount);

    emit Borrow(params.asset, params.user, params.position, params.amount, reserve.currentBorrowRate);
  }

  /**
   * @notice Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
   * equivalent amount of debt for the user by burning the corresponding debt token.
   * @dev  Emits the `Repay()` event
   * @param reserve The state of the reserve
   * @param balances The balance of the position
   * @param totalSupplies The total supply of the reserve
   * @param params The additional parameters needed to execute the repay function
   * @return paybackAmount The actual amount being repaid
   */
  function executeRepay(
    DataTypes.ReserveData storage reserve,
    DataTypes.PositionBalance storage balances,
    DataTypes.ReserveSupplies storage totalSupplies,
    DataTypes.ExecuteRepayParams memory params
  ) external returns (uint256 paybackAmount) {
    DataTypes.ReserveCache memory cache = reserve.cache(totalSupplies);
    reserve.updateState(params.reserveFactor, cache);
    paybackAmount = balances.debtShares;

    // Allows a user to max repay without leaving dust from interest.
    if (params.amount == type(uint256).max) {
      params.amount = balances.getDebtBalance(cache.nextBorrowIndex);
      paybackAmount = params.amount;
    }

    ValidationLogic.validateRepay(params.amount, paybackAmount);

    // If paybackAmount is more than what the user wants to payback, the set it to the
    // user input (ie params.amount)
    if (params.amount < paybackAmount) paybackAmount = params.amount;

    reserve.updateInterestRates(
      totalSupplies,
      cache,
      params.asset,
      IPool(params.pool).getReserveFactor(),
      paybackAmount,
      0,
      params.position,
      params.data.interestRateData
    );

    // update balances and total supplies
    balances.repayDebt(totalSupplies, paybackAmount, cache.nextBorrowIndex);
    cache.nextDebtShares = totalSupplies.debtShares;

    IERC20(params.asset).safeTransferFrom(msg.sender, address(this), paybackAmount);
    emit Repay(params.asset, params.position, msg.sender, paybackAmount);
  }
}
