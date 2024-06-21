// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {BorrowLogic} from '../libraries/logic/BorrowLogic.sol';
import {DataTypes} from '../libraries/types/DataTypes.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {FlashLoanLogic} from '../libraries/logic/FlashLoanLogic.sol';
import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {IFactory} from '../../interfaces/IFactory.sol';
import {IHook} from '../../interfaces/IHook.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {LiquidationLogic} from '../libraries/logic/LiquidationLogic.sol';
import {PercentageMath} from '../libraries/math/PercentageMath.sol';
import {PoolGetters} from './PoolGetters.sol';
import {PoolLogic} from '../libraries/logic/PoolLogic.sol';
import {ReserveConfiguration} from '../libraries/configuration/ReserveConfiguration.sol';
import {SupplyLogic} from '../libraries/logic/SupplyLogic.sol';
import {TokenConfiguration} from '../libraries/configuration/TokenConfiguration.sol';

abstract contract Pool is Initializable, PoolGetters {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using PercentageMath for uint256;
  using TokenConfiguration for address;

  /**
   * @notice Initializes the Pool.
   * @dev This function is invoked by the factory contract when the Pool is created
   */
  function initialize(IPool.InitParams memory params) public virtual reinitializer(1) {
    _factory = IFactory(msg.sender);
    configurator = params.configurator;
    hook = IHook(params.hook);

    for (uint i = 0; i < params.assets.length; i++) {
      _setReserveConfiguration(
        params.assets[i],
        params.rateStrategyAddresses[i],
        params.sources[i],
        params.configurations[i]
      );

      PoolLogic.executeInitReserve(
        _reserves,
        _reservesList,
        DataTypes.InitReserveParams({
          asset: params.assets[i],
          interestRateStrategyAddress: params.rateStrategyAddresses[i],
          reservesCount: _reservesCount
        })
      );

      _reservesCount++;

      emit ReserveInitialized(params.assets[i], params.rateStrategyAddresses[i], params.sources[i]);
    }
  }

  /// @inheritdoc IPool
  function supply(
    address asset,
    uint256 amount,
    uint256 index,
    bytes calldata hookData
  ) public virtual override {
    bytes32 pos = msg.sender.getPositionId(index);
    if (address(hook) != address(0))
      hook.beforeSupply(msg.sender, pos, asset, address(this), amount, hookData);

    SupplyLogic.executeSupply(
      _reserves,
      _usersConfig[pos],
      _balances,
      _totalSupplies,
      IPool(this),
      DataTypes.ExecuteSupplyParams({asset: asset, amount: amount, position: pos})
    );

    if (address(hook) != address(0))
      hook.afterSupply(msg.sender, pos, asset, address(this), amount, hookData);
  }

  /// @inheritdoc IPool
  function withdraw(
    address asset,
    uint256 amount,
    address destination,
    uint256 index,
    bytes calldata hookData
  ) public virtual override returns (uint256 withdrawalAmount) {
    bytes32 pos = msg.sender.getPositionId(index);
    require(amount <= _balances[asset][pos].scaledSupplyBalance, 'Insufficient Balance!');

    if (address(hook) != address(0))
      hook.beforeWithdraw(msg.sender, pos, asset, address(this), amount, hookData);

    withdrawalAmount = SupplyLogic.executeWithdraw(
      _reserves,
      _reservesList,
      _usersConfig[pos],
      _balances,
      _totalSupplies,
      IPool(this),
      DataTypes.ExecuteWithdrawParams({
        destination: destination,
        asset: asset,
        amount: amount,
        position: pos,
        reservesCount: _reservesCount,
        pool: address(this)
      })
    );

    PoolLogic.executeMintToTreasury(_reserves, asset);

    if (address(hook) != address(0))
      hook.afterWithdraw(msg.sender, pos, asset, address(this), amount, hookData);
  }

  /// @inheritdoc IPool
  function borrow(
    address asset,
    uint256 amount,
    uint256 index,
    bytes calldata hookData
  ) public virtual override {
    bytes32 pos = msg.sender.getPositionId(index);
    if (address(hook) != address(0))
      hook.beforeBorrow(msg.sender, pos, asset, address(this), amount, hookData);

    BorrowLogic.executeBorrow(
      _reserves,
      _reservesList,
      _usersConfig[pos],
      _balances,
      _totalSupplies,
      DataTypes.ExecuteBorrowParams({
        asset: asset,
        user: msg.sender,
        position: pos,
        amount: amount,
        reservesCount: _reservesCount,
        pool: address(this)
      })
    );

    if (address(hook) != address(0))
      hook.afterBorrow(msg.sender, pos, asset, address(this), amount, hookData);
  }

  /// @inheritdoc IPool
  function repay(
    address asset,
    uint256 amount,
    uint256 index,
    bytes calldata hookData
  ) public virtual returns (uint256 paybackAmount) {
    bytes32 pos = msg.sender.getPositionId(index);
    if (address(hook) != address(0))
      hook.beforeRepay(msg.sender, pos, asset, address(this), amount, hookData);

    paybackAmount = BorrowLogic.executeRepay(
      _reserves,
      _balances,
      _totalSupplies,
      IPool(this),
      DataTypes.ExecuteRepayParams({asset: asset, amount: amount, user: msg.sender, position: pos})
    );

    if (address(hook) != address(0))
      hook.afterRepay(msg.sender, pos, asset, address(this), amount, hookData);
  }

  /// @inheritdoc IPool
  function liquidate(
    address collat,
    address debt,
    address user,
    uint256 debtAmt,
    uint256 index,
    bytes calldata data
  ) public virtual override {
    bytes32 pos = user.getPositionId(index);
    if (address(hook) != address(0))
      hook.beforeLiquidate(msg.sender, user, pos, collat, debt, debtAmt, address(this), data);

    LiquidationLogic.executeLiquidationCall(
      _reserves,
      _reservesList,
      _balances,
      _usersConfig,
      DataTypes.ExecuteLiquidationCallParams({
        reservesCount: _reservesCount,
        debtToCover: debtAmt,
        collateralAsset: collat,
        debtAsset: debt,
        position: pos,
        pool: address(this)
      })
    );

    if (address(hook) != address(0))
      hook.afterLiquidate(msg.sender, user, pos, collat, debt, debtAmt, address(this), data);
  }

  /// @inheritdoc IPool
  function flashLoan(
    address receiverAddress,
    address asset,
    uint256 amount,
    bytes calldata params
  ) public virtual override {
    DataTypes.FlashloanSimpleParams memory flashParams = DataTypes.FlashloanSimpleParams({
      receiverAddress: receiverAddress,
      asset: asset,
      amount: amount,
      params: params,
      flashLoanPremiumTotal: _factory.flashLoanPremiumToProtocol()
    });
    FlashLoanLogic.executeFlashLoanSimple(address(this), _reserves[asset], flashParams);
  }

  // @inheritdoc IPool
  function _setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap memory config
  ) internal {
    require(asset != address(0), Errors.ZERO_ADDRESS_NOT_VALID);
    require(_reserves[asset].id != 0 || _reservesList[0] == asset, Errors.ASSET_NOT_LISTED);
    _reserves[asset].configuration = config;
    _reserves[asset].interestRateStrategyAddress = rateStrategyAddress;
    _assetsSources[asset] = IAggregatorInterface(source);

    // validation of the parameters: the LTV can
    // only be lower or equal than the liquidation threshold
    // (otherwise a loan against the asset would cause instantaneous liquidation)
    require(config.getLtv() <= config.getLiquidationThreshold(), Errors.INVALID_RESERVE_PARAMS);

    if (config.getLiquidationThreshold() != 0) {
      // liquidation bonus must be bigger than 100.00%, otherwise the liquidator would receive less
      // collateral than needed to cover the debt
      require(
        config.getLiquidationBonus() > PercentageMath.PERCENTAGE_FACTOR,
        Errors.INVALID_RESERVE_PARAMS
      );

      // if threshold * bonus is less than PERCENTAGE_FACTOR, it's guaranteed that at the moment
      // a loan is taken there is enough collateral available to cover the liquidation bonus
      require(
        config.getLiquidationThreshold().percentMul(config.getLiquidationBonus()) <=
          PercentageMath.PERCENTAGE_FACTOR,
        Errors.INVALID_RESERVE_PARAMS
      );

      emit CollateralConfigurationChanged(
        asset,
        config.getLtv(),
        config.getLiquidationThreshold(),
        config.getLiquidationThreshold()
      );
    }
  }

  function setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap calldata configuration
  ) external virtual {
    require(msg.sender == address(_factory.configurator()), 'only configurator');
    _setReserveConfiguration(asset, rateStrategyAddress, source, configuration);
  }
}
