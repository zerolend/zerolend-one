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

import {IERC20Detailed} from '../core/interfaces/IERC20Detailed.sol';
import {ReserveConfiguration} from '../core/protocol/libraries/configuration/ReserveConfiguration.sol';
import {UserConfiguration} from '../core/protocol/libraries/configuration/UserConfiguration.sol';
import {DataTypes} from '../core/protocol/libraries/types/DataTypes.sol';
import {WadRayMath} from '../core/protocol/libraries/math/WadRayMath.sol';
import {IPool} from '../core/interfaces/IPool.sol';
import {IPoolDataProvider} from '../core/interfaces/IPoolDataProvider.sol';

abstract contract ProtocolDataProvider is IPoolDataProvider {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using WadRayMath for uint256;

  address constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

  // /// @inheritdoc IPoolDataProvider
  // function getAllReservesTokens(address pool) external view override returns (TokenData[] memory) {
  //   IPool cachedPool = IPool(pool);
  //   address[] memory reserves = cachedPool.getReservesList();
  //   TokenData[] memory reservesTokens = new TokenData[](reserves.length);
  //   for (uint256 i = 0; i < reserves.length; i++) {
  //     if (reserves[i] == ETH) {
  //       reservesTokens[i] = TokenData({symbol: 'ETH', tokenAddress: reserves[i]});
  //       continue;
  //     }
  //     reservesTokens[i] = TokenData({
  //       symbol: IERC20Detailed(reserves[i]).symbol(),
  //       tokenAddress: reserves[i]
  //     });
  //   }
  //   return reservesTokens;
  // }

  /// @inheritdoc IPoolDataProvider
  // function getAllATokens(address pool) external view override returns (TokenData[] memory) {
  //   IPool cachedPool = IPool(pool);
  //   address[] memory reserves = cachedPool.getReservesList();
  //   TokenData[] memory aTokens = new TokenData[](reserves.length);
  //   for (uint256 i = 0; i < reserves.length; i++) {
  //     DataTypes.ReserveData memory reserveData = cachedPool.getReserveData(reserves[i]);
  //     aTokens[i] = TokenData({
  //       symbol: IERC20Detailed(reserveData).symbol(),
  //       tokenAddress: reserveData.aTokenAddress
  //     });
  //   }
  //   return aTokens;
  // }

  /// @inheritdoc IPoolDataProvider
  function getReserveConfigurationData(
    address pool,
    address asset
  )
    external
    view
    override
    returns (
      uint256 decimals,
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      uint256 reserveFactor,
      bool usageAsCollateralEnabled,
      bool borrowingEnabled,
      bool isFrozen
    )
  {
    DataTypes.ReserveConfigurationMap memory configuration = IPool(pool).getConfiguration(asset);

    (ltv, liquidationThreshold, liquidationBonus, decimals, reserveFactor) = configuration
      .getParams();

    (isFrozen, borrowingEnabled, ) = configuration.getFlags();

    usageAsCollateralEnabled = liquidationThreshold != 0;
  }

  /// @inheritdoc IPoolDataProvider
  function getReserveCaps(
    address pool,
    address asset
  ) external view override returns (uint256 borrowCap, uint256 supplyCap) {
    // (borrowCap, supplyCap) = IPool(pool).getConfiguration(asset).getCaps();
  }

  // /// @inheritdoc IPoolDataProvider
  // function getReserveData(
  //   address asset
  // )
  //   external
  //   view
  //   override
  //   returns (
  //     uint256 accruedToTreasuryScaled,
  //     uint256 totalAToken,
  //     uint256 totalVariableDebt,
  //     uint256 liquidityRate,
  //     uint256 variableBorrowRate,
  //     uint256 liquidityIndex,
  //     uint256 variableBorrowIndex,
  //     uint40 lastUpdateTimestamp
  //   )
  // {
  //   DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(
  //     asset
  //   );

  //   return (
  //     reserve.accruedToTreasury,
  //     IERC20Detailed(reserve.aTokenAddress).totalSupply(),
  //     IERC20Detailed(reserve.variableDebtTokenAddress).totalSupply(),
  //     reserve.currentLiquidityRate,
  //     reserve.currentVariableBorrowRate,
  //     reserve.liquidityIndex,
  //     reserve.variableBorrowIndex,
  //     reserve.lastUpdateTimestamp
  //   );
  // }

  // /// @inheritdoc IPoolDataProvider
  // function getATokenTotalSupply(
  //   address pool,
  //   address asset
  // ) external view override returns (uint256) {
  //   DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
  //   return IERC20Detailed(reserve.aTokenAddress).totalSupply();
  // }

  /// @inheritdoc IPoolDataProvider
  // function getTotalDebt(address pool, address asset) external view override returns (uint256) {
  //   DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
  //   return IERC20Detailed(reserve.variableDebtTokenAddress).totalSupply();
  // }

  /// @inheritdoc IPoolDataProvider
  // function getUserReserveData(
  //   address pool,
  //   address asset,
  //   address user
  // )
  //   external
  //   view
  //   override
  //   returns (
  //     uint256 currentATokenBalance,
  //     uint256 currentVariableDebt,
  //     uint256 scaledVariableDebt,
  //     uint256 liquidityRate,
  //     bool usageAsCollateralEnabled
  //   )
  // {
  //   DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);

  //   // todo
  //   DataTypes.UserConfigurationMap memory userConfig; //= IPool(pool).getUserConfiguration(user);

  //   currentATokenBalance = IERC20Detailed(reserve.aTokenAddress).balanceOf(user);
  //   currentVariableDebt = IERC20Detailed(reserve.variableDebtTokenAddress).balanceOf(user);
  //   // scaledVariableDebt = IVariableDebtToken(reserve.variableDebtTokenAddress).scaledBalanceOf(user);
  //   liquidityRate = reserve.currentLiquidityRate;

  //   usageAsCollateralEnabled = userConfig.isUsingAsCollateral(reserve.id);
  // }

  /// @inheritdoc IPoolDataProvider
  // function getReserveTokensAddresses(
  //   address pool,
  //   address asset
  // ) external view override returns (address aTokenAddress, address variableDebtTokenAddress) {
  //   DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);

  //   return (reserve.aTokenAddress, reserve.variableDebtTokenAddress);
  // }

  /// @inheritdoc IPoolDataProvider
  function getInterestRateStrategyAddress(
    address pool,
    address asset
  ) external view override returns (address irStrategyAddress) {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
    return (reserve.interestRateStrategyAddress);
  }
}
