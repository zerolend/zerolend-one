// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {IVariableDebtToken} from '../../../interfaces/IVariableDebtToken.sol';
import {IAToken} from '../../../interfaces/IAToken.sol';
import {UserConfiguration} from '../configuration/UserConfiguration.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {Helpers} from '../helpers/Helpers.sol';
import {DataTypes} from '../types/DataTypes.sol';
import {ValidationLogic} from './ValidationLogic.sol';
import {ReserveLogic} from './ReserveLogic.sol';

/**
 * @title BorrowLogic library
 * @author Aave
 * @notice Implements the base logic for all the actions related to borrowing
 */
library BorrowLogic {
  using ReserveLogic for DataTypes.ReserveCache;
  using ReserveLogic for DataTypes.ReserveData;
  using SafeERC20 for IERC20;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using SafeCast for uint256;

  // See `IPool` for descriptions
  event Borrow(
    address indexed reserve,
    address user,
    bytes32 indexed position,
    uint256 amount,
    uint256 borrowRate,
    uint16 indexed referralCode
  );
  event Repay(
    address indexed reserve,
    bytes32 indexed position,
    address indexed repayer,
    uint256 amount
  );

  /**
   * @notice Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
   * Aave protocol proportionally to their collateralization power.
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
    DataTypes.ExecuteBorrowParams memory params
  ) public {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();

    reserve.updateState(reserveCache);

    ValidationLogic.validateBorrow(
      reservesData,
      reservesList,
      DataTypes.ValidateBorrowParams({
        reserveCache: reserveCache,
        userConfig: userConfig,
        asset: params.asset,
        position: params.onBehalfOfPosition,
        amount: params.amount,
        reservesCount: params.reservesCount,
        oracle: params.oracle
      })
    );

    bool isFirstBorrowing = false;

    // (isFirstBorrowing, reserveCache.nextScaledVariableDebt) = IVariableDebtToken(
    //   reserveCache.variableDebtTokenAddress
    // ).mint(
    //     params.user,
    //     params.onBehalfOfPosition,
    //     params.amount,
    //     reserveCache.nextVariableBorrowIndex
    //   );

    if (isFirstBorrowing) {
      userConfig.setBorrowing(reserve.id, true);
    }

    reserve.updateInterestRates(
      reserveCache,
      params.asset,
      0,
      params.releaseUnderlying ? params.amount : 0
    );

    if (params.releaseUnderlying) {
      IAToken(reserveCache.aTokenAddress).transferUnderlyingTo(params.user, params.amount);
    }

    emit Borrow(
      params.asset,
      params.user,
      params.onBehalfOfPosition,
      params.amount,
      reserve.currentVariableBorrowRate,
      params.referralCode
    );
  }

  /**
   * @notice Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
   * equivalent amount of debt for the user by burning the corresponding debt token.
   * @dev  Emits the `Repay()` event
   * @param reservesData The state of all the reserves
   * @param reservesList The addresses of all the active reserves
   * @param userConfig The user configuration mapping that tracks the supplied/borrowed assets
   * @param params The additional parameters needed to execute the repay function
   * @return The actual amount being repaid
   */
  function executeRepay(
    mapping(address => DataTypes.ReserveData) storage reservesData,
    mapping(uint256 => address) storage reservesList,
    DataTypes.UserConfigurationMap storage userConfig,
    DataTypes.ExecuteRepayParams memory params
  ) external returns (uint256) {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();
    reserve.updateState(reserveCache);

    (uint256 stableDebt, uint256 variableDebt) = Helpers.getUserCurrentDebt(
      params.onBehalfOfPosition,
      reserveCache
    );

    ValidationLogic.validateRepay(
      reserveCache,
      params.amount,
      params.onBehalfOfPosition,
      variableDebt
    );

    uint256 paybackAmount = variableDebt;

    // Allows a user to repay with aTokens without leaving dust from interest.
    if (params.amount == type(uint256).max) {
      params.amount = IAToken(reserveCache.aTokenAddress).balanceOf(msg.sender);
    }

    if (params.amount < paybackAmount) {
      paybackAmount = params.amount;
    }

    // todo
    // reserveCache.nextScaledVariableDebt = IVariableDebtToken(reserveCache.variableDebtTokenAddress)
    //   .burn(params.onBehalfOfPosition, paybackAmount, reserveCache.nextVariableBorrowIndex);

    reserve.updateInterestRates(reserveCache, params.asset, paybackAmount, 0);

    if (stableDebt + variableDebt - paybackAmount == 0) {
      userConfig.setBorrowing(reserve.id, false);
    }

    IERC20(params.asset).safeTransferFrom(msg.sender, reserveCache.aTokenAddress, paybackAmount);
    // todo
    // IAToken(reserveCache.aTokenAddress).handleRepayment(
    //   msg.sender,
    //   params.onBehalfOfPosition,
    //   paybackAmount
    // );

    emit Repay(params.asset, params.onBehalfOfPosition, msg.sender, paybackAmount);

    return paybackAmount;
  }
}
