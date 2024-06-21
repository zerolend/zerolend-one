// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {DataTypes} from '../types/DataTypes.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {IPool} from '../../../interfaces/IPool.sol';
import {PositionBalanceConfiguration} from '../configuration/PositionBalanceConfiguration.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {ReserveLogic} from './ReserveLogic.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {UserConfiguration} from '../configuration/UserConfiguration.sol';
import {ValidationLogic} from './ValidationLogic.sol';

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
  event Borrow(
    address indexed reserve,
    address user,
    bytes32 indexed position,
    uint256 amount,
    uint256 borrowRate
  );
  event Repay(
    address indexed reserve,
    bytes32 indexed position,
    address indexed repayer,
    uint256 amount
  );

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
    mapping(address => DataTypes.ReserveSupplies) storage _totalSupplies,
    DataTypes.ExecuteBorrowParams memory params
  ) public {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();

    reserve.updateState(reserveCache);

    ValidationLogic.validateBorrow(
      _balances,
      reservesData,
      reservesList,
      DataTypes.ValidateBorrowParams({
        reserveCache: reserveCache,
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
    (bool isFirstBorrowing, uint256 minted) = b.mintDebt(
      params.amount,
      reserveCache.nextVariableBorrowIndex
    );
    _totalSupplies[params.asset].debt += minted;
    if (isFirstBorrowing) userConfig.setBorrowing(reserve.id, true);

    // todo; update reserveCache.nextScaledVariableDebt
    _totalSupplies[params.asset].debt -= params.amount;

    reserve.updateInterestRates(
      reserveCache,
      params.asset,
      IPool(params.pool).getReserveFactor(),
      0,
      params.amount
    );

    IERC20(params.asset).safeTransfer(params.user, params.amount);

    emit Borrow(
      params.asset,
      params.user,
      params.position,
      params.amount,
      reserve.currentVariableBorrowRate
    );
  }

  /**
   * @notice Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
   * equivalent amount of debt for the user by burning the corresponding debt token.
   * @dev  Emits the `Repay()` event
   * @param reservesData The state of all the reserves
   * @param params The additional parameters needed to execute the repay function
   * @return The actual amount being repaid
   */
  function executeRepay(
    mapping(address => DataTypes.ReserveData) storage reservesData,
    mapping(address => mapping(bytes32 => DataTypes.PositionBalance)) storage _balances,
    mapping(address => DataTypes.ReserveSupplies) storage _totalSupplies,
    DataTypes.ExecuteRepayParams memory params
  ) external returns (uint256) {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();
    reserve.updateState(reserveCache);

    DataTypes.PositionBalance storage b = _balances[params.asset][params.position];

    uint256 paybackAmount = b.scaledDebtBalance;
    ValidationLogic.validateRepay(params.amount, paybackAmount);

    if (params.amount < paybackAmount) paybackAmount = params.amount;

    reserve.updateInterestRates(
      reserveCache,
      params.asset,
      IPool(params.pool).getReserveFactor(),
      paybackAmount,
      0
    );

    uint256 burnt = b.burnDebt(paybackAmount, reserveCache.nextVariableBorrowIndex);
    // todo; update reserveCache.nextScaledVariableDebt
    reserveCache.nextScaledVariableDebt = b.lastDebtLiquidtyIndex;

    // todo
    // _totalSupplies[params.asset].totalDebts -= burnt;

    IERC20(params.asset).safeTransferFrom(msg.sender, address(this), paybackAmount);
    emit Repay(params.asset, params.position, msg.sender, paybackAmount);

    return paybackAmount;
  }
}
