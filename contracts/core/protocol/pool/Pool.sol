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

import {IHook} from '../../interfaces/IHook.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {IPoolFactory} from '../../interfaces/IPoolFactory.sol';
import {PoolGetters} from './PoolGetters.sol';

import {PoolSetters} from './PoolSetters.sol';
import {DataTypes} from './configuration/DataTypes.sol';
import {PoolLogic} from './logic/PoolLogic.sol';

contract Pool is PoolSetters {
  /**
   * @notice Initializes the Pool.
   * @dev This function is invoked by the factory contract when the Pool is created
   */
  function initialize(DataTypes.InitPoolParams memory params) public virtual reinitializer(1) {
    _factory = IPoolFactory(msg.sender);
    _hook = IHook(params.hook);

    require(params.assets.length >= 2, 'not enough assets');

    for (uint256 i = 0; i < params.assets.length; i++) {
      PoolLogic.executeInitReserve(
        _reserves,
        _reservesList,
        DataTypes.InitReserveParams({
          asset: params.assets[i],
          interestRateStrategyAddress: params.rateStrategyAddresses[i],
          oracle: params.sources[i],
          reservesCount: _reservesCount,
          configuration: params.configurations[i]
        })
      );

      _reservesCount++;
    }

    __PoolRentrancyGuard_init();
  }

  /// @inheritdoc IPool
  function supply(address asset, uint256 amount, uint256 index, DataTypes.ExtraData memory data) public virtual override {
    _supply(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function supplySimple(address asset, uint256 amount, uint256 index) public virtual override {
    _supply(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function withdraw(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override returns (uint256) {
    return _withdraw(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function withdrawSimple(address asset, uint256 amount, uint256 index) public virtual override returns (uint256) {
    return _withdraw(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function borrow(address asset, uint256 amount, uint256 index, DataTypes.ExtraData memory data) public virtual override {
    _borrow(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function borrowSimple(address asset, uint256 amount, uint256 index) public virtual override {
    _borrow(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function repay(address asset, uint256 amount, uint256 index, DataTypes.ExtraData memory data) public virtual returns (uint256) {
    return _repay(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function repaySimple(address asset, uint256 amount, uint256 index) public virtual returns (uint256) {
    return _repay(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function liquidate(address collat, address debt, bytes32 pos, uint256 debtAmt, DataTypes.ExtraData memory data) public virtual override {
    _liquidate(collat, debt, pos, debtAmt, data);
  }

  /// @inheritdoc IPool
  function liquidateSimple(address collat, address debt, bytes32 pos, uint256 debtAmt) public virtual override {
    _liquidate(collat, debt, pos, debtAmt, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function flashLoan(
    address receiverAddress,
    address asset,
    uint256 amount,
    bytes calldata params,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _flashLoan(receiverAddress, asset, amount, params, data);
  }

  /// @inheritdoc IPool
  function flashLoanSimple(address receiverAddress, address asset, uint256 amount, bytes calldata params) public virtual override {
    _flashLoan(receiverAddress, asset, amount, params, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function setReserveConfiguration(
    address asset,
    address rateStrategy,
    address source,
    DataTypes.ReserveConfigurationMap calldata config
  ) external virtual {
    require(msg.sender == address(_factory.configurator()), 'only configurator');
    PoolLogic.setReserveConfiguration(_reserves, asset, rateStrategy, source, config);
  }
}
