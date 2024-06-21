// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {DataTypes} from '../types/DataTypes.sol';
import {Errors} from '../helpers/Errors.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {PercentageMath} from '../math/PercentageMath.sol';
import {PositionBalanceConfiguration} from '../configuration/PositionBalanceConfiguration.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {ReserveLogic} from './ReserveLogic.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {UserConfiguration} from '../configuration/UserConfiguration.sol';
import {ValidationLogic} from './ValidationLogic.sol';
import {WadRayMath} from '../math/WadRayMath.sol';

/**
 * @title SupplyLogic library
 * @notice Implements the base logic for supply/withdraw
 */
library SupplyLogic {
  using PercentageMath for uint256;
  using PositionBalanceConfiguration for DataTypes.PositionBalance;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using ReserveLogic for DataTypes.ReserveCache;
  using ReserveLogic for DataTypes.ReserveData;
  using SafeERC20 for IERC20;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using WadRayMath for uint256;

  // See `IPool` for descriptions
  event ReserveUsedAsCollateralEnabled(address indexed reserve, bytes32 indexed position);
  event ReserveUsedAsCollateralDisabled(address indexed reserve, bytes32 indexed position);
  event Withdraw(address indexed reserve, bytes32 indexed pos, address indexed to, uint256 amount);
  event Supply(address indexed reserve, address user, bytes32 indexed pos, uint256 amount);

  /**
   * @notice Implements the supply feature. Through `supply()`, users supply assets to the Aave protocol.
   * @dev Emits the `Supply()` event.
   * @dev In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
   * collateral.
   * @param reservesData The state of all the reserves
   * @param params The additional parameters needed to execute the supply function
   */
  function executeSupply(
    address onBehalfOf,
    mapping(address => DataTypes.ReserveData) storage reservesData,
    mapping(uint256 => address) storage reservesList,
    DataTypes.UserConfigurationMap storage userConfig,
    DataTypes.ExecuteSupplyParams memory params,
    mapping(address asset => mapping(bytes32 positionId => uint256 balance)) storage _balances,
    mapping(address asset => uint256 totalSupply) storage _totalSupplies,
    address pool
  ) external {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();

    reserve.updateState(reserveCache);
    ValidationLogic.validateSupply(reserveCache, reserve, params, address(pool));
    reserve.updateInterestRates(reserveCache, params.asset, params.amount, 0);

    IERC20(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);

    DataTypes.PositionBalance storage b = _balances[params.asset][params.position];
    bool isFirstSupply = b.mintSupply(params.amount, reserveCache.nextLiquidityIndex);

    // todo
    // _totalSupplies[params.asset] += params.amount;

    if (isFirstSupply) {
      if (
        ValidationLogic.validateUseAsCollateral(
          reservesData,
          reservesList,
          userConfig,
          reserveCache.reserveConfiguration
        )
      ) {
        userConfig.setUsingAsCollateral(reserve.id, true);
        emit ReserveUsedAsCollateralEnabled(params.asset, params.position);
      }
    }

    // emit Supply(params.asset, onBehalfOf, params.position, params.amount);
  }

  /**
   * @notice Implements the withdraw feature. Through `withdraw()`, users redeem their aTokens for the underlying asset
   * previously supplied in the Aave protocol.
   * @dev Emits the `Withdraw()` event.
   * @dev If the user withdraws everything, `ReserveUsedAsCollateralDisabled()` is emitted.
   * @param reservesData The state of all the reserves
   * @param reservesList The addresses of all the active reserves
   * @param userConfig The user configuration mapping that tracks the supplied/borrowed assets
   * @param params The additional parameters needed to execute the withdraw function
   * @return The actual amount withdrawn
   */
  function executeWithdraw(
    mapping(address => DataTypes.ReserveData) storage reservesData,
    mapping(uint256 => address) storage reservesList,
    DataTypes.UserConfigurationMap storage userConfig,
    DataTypes.ExecuteWithdrawParams memory params,
    mapping(address asset => mapping(bytes32 position => DataTypes.PositionBalance balance))
      storage _balances,
    mapping(address asset => uint256 totalSupply) storage _totalSupplies
  ) external returns (uint256) {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory reserveCache = reserve.cache();

    reserve.updateState(reserveCache);

    DataTypes.PositionBalance storage balance = _balances[params.asset][params.position];

    uint256 amountToWithdraw = params.amount;

    if (params.amount == type(uint256).max) amountToWithdraw = balance.scaledSupplyBalance;

    ValidationLogic.validateWithdraw(reserveCache, amountToWithdraw, balance);

    reserve.updateInterestRates(reserveCache, params.asset, 0, amountToWithdraw);

    bool isCollateral = userConfig.isUsingAsCollateral(reserve.id);

    if (isCollateral && amountToWithdraw == balance.scaledSupplyBalance) {
      userConfig.setUsingAsCollateral(reserve.id, false);
      emit ReserveUsedAsCollateralDisabled(params.asset, params.position);
    }

    _totalSupplies[params.asset] -= params.amount;
    _balances[params.asset][params.position] -= params.amount;

    IERC20(params.asset).safeTransfer(params.user, params.amount);

    if (isCollateral && userConfig.isBorrowingAny()) {
      ValidationLogic.validateHFAndLtv(
        reservesData,
        reservesList,
        userConfig,
        params.asset,
        params.position,
        params.reservesCount,
        params.pool
      );
    }

    emit Withdraw(params.asset, params.position, params.user, amountToWithdraw);

    return amountToWithdraw;
  }
}
