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

import {DataTypes} from '../libraries/types/DataTypes.sol';
import {IFactory} from '../../interfaces/IFactory.sol';
import {IHook} from '../../interfaces/IHook.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {PoolGetters} from './PoolGetters.sol';
import {PoolLogic} from '../libraries/logic/PoolLogic.sol';
import {PoolSetters} from './PoolSetters.sol';

contract Pool is Initializable, PoolSetters {
  /**
   * @notice Initializes the Pool.
   * @dev This function is invoked by the factory contract when the Pool is created
   */
  function initialize(IPool.InitParams memory params) public virtual reinitializer(1) {
    _factory = IFactory(msg.sender);
    _hook = IHook(params.hook);

    require(params.assets.length >= 2, 'not enough assets');

    for (uint i = 0; i < params.assets.length; i++) {
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
  }

  /// @inheritdoc IPool
  function supply(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _supply(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function supply(address asset, uint256 amount, uint256 index) public virtual override {
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
  function withdraw(
    address asset,
    uint256 amount,
    uint256 index
  ) public virtual override returns (uint256) {
    return
      _withdraw(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function borrow(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _borrow(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function borrow(address asset, uint256 amount, uint256 index) public virtual override {
    _borrow(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function repay(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual returns (uint256) {
    return _repay(asset, amount, index, data);
  }

  /// @inheritdoc IPool
  function repay(address asset, uint256 amount, uint256 index) public virtual returns (uint256) {
    return _repay(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  /// @inheritdoc IPool
  function liquidate(
    address collat,
    address debt,
    bytes32 pos,
    uint256 debtAmt,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _liquidate(collat, debt, pos, debtAmt, data);
  }

  /// @inheritdoc IPool
  function liquidate(
    address collat,
    address debt,
    bytes32 pos,
    uint256 debtAmt
  ) public virtual override {
    _liquidate(
      collat,
      debt,
      pos,
      debtAmt,
      DataTypes.ExtraData({interestRateData: '', hookData: ''})
    );
  }

  /// @inheritdoc IPool
  function flashLoan(
    address receiverAddress,
    address asset,
    uint256 amount,
    bytes calldata params
  ) public virtual override {
    _flashLoan(receiverAddress, asset, amount, params);
  }

  /// @inheritdoc IPool
  function setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap calldata configuration
  ) external virtual {
    require(msg.sender == address(_factory.configurator()), 'only configurator');
    PoolLogic.setReserveConfiguration(_reserves, asset, rateStrategyAddress, source, configuration);
  }
}
