// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.12;

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
import {VersionedInitializable} from '../../libraries/aave-upgradeability/VersionedInitializable.sol';

/**
 * @title PoolConfigurator
 * @author Aave
 * @dev Implements the configuration methods for the Aave protocol
 */
contract PoolConfigurator is PoolManager, VersionedInitializable, IPoolConfigurator {
  using PercentageMath for uint256;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  IPoolAddressesProvider internal _addressesProvider;
  IPool internal _pool;

  uint256 public constant CONFIGURATOR_REVISION = 0x4;

  /// @inheritdoc VersionedInitializable
  function getRevision() internal pure virtual override returns (uint256) {
    return CONFIGURATOR_REVISION;
  }

  function initialize(IPoolAddressesProvider provider) public initializer {
    _addressesProvider = provider;
    _pool = IPool(_addressesProvider.getPool());
  }

  /// @inheritdoc IPoolConfigurator
  function initReserves(
    address pool,
    ConfiguratorInputTypes.InitReserveInput[] calldata input
  ) external override onlyPoolAdmin(pool) {
    IPool cachedPool = _pool;
    for (uint256 i = 0; i < input.length; i++) {
      ConfiguratorLogic.executeInitReserve(cachedPool, input[i]);
    }
  }

  /// @inheritdoc IPoolConfigurator
  function updateAToken(
    address pool,
    ConfiguratorInputTypes.UpdateATokenInput calldata input
  ) external override onlyPoolAdmin(pool) {
    ConfiguratorLogic.executeUpdateAToken(_pool, input);
  }

  /// @inheritdoc IPoolConfigurator
  function updateVariableDebtToken(
    address pool,
    ConfiguratorInputTypes.UpdateDebtTokenInput calldata input
  ) external override onlyPoolAdmin(pool) {
    ConfiguratorLogic.executeUpdateVariableDebtToken(_pool, input);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveBorrowing(
    address pool,
    address asset,
    bool enabled
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    if (!enabled) {
      require(!currentConfig.getStableRateBorrowingEnabled(), Errors.STABLE_BORROWING_ENABLED);
    }
    currentConfig.setBorrowingEnabled(enabled);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveBorrowing(asset, enabled);
  }

  /// @inheritdoc IPoolConfigurator
  function configureReserveAsCollateral(
    address pool,
    address asset,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus
  ) external override onlyRiskOrPoolAdmins(pool) {
    //validation of the parameters: the LTV can
    //only be lower or equal than the liquidation threshold
    //(otherwise a loan against the asset would cause instantaneous liquidation)
    require(ltv <= liquidationThreshold, Errors.INVALID_RESERVE_PARAMS);

    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);

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
      _checkNoSuppliers(asset);
    }

    currentConfig.setLtv(ltv);
    currentConfig.setLiquidationThreshold(liquidationThreshold);
    currentConfig.setLiquidationBonus(liquidationBonus);

    _pool.setConfiguration(asset, currentConfig);

    emit CollateralConfigurationChanged(asset, ltv, liquidationThreshold, liquidationBonus);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveStableRateBorrowing(
    address pool,
    address asset,
    bool enabled
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    if (enabled) {
      require(currentConfig.getBorrowingEnabled(), Errors.BORROWING_NOT_ENABLED);
    }
    currentConfig.setStableRateBorrowingEnabled(enabled);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveStableRateBorrowing(asset, enabled);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveFlashLoaning(
    address pool,
    address asset,
    bool enabled
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);

    currentConfig.setFlashLoanEnabled(enabled);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveFlashLoaning(asset, enabled);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveActive(
    address pool,
    address asset,
    bool active
  ) external override onlyPoolAdmin(pool) {
    if (!active) _checkNoSuppliers(asset);
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    currentConfig.setActive(active);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveActive(asset, active);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveFreeze(
    address pool,
    address asset,
    bool freeze
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    currentConfig.setFrozen(freeze);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveFrozen(asset, freeze);
  }

  /// @inheritdoc IPoolConfigurator
  function setReservePause(
    address pool,
    address asset,
    bool paused
  ) public override onlyEmergencyOrPoolAdmin(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    currentConfig.setPaused(paused);
    _pool.setConfiguration(asset, currentConfig);
    emit ReservePaused(asset, paused);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveFactor(
    address pool,
    address asset,
    uint256 newReserveFactor
  ) external override onlyRiskOrPoolAdmins(pool) {
    require(newReserveFactor <= PercentageMath.PERCENTAGE_FACTOR, Errors.INVALID_RESERVE_FACTOR);
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    uint256 oldReserveFactor = currentConfig.getReserveFactor();
    currentConfig.setReserveFactor(newReserveFactor);
    _pool.setConfiguration(asset, currentConfig);
    emit ReserveFactorChanged(asset, oldReserveFactor, newReserveFactor);
  }

  /// @inheritdoc IPoolConfigurator
  function setBorrowCap(
    address pool,
    address asset,
    uint256 newBorrowCap
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    uint256 oldBorrowCap = currentConfig.getBorrowCap();
    currentConfig.setBorrowCap(newBorrowCap);
    _pool.setConfiguration(asset, currentConfig);
    emit BorrowCapChanged(asset, oldBorrowCap, newBorrowCap);
  }

  /// @inheritdoc IPoolConfigurator
  function setSupplyCap(
    address pool,
    address asset,
    uint256 newSupplyCap
  ) external override onlyRiskOrPoolAdmins {
    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(asset);
    uint256 oldSupplyCap = currentConfig.getSupplyCap();
    currentConfig.setSupplyCap(newSupplyCap);
    _pool.setConfiguration(asset, currentConfig);
    emit SupplyCapChanged(asset, oldSupplyCap, newSupplyCap);
  }

  /// @inheritdoc IPoolConfigurator
  function setReserveInterestRateStrategyAddress(
    address pool,
    address asset,
    address newRateStrategyAddress
  ) external override onlyRiskOrPoolAdmins(pool) {
    DataTypes.ReserveData memory reserve = _pool.getReserveData(asset);
    address oldRateStrategyAddress = reserve.interestRateStrategyAddress;
    _pool.setReserveInterestRateStrategyAddress(asset, newRateStrategyAddress);
    emit ReserveInterestRateStrategyChanged(asset, oldRateStrategyAddress, newRateStrategyAddress);
  }

  function _checkNoSuppliers(address asset) internal view {
    (, uint256 accruedToTreasury, uint256 totalATokens, , , , , , , , , ) = IPoolDataProvider(
      _addressesProvider.getPoolDataProvider()
    ).getReserveData(asset);

    require(totalATokens == 0 && accruedToTreasury == 0, Errors.RESERVE_LIQUIDITY_NOT_ZERO);
  }

  function _checkNoBorrowers(address asset) internal view {
    uint256 totalDebt = IPoolDataProvider(_addressesProvider.getPoolDataProvider()).getTotalDebt(
      asset
    );
    require(totalDebt == 0, Errors.RESERVE_DEBT_NOT_ZERO);
  }
}
