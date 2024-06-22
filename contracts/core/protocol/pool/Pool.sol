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
    hook = IHook(params.hook);

    require(params.assets.length >= 2, 'not enough assets');
    require(params.rateStrategyAddresses.length == params.assets.length, '!length');
    require(params.sources.length == params.assets.length, '!length');
    require(params.configurations.length == params.assets.length, '!length');

    for (uint i = 0; i < params.assets.length; i++) {
      require(params.assets[i] != address(0), 'invalid asset');
      require(params.sources[i] != address(0), 'invalid oracle');
      require(params.rateStrategyAddresses[i] != address(0), 'invalid strategy');

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
          oracle: params.sources[i],
          reservesCount: _reservesCount
        })
      );

      _reservesCount++;

      emit ReserveInitialized(params.assets[i], params.rateStrategyAddresses[i], params.sources[i]);
    }
  }

  //// @inheritdoc IPool
  function supply(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _supply(asset, amount, index, data);
  }

  function supply(address asset, uint256 amount, uint256 index) public virtual override {
    _supply(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  //// @inheritdoc IPool
  function withdraw(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override returns (uint256) {
    return _withdraw(asset, amount, index, data);
  }

  function withdraw(
    address asset,
    uint256 amount,
    uint256 index
  ) public virtual override returns (uint256) {
    return
      _withdraw(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  //// @inheritdoc IPool
  function borrow(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual override {
    _borrow(asset, amount, index, data);
  }

  function borrow(address asset, uint256 amount, uint256 index) public virtual override {
    _borrow(asset, amount, index, DataTypes.ExtraData({interestRateData: '', hookData: ''}));
  }

  //// @inheritdoc IPool
  function repay(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) public virtual returns (uint256) {
    return _repay(asset, amount, index, data);
  }

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
    _setReserveConfiguration(asset, rateStrategyAddress, source, configuration);
  }
}
