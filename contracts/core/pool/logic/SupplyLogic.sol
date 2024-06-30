// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

// ███████╗███████╗██████╗  ██████╗
// ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
//   ███╔╝ █████╗  ██████╔╝██║   ██║
//  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
// ███████╗███████╗██║  ██║╚██████╔╝
// ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

// Website: https://zerolend.xyz
// Discord: https://discord.gg/zerolend
// Twitter: https://twitter.com/zerolendxyz
// Telegram: https://t.me/zerolendxyz

import {IPool} from '../../../interfaces/IPool.sol';
import {DataTypes} from '../configuration/DataTypes.sol';

import {PositionBalanceConfiguration} from '../configuration/PositionBalanceConfiguration.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';

import {UserConfiguration} from '../configuration/UserConfiguration.sol';
import {Errors} from '../utils/Errors.sol';
import {PercentageMath} from '../utils/PercentageMath.sol';

import {WadRayMath} from '../utils/WadRayMath.sol';
import {ReserveLogic} from './ReserveLogic.sol';
import {ValidationLogic} from './ValidationLogic.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

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
  event Supply(address indexed reserve, bytes32 indexed pos, uint256 amount);

  /**
   * @notice Implements the supply feature. Through `supply()`, users supply assets to the ZeroLend protocol.
   * @dev Emits the `Supply()` event.
   * @dev In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
   * collateral.
   * @param reserve The state of the reserves
   * @param userConfig The state of the position
   * @param balance The balance of the position
   * @param totalSupplies The total supplies of the reserve
   * @param params The additional parameters needed to execute the supply function
   */
  function executeSupply(
    DataTypes.ReserveData storage reserve,
    DataTypes.UserConfigurationMap storage userConfig,
    DataTypes.PositionBalance storage balance,
    DataTypes.ReserveSupplies storage totalSupplies,
    DataTypes.ExecuteSupplyParams memory params
  ) external {
    DataTypes.ReserveCache memory cache = reserve.cache(totalSupplies);
    reserve.updateState(params.reserveFactor, cache);

    ValidationLogic.validateSupply(cache, reserve, params, params.pool);
    reserve.updateInterestRates(
      cache, params.asset, IPool(params.pool).getReserveFactor(), params.amount, 0, params.position, params.data.interestRateData
    );

    // take the asset from the user and mint the shares
    IERC20(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);
    (bool isFirst, uint256 sharesMinted) = balance.depositCollateral(totalSupplies, params.amount, cache.nextLiquidityIndex);

    // if this is the user's first deposit, enable the reserve as collateral
    if (isFirst && ValidationLogic.validateUseAsCollateral(userConfig, cache.reserveConfiguration)) {
      userConfig.setUsingAsCollateral(reserve.id, true);
      emit ReserveUsedAsCollateralEnabled(params.asset, params.position);
    }

    emit Supply(params.asset, params.position, sharesMinted);
  }

  /**
   * @notice Implements the withdraw feature. Through `withdraw()`, users redeem their aTokens for the underlying asset
   * previously supplied in the ZeroLend protocol.
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
    mapping(address => mapping(bytes32 => DataTypes.PositionBalance)) storage balances,
    mapping(address => DataTypes.ReserveSupplies) storage totalSupplies,
    DataTypes.ExecuteWithdrawParams memory params
  ) external returns (uint256) {
    DataTypes.ReserveData storage reserve = reservesData[params.asset];
    DataTypes.ReserveCache memory cache = reserve.cache(totalSupplies[params.asset]);
    reserve.updateState(params.reserveFactor, cache);

    uint256 balance = balances[params.asset][params.position].getSupplyBalance(cache.nextLiquidityIndex);

    // repay with max amount should clear off all debt
    if (params.amount == type(uint256).max) params.amount = balance;

    ValidationLogic.validateWithdraw(params.amount, balance);

    reserve.updateInterestRates(
      cache, params.asset, IPool(params.pool).getReserveFactor(), 0, params.amount, params.position, params.data.interestRateData
    );

    bool isCollateral = userConfig.isUsingAsCollateral(reserve.id);

    // if the user is withdrawing everything then disable usage as collateral
    if (isCollateral && params.amount == balance) {
      userConfig.setUsingAsCollateral(reserve.id, false);
      emit ReserveUsedAsCollateralDisabled(params.asset, params.position);
    }

    // Burn debt. Which is burn supply, update total supply and send tokens to the user
    balances[params.asset][params.position].withdrawCollateral(totalSupplies[params.asset], params.amount, cache.nextLiquidityIndex);
    IERC20(params.asset).safeTransfer(params.destination, params.amount);

    // if the user is borrowing any asset, validate the HF and LTVs
    if (isCollateral && userConfig.isBorrowingAny()) {
      ValidationLogic.validateHFAndLtv(balances, reservesData, reservesList, userConfig, params);
    }

    emit Withdraw(params.asset, params.position, params.destination, params.amount);
    return params.amount;
  }
}
