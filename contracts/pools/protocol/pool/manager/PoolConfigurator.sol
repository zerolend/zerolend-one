// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {ConfiguratorInputTypes} from '../../libraries/types/ConfiguratorInputTypes.sol';
import {DataTypes} from '../../libraries/types/DataTypes.sol';
import {Errors} from '../../libraries/helpers/Errors.sol';
import {IPool} from '../../../interfaces/IPool.sol';
import {IPoolConfigurator} from '../../../interfaces/IPoolConfigurator.sol';
import {PercentageMath} from '../../libraries/math/PercentageMath.sol';
import {PoolManager} from './PoolManager.sol';
import {ReserveConfiguration} from '../../libraries/configuration/ReserveConfiguration.sol';

/**
 * @title PoolConfigurator
 * @dev Implements the configuration methods for the lending pools
 */
abstract contract PoolConfigurator is PoolManager, IPoolConfigurator {
  using PercentageMath for uint256;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  address public factory;

  constructor(address _factory, address _governance) PoolManager(_governance) {
    factory = _factory;
  }

  function initRoles(address pool, address admin) external override {
    require(msg.sender == factory, '!factory');

    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), governance);

    _setRoleAdmin(getRoleFromPool(pool, POOL_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(getRoleFromPool(pool, RISK_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(
      getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE),
      getRoleFromPool(pool, POOL_ADMIN_ROLE)
    );
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
