// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IERC20Detailed} from '../interfaces/IERC20Detailed.sol';
import {ReserveConfiguration} from '../protocol/libraries/configuration/ReserveConfiguration.sol';
import {UserConfiguration} from '../protocol/libraries/configuration/UserConfiguration.sol';
import {DataTypes} from '../protocol/libraries/types/DataTypes.sol';
import {WadRayMath} from '../protocol/libraries/math/WadRayMath.sol';
import {IStableDebtToken} from '../interfaces/IStableDebtToken.sol';
import {IVariableDebtToken} from '../interfaces/IVariableDebtToken.sol';
import {IPool} from '../interfaces/IPool.sol';
import {IPoolDataProvider} from '../interfaces/IPoolDataProvider.sol';

/**
 * @title AaveProtocolDataProvider
 * @author Aave
 * @notice Peripheral contract to collect and pre-process information from the Pool.
 */
abstract contract AaveProtocolDataProvider is IPoolDataProvider {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using WadRayMath for uint256;

  address constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

  /// @inheritdoc IPoolDataProvider
  function getAllReservesTokens(address pool) external view override returns (TokenData[] memory) {
    IPool cachedPool = IPool(pool);
    address[] memory reserves = cachedPool.getReservesList();
    TokenData[] memory reservesTokens = new TokenData[](reserves.length);
    for (uint256 i = 0; i < reserves.length; i++) {
      if (reserves[i] == ETH) {
        reservesTokens[i] = TokenData({symbol: 'ETH', tokenAddress: reserves[i]});
        continue;
      }
      reservesTokens[i] = TokenData({
        symbol: IERC20Detailed(reserves[i]).symbol(),
        tokenAddress: reserves[i]
      });
    }
    return reservesTokens;
  }

  /// @inheritdoc IPoolDataProvider
  function getAllATokens(address pool) external view override returns (TokenData[] memory) {
    IPool cachedPool = IPool(pool);
    address[] memory reserves = cachedPool.getReservesList();
    TokenData[] memory aTokens = new TokenData[](reserves.length);
    for (uint256 i = 0; i < reserves.length; i++) {
      DataTypes.ReserveData memory reserveData = cachedPool.getReserveData(reserves[i]);
      aTokens[i] = TokenData({
        symbol: IERC20Detailed(reserveData.aTokenAddress).symbol(),
        tokenAddress: reserveData.aTokenAddress
      });
    }
    return aTokens;
  }

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
      bool isActive,
      bool isFrozen
    )
  {
    DataTypes.ReserveConfigurationMap memory configuration = IPool(pool).getConfiguration(asset);

    (ltv, liquidationThreshold, liquidationBonus, decimals, reserveFactor) = configuration
      .getParams();

    (isActive, isFrozen, borrowingEnabled, , ) = configuration.getFlags();

    usageAsCollateralEnabled = liquidationThreshold != 0;
  }

  /// @inheritdoc IPoolDataProvider
  function getReserveCaps(
    address pool,
    address asset
  ) external view override returns (uint256 borrowCap, uint256 supplyCap) {
    (borrowCap, supplyCap) = IPool(pool).getConfiguration(asset).getCaps();
  }

  /// @inheritdoc IPoolDataProvider
  function getPaused(address pool, address asset) external view override returns (bool isPaused) {
    (, , , , isPaused) = IPool(pool).getConfiguration(asset).getFlags();
  }

  /// @inheritdoc IPoolDataProvider
  function getLiquidationProtocolFee(
    address pool,
    address asset
  ) external view override returns (uint256) {
    return IPool(pool).getConfiguration(asset).getLiquidationProtocolFee();
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

  /// @inheritdoc IPoolDataProvider
  function getATokenTotalSupply(
    address pool,
    address asset
  ) external view override returns (uint256) {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
    return IERC20Detailed(reserve.aTokenAddress).totalSupply();
  }

  /// @inheritdoc IPoolDataProvider
  function getTotalDebt(address pool, address asset) external view override returns (uint256) {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
    return IERC20Detailed(reserve.variableDebtTokenAddress).totalSupply();
  }

  /// @inheritdoc IPoolDataProvider
  function getUserReserveData(
    address pool,
    address asset,
    address user
  )
    external
    view
    override
    returns (
      uint256 currentATokenBalance,
      uint256 currentVariableDebt,
      uint256 scaledVariableDebt,
      uint256 liquidityRate,
      bool usageAsCollateralEnabled
    )
  {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);

    DataTypes.UserConfigurationMap memory userConfig = IPool(pool).getUserConfiguration(user);

    currentATokenBalance = IERC20Detailed(reserve.aTokenAddress).balanceOf(user);
    currentVariableDebt = IERC20Detailed(reserve.variableDebtTokenAddress).balanceOf(user);
    scaledVariableDebt = IVariableDebtToken(reserve.variableDebtTokenAddress).scaledBalanceOf(user);
    liquidityRate = reserve.currentLiquidityRate;

    usageAsCollateralEnabled = userConfig.isUsingAsCollateral(reserve.id);
  }

  /// @inheritdoc IPoolDataProvider
  function getReserveTokensAddresses(
    address pool,
    address asset
  ) external view override returns (address aTokenAddress, address variableDebtTokenAddress) {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);

    return (reserve.aTokenAddress, reserve.variableDebtTokenAddress);
  }

  /// @inheritdoc IPoolDataProvider
  function getInterestRateStrategyAddress(
    address pool,
    address asset
  ) external view override returns (address irStrategyAddress) {
    DataTypes.ReserveData memory reserve = IPool(pool).getReserveData(asset);
    return (reserve.interestRateStrategyAddress);
  }

  /// @inheritdoc IPoolDataProvider
  function getFlashLoanEnabled(address pool, address asset) external view override returns (bool) {
    DataTypes.ReserveConfigurationMap memory configuration = IPool(pool).getConfiguration(asset);
    return configuration.getFlashLoanEnabled();
  }
}
