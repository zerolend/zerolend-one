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
import {IPoolConfigurator} from '../../../interfaces/IPoolConfigurator.sol';
import {DataTypes} from '../configuration/DataTypes.sol';

import {PoolErrorsLib} from '../../../interfaces/errors/PoolErrorsLib.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {PoolManager} from './PoolManager.sol';

/**
 * @title PoolConfigurator
 * @dev Implements the configuration methods for the lending pools
 */
contract PoolConfigurator is PoolManager, IPoolConfigurator {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  address public factory;

  constructor(address _factory, address _governance) PoolManager(_governance) {
    factory = _factory;
  }

  function initRoles(IPool pool, address admin) external override {
    require(msg.sender == factory, '!factory');

    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), governance);

    _setRoleAdmin(getRoleFromPool(pool, POOL_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(getRoleFromPool(pool, RISK_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveBorrowing(IPool pool, address asset, bool enabled) external onlyPoolAdmin(pool) {
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    config.setBorrowingEnabled(enabled);
    pool.setReserveConfiguration(asset, address(0), address(0), config);
    emit ReserveBorrowing(asset, enabled);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveFreeze(IPool pool, address asset, bool freeze) external onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    config.setFrozen(freeze);
    pool.setReserveConfiguration(asset, address(0), address(0), config);
    emit ReserveFrozen(asset, freeze);
  }

  /// @inheritdoc IPoolConfigurator
  function setPoolFreeze(IPool pool, bool freeze) external onlyEmergencyAdmin(pool) {
    address[] memory reserves = pool.getReservesList();

    for (uint256 i = 0; i < reserves.length; i++) {
      DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(reserves[i]);
      config.setFrozen(freeze);
      pool.setReserveConfiguration(reserves[i], address(0), address(0), config);
      emit ReserveFrozen(reserves[i], freeze);
    }
  }

  /// @inheritdoc IPoolConfigurator
  function setBorrowCap(IPool pool, address asset, uint256 newBorrowCap) external onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    uint256 oldBorrowCap = config.getBorrowCap();
    config.setBorrowCap(newBorrowCap);
    pool.setReserveConfiguration(asset, address(0), address(0), config);
    emit BorrowCapChanged(asset, oldBorrowCap, newBorrowCap);
  }

  /// @inheritdoc IPoolConfigurator
  function setSupplyCap(IPool pool, address asset, uint256 newSupplyCap) external onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    uint256 oldSupplyCap = config.getSupplyCap();
    config.setSupplyCap(newSupplyCap);
    pool.setReserveConfiguration(asset, address(0), address(0), config);
    emit SupplyCapChanged(asset, oldSupplyCap, newSupplyCap);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveInterestRateStrategyAddress(IPool pool, address asset, address newRateStrategyAddress) external onlyPoolAdmin(pool) {
    DataTypes.ReserveData memory reserve = pool.getReserveData(asset);
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    address oldRateStrategyAddress = reserve.interestRateStrategyAddress;
    pool.setReserveConfiguration(asset, newRateStrategyAddress, address(0), config);
    emit ReserveInterestRateStrategyChanged(asset, oldRateStrategyAddress, newRateStrategyAddress);
  }

  /// @inheritdoc IPoolConfigurator
  function getPoolAssetConfiguration(IPool pool, address asset) public view returns (DataTypes.InitReserveConfig memory config) {
    DataTypes.ReserveConfigurationMap memory configRaw = pool.getConfiguration(asset);
    config.borrowable = configRaw.getBorrowingEnabled();
    config.frozen = configRaw.getFrozen();
    config.borrowCap = configRaw.getBorrowCap();
    config.decimals = configRaw.getDecimals();
    config.liquidationBonus = configRaw.getLiquidationBonus();
    config.liquidationThreshold = configRaw.getLiquidationThreshold();
    config.ltv = configRaw.getLtv();
    config.supplyCap = configRaw.getSupplyCap();
  }

  /// @inheritdoc IPoolConfigurator
  function getPoolFullConfig(IPool pool) external view returns (DataTypes.InitPoolParams memory config) {
    address[] memory reserves = pool.getReservesList();
    config.hook = address(pool.getHook());

    address[] memory assets = new address[](reserves.length);
    address[] memory rateStrategyAddresses = new address[](reserves.length);
    address[] memory sources = new address[](reserves.length);
    DataTypes.InitReserveConfig[] memory configurations = new DataTypes.InitReserveConfig[](reserves.length);

    for (uint i = 0; i < reserves.length; i++) {
      DataTypes.ReserveData memory data = pool.getReserveData(reserves[i]);

      assets[i] = reserves[i];
      rateStrategyAddresses[i] = data.interestRateStrategyAddress;
      sources[i] = data.oracle;
      configurations[i] = getPoolAssetConfiguration(pool, reserves[i]);
    }
  }
}
