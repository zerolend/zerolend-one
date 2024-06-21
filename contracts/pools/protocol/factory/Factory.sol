// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IFactory, IBeacon, IPoolConfigurator, IPool} from '../../interfaces/IFactory.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {BeaconProxy} from './BeaconProxy.sol';

contract Factory is IFactory, Ownable {
  /// @inheritdoc IBeacon
  address public implementation;

  /// @inheritdoc IFactory
  address public treasury;

  /// @inheritdoc IFactory
  address public rewardsController;

  /// @inheritdoc IFactory
  IPool[] public pools;

  /// @inheritdoc IFactory
  IPoolConfigurator public configurator;

  /// @inheritdoc IFactory
  uint256 public reserveFactor;

  /// @inheritdoc IFactory
  uint256 public flashLoanPremiumToProtocol;

  constructor(address _implementation, address _configurator) {
    implementation = _implementation;
    configurator = IPoolConfigurator(_configurator);
    treasury = msg.sender;

    // give some of the master roles (pool = address(0x0)) to the msg.sender
    configurator.initRoles(address(0), msg.sender);
  }

  /// @inheritdoc IFactory
  function poolsLength() external view returns (uint256) {
    return pools.length;
  }

  /// @inheritdoc IFactory
  function createPool(IPool.InitParams memory params) external returns (IPool pool) {
    // create the pool
    pool = IPool(address(new BeaconProxy(address(this), msg.sender)));
    pool.initialize(params);

    // give roles to the user
    configurator.initRoles(address(pool), msg.sender);

    // track the pool
    pools.push(pool);
    emit PoolCreated(pool, pools.length, msg.sender);

    // TODO: once pool is created ask users to deposit some funds to
    // set the liquidity index properly
  }

  /// @inheritdoc IFactory
  function setImplementation(address impl) external onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }

  /// @inheritdoc IFactory
  function setTreasury(address _treasury) external onlyOwner {
    address old = treasury;
    treasury = _treasury;
    emit TreasuryUpdated(old, _treasury, msg.sender);
  }

  /// @inheritdoc IFactory
  function setReserveFactor(uint256 updated) external onlyOwner {
    uint256 old = reserveFactor;
    reserveFactor = updated;
    emit ReserveFactorUpdated(old, updated, msg.sender);
  }

  /// @inheritdoc IFactory
  function setRewardsController(address _controller) external onlyOwner {
    address old = rewardsController;
    rewardsController = _controller;
    emit RewardsControllerUpdated(old, _controller, msg.sender);
  }

  /// @inheritdoc IFactory
  function setFlashloanPremium(uint256 updated) external onlyOwner {
    uint256 old = flashLoanPremiumToProtocol;
    flashLoanPremiumToProtocol = updated;
    emit FlashLoanPremiumToProtocolUpdated(old, updated, msg.sender);
  }
}
