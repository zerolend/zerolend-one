// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {ConfiguratorInputTypes} from '../../libraries/types/ConfiguratorInputTypes.sol';
import {ConfiguratorLogic} from '../../libraries/logic/ConfiguratorLogic.sol';
import {DataTypes} from '../../libraries/types/DataTypes.sol';
import {Errors} from '../../libraries/helpers/Errors.sol';
import {IACLManager} from '../../../interfaces/IACLManager.sol';
import {IPool} from '../../../interfaces/IPool.sol';
import {IPoolAddressesProvider} from '../../../interfaces/IPoolAddressesProvider.sol';
import {IPoolConfigurator} from '../../../interfaces/IPoolConfigurator.sol';
import {IPoolDataProvider} from '../../../interfaces/IPoolDataProvider.sol';
import {PercentageMath} from '../../libraries/math/PercentageMath.sol';
import {PoolManager} from './PoolManager.sol';
import {ReserveConfiguration} from '../../libraries/configuration/ReserveConfiguration.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';

/**
 * @title PoolConfigurator
 * @author Aave
 * @dev Implements the configuration methods for the Aave protocol
 */
abstract contract PoolConfigurator is PoolManager, Initializable, IPoolConfigurator {
  using PercentageMath for uint256;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  IPoolAddressesProvider internal _addressesProvider;

  function initialize(IPoolAddressesProvider provider) public reinitializer(1) {
    _addressesProvider = provider;
  }

  // @inheritdoc IPoolConfigurator
  function initReserves(
    address pool,
    ConfiguratorInputTypes.InitReserveInput[] calldata input
  ) external onlyPoolAdmin(pool) {
    IPool cachedPool = IPool(pool);
    for (uint256 i = 0; i < input.length; i++) {
      ConfiguratorLogic.executeInitReserve(cachedPool, input[i]);
    }
  }

  // @inheritdoc IPoolConfigurator
  function setReserveBorrowing(
    address pool,
    address asset,
    bool enabled
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    if (!enabled) {
      require(!currentConfig.getStableRateBorrowingEnabled(), Errors.STABLE_BORROWING_ENABLED);
    }
    currentConfig.setBorrowingEnabled(enabled);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveBorrowing(asset, enabled);
  }

  // @inheritdoc IPoolConfigurator
  function configureReserveAsCollateral(
    address pool,
    address asset,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);

    //validation of the parameters: the LTV can
    //only be lower or equal than the liquidation threshold
    //(otherwise a loan against the asset would cause instantaneous liquidation)
    require(ltv <= liquidationThreshold, Errors.INVALID_RESERVE_PARAMS);

    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);

    if (liquidationThreshold != 0) {
      //liquidation bonus must be bigger than 100.00%, otherwise the liquidator would receive less
      //collateral than needed to cover the debt
      require(liquidationBonus > PercentageMath.PERCENTAGE_FACTOR, Errors.INVALID_RESERVE_PARAMS);

      //if threshold * bonus is less than PERCENTAGE_FACTOR, it's guaranteed that at the moment
      //a loan is taken there is enough collateral available to cover the liquidation bonus
      require(
        liquidationThreshold.percentMul(liquidationBonus) <= PercentageMath.PERCENTAGE_FACTOR,
        Errors.INVALID_RESERVE_PARAMS
      );
    } else {
      require(liquidationBonus == 0, Errors.INVALID_RESERVE_PARAMS);
      //if the liquidation threshold is being set to 0,
      // the reserve is being disabled as collateral. To do so,
      //we need to ensure no liquidity is supplied
      _checkNoSuppliers(pool, asset);
    }

    currentConfig.setLtv(ltv);
    currentConfig.setLiquidationThreshold(liquidationThreshold);
    currentConfig.setLiquidationBonus(liquidationBonus);

    cachedPool.setConfiguration(asset, currentConfig);

    emit CollateralConfigurationChanged(asset, ltv, liquidationThreshold, liquidationBonus);
  }

  // @inheritdoc IPoolConfigurator
  function setReserveFlashLoaning(
    address pool,
    address asset,
    bool enabled
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    currentConfig.setFlashLoanEnabled(enabled);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveFlashLoaning(asset, enabled);
  }

  // @inheritdoc IPoolConfigurator
  function setReserveActive(address pool, address asset, bool active) external onlyPoolAdmin(pool) {
    if (!active) _checkNoSuppliers(pool, asset);
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    currentConfig.setActive(active);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveActive(asset, active);
  }

  // @inheritdoc IPoolConfigurator
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
  function setReservePause(
    address pool,
    address asset,
    bool paused
  ) public onlyEmergencyOrPoolAdmin(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    currentConfig.setPaused(paused);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReservePaused(asset, paused);
  }

  // @inheritdoc IPoolConfigurator
  function setReserveFactor(
    address pool,
    address asset,
    uint256 newReserveFactor
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    require(newReserveFactor <= PercentageMath.PERCENTAGE_FACTOR, Errors.INVALID_RESERVE_FACTOR);
    DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(asset);
    uint256 oldReserveFactor = currentConfig.getReserveFactor();
    currentConfig.setReserveFactor(newReserveFactor);
    cachedPool.setConfiguration(asset, currentConfig);
    emit ReserveFactorChanged(asset, oldReserveFactor, newReserveFactor);
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
  ) external onlyRiskOrPoolAdmins(pool) {
    IPool cachedPool = IPool(pool);
    DataTypes.ReserveData memory reserve = cachedPool.getReserveData(asset);
    address oldRateStrategyAddress = reserve.interestRateStrategyAddress;
    // cachedPool.setConfiguration(asset, newRateStrategyAddress);
    emit ReserveInterestRateStrategyChanged(asset, oldRateStrategyAddress, newRateStrategyAddress);
  }

  function _checkNoSuppliers(address pool, address asset) internal view {
    (, uint256 accruedToTreasury, uint256 totalATokens, , , , , , ) = IPoolDataProvider(
      _addressesProvider.getPoolDataProvider()
    ).getReserveData(asset);

    require(totalATokens == 0 && accruedToTreasury == 0, Errors.RESERVE_LIQUIDITY_NOT_ZERO);
  }

  function _checkNoBorrowers(address pool, address asset) internal view {
    uint256 totalDebt = IPoolDataProvider(_addressesProvider.getPoolDataProvider()).getTotalDebt(
      asset
    );
    require(totalDebt == 0, Errors.RESERVE_DEBT_NOT_ZERO);
  }
}
