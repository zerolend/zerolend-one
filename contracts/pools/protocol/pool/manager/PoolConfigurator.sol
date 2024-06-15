// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {ConfiguratorInputTypes} from '../../libraries/types/ConfiguratorInputTypes.sol';
import {ConfiguratorLogic} from '../../libraries/logic/ConfiguratorLogic.sol';
import {DataTypes} from '../../libraries/types/DataTypes.sol';
import {Errors} from '../../libraries/helpers/Errors.sol';
import {IPool} from '../../../interfaces/IPool.sol';
import {IPoolConfigurator} from '../../../interfaces/IPoolConfigurator.sol';
import {PercentageMath} from '../../libraries/math/PercentageMath.sol';
import {PoolManager} from './PoolManager.sol';
import {ReserveConfiguration} from '../../libraries/configuration/ReserveConfiguration.sol';

/**
 * @title PoolConfigurator
 * @author Aave
 * @dev Implements the configuration methods for the Aave protocol
 */
abstract contract PoolConfigurator is PoolManager, IPoolConfigurator {
  using PercentageMath for uint256;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  // @inheritdoc IPoolConfigurator
  function initReserves(
    address pool,
    ConfiguratorInputTypes.InitReserveInput[] calldata input
  ) external onlyPoolAdmin(pool) {
    IPool cachedPool = IPool(pool);
    for (uint256 i = 0; i < input.length; i++) {
      ConfiguratorLogic.executeInitReserve(cachedPool, input[i]);

      // validation of the parameters: the LTV can
      // only be lower or equal than the liquidation threshold
      // (otherwise a loan against the asset would cause instantaneous liquidation)
      require(input[i].ltv <= input[i].liquidationThreshold, Errors.INVALID_RESERVE_PARAMS);

      DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(
        input[i].asset
      );

      if (input[i].liquidationThreshold != 0) {
        //liquidation bonus must be bigger than 100.00%, otherwise the liquidator would receive less
        //collateral than needed to cover the debt
        require(
          input[i].liquidationBonus > PercentageMath.PERCENTAGE_FACTOR,
          Errors.INVALID_RESERVE_PARAMS
        );

        //if threshold * bonus is less than PERCENTAGE_FACTOR, it's guaranteed that at the moment
        //a loan is taken there is enough collateral available to cover the liquidation bonus
        require(
          input[i].liquidationThreshold.percentMul(input[i].liquidationBonus) <=
            PercentageMath.PERCENTAGE_FACTOR,
          Errors.INVALID_RESERVE_PARAMS
        );

        currentConfig.setLtv(input[i].ltv);
        currentConfig.setLiquidationThreshold(input[i].liquidationThreshold);
        currentConfig.setLiquidationBonus(input[i].liquidationBonus);
        cachedPool.setConfiguration(input[i].asset, currentConfig);

        emit CollateralConfigurationChanged(
          input[i].asset,
          input[i].ltv,
          input[i].liquidationThreshold,
          input[i].liquidationBonus
        );
      }
    }
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveBorrowing(
    address pool,
    address asset,
    bool enabled
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    currentConfig.setBorrowingEnabled(enabled);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveBorrowing(asset, enabled);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveFreeze(
    address pool,
    address asset,
    bool freeze
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    currentConfig.setFrozen(freeze);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveFrozen(asset, freeze);
  }

  // @inheritdoc IPoolConfigurator
  function setBorrowCap(
    address pool,
    address asset,
    uint256 newBorrowCap
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    uint256 oldBorrowCap = currentConfig.getBorrowCap();
    currentConfig.setBorrowCap(newBorrowCap);
    cachedPool.setConfiguration(asset, currentConfig);
    emit BorrowCapChanged(asset, oldBorrowCap, newBorrowCap);
  }

  // @inheritdoc IPoolConfigurator
  function setSupplyCap(
    address pool,
    address asset,
    uint256 newSupplyCap
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    uint256 oldSupplyCap = currentConfig.getSupplyCap();
    currentConfig.setSupplyCap(newSupplyCap);
    cachedPool.setConfiguration(asset, currentConfig);
    emit SupplyCapChanged(asset, oldSupplyCap, newSupplyCap);
  }

  // @inheritdoc IPoolConfigurator
  function setReserveInterestRateStrategyAddress(
    address pool,
    address asset,
    address newRateStrategyAddress
  ) external onlyPoolAdmin(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveData memory reserve = cachedPool.getReserveData(asset);
    address oldRateStrategyAddress = reserve.interestRateStrategyAddress;
    // cachedPool.setConfiguration(asset, newRateStrategyAddress);
    emit ReserveInterestRateStrategyChanged(asset, oldRateStrategyAddress, newRateStrategyAddress);
  }
}
