// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {IPool} from '../../../interfaces/IPool.sol';
import {IFlashLoanSimpleReceiver} from '../../../interfaces/IFlashLoanSimpleReceiver.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {Errors} from '../utils/Errors.sol';
import {WadRayMath} from '../utils/WadRayMath.sol';
import {PercentageMath} from '../utils/PercentageMath.sol';
import {DataTypes} from '../configuration/DataTypes.sol';
import {ValidationLogic} from './ValidationLogic.sol';
import {ReserveLogic} from './ReserveLogic.sol';

/**
 * @title FlashLoanLogic library
 * @notice Implements the logic for the flash loans
 */
library FlashLoanLogic {
  using ReserveLogic for DataTypes.ReserveCache;
  using ReserveLogic for DataTypes.ReserveData;
  using SafeERC20 for IERC20;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using WadRayMath for uint256;
  using PercentageMath for uint256;
  using SafeCast for uint256;

  // See `IPool` for descriptions
  event FlashLoan(address indexed target, address initiator, address indexed asset, uint256 amount, uint256 premium);

  // Helper struct for internal variables used in the `executeFlashLoan` function
  struct FlashLoanLocalVars {
    IFlashLoanSimpleReceiver receiver;
    uint256 i;
    address currentAsset;
    uint256 currentAmount;
    uint256[] totalPremiums;
    uint256 flashloanPremiumTotal;
  }

  /**
   * @notice Implements the simple flashloan feature that allow users to access liquidity of ONE reserve for one
   * transaction as long as the amount taken plus fee is returned.
   * @dev Does not waive fee for approved flashborrowers nor allow taking on debt instead of repaying to save gas
   * @dev At the end of the transaction the pool will pull amount borrowed + fee from the receiver,
   * if the receiver have not approved the pool the transaction will revert.
   * @dev Emits the `FlashLoan()` event
   * @param reserve The state of the flashloaned reserve
   * @param params The additional parameters needed to execute the simple flashloan function
   */
  function executeFlashLoanSimple(
    address pool,
    DataTypes.ReserveData storage reserve,
    DataTypes.ReserveSupplies storage totalSupplies,
    DataTypes.FlashloanSimpleParams memory params
  ) external {
    // The usual action flow (cache -> updateState -> validation -> changeState -> updateRates)
    // is altered to (validation -> user payload -> cache -> updateState -> changeState -> updateRates) for flashloans.
    // This is done to protect against reentrance and rate manipulation within the user specified payload.

    ValidationLogic.validateFlashloanSimple(reserve);

    IFlashLoanSimpleReceiver receiver = IFlashLoanSimpleReceiver(params.receiverAddress);
    uint256 totalPremium = params.amount.percentMul(params.flashLoanPremiumTotal);
    IERC20(params.asset).transfer(params.receiverAddress, params.amount);

    require(receiver.executeOperation(params.asset, params.amount, totalPremium, msg.sender, params.params), Errors.INVALID_FLASHLOAN_EXECUTOR_RETURN);

    _handleFlashLoanRepayment(
      reserve,
      totalSupplies,
      DataTypes.FlashLoanRepaymentParams({pool: pool, asset: params.asset, receiverAddress: params.receiverAddress, amount: params.amount, totalPremium: totalPremium})
    );
  }

  /**
   * @notice Handles repayment of flashloaned assets + premium
   * @dev Will pull the amount + premium from the receiver, so must have approved pool
   * @param reserve The state of the flashloaned reserve
   * @param params The additional parameters needed to execute the repayment function
   */
  function _handleFlashLoanRepayment(
    DataTypes.ReserveData storage reserve,
    DataTypes.ReserveSupplies storage totalSupplies,
    DataTypes.FlashLoanRepaymentParams memory params
  ) internal {
    uint256 amountPlusPremium = params.amount + params.totalPremium;

    DataTypes.ReserveCache memory reserveCache = reserve.cache(totalSupplies);
    reserve.updateState(reserveCache);

    reserve.accruedToTreasuryShares += params.totalPremium.rayDiv(reserveCache.nextLiquidityIndex).toUint128();

    reserve.updateInterestRates(reserveCache, params.asset, IPool(params.pool).getReserveFactor(), amountPlusPremium, 0, '', '');

    IERC20(params.asset).safeTransferFrom(params.receiverAddress, address(params.pool), amountPlusPremium);

    // todo
    // IAToken(reserveCache.aTokenAddress).handleRepayment(
    //   params.receiverAddress,
    //   params.receiverAddress,
    //   amountPlusPremium
    // );

    emit FlashLoan(params.receiverAddress, msg.sender, params.asset, params.amount, params.totalPremium);
  }
}
