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

import {DataTypes, IBeacon, IPool, IPoolConfigurator, IPoolFactory} from '../../interfaces/IPoolFactory.sol';

import {RevokableBeaconProxy} from '../proxy/RevokableBeaconProxy.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract PoolFactory is IPoolFactory, Ownable {
  /// @inheritdoc IBeacon
  address public implementation;

  /// @inheritdoc IPoolFactory
  address public treasury;

  /// @inheritdoc IPoolFactory
  address public rewardsController;

  /// @inheritdoc IPoolFactory
  IPool[] public pools;

  /// @inheritdoc IPoolFactory
  mapping(address => bool) public isPool;

  /// @inheritdoc IPoolFactory
  IPoolConfigurator public configurator;

  /// @inheritdoc IPoolFactory
  uint256 public reserveFactor;

  /// @inheritdoc IPoolFactory
  uint256 public flashLoanPremiumToProtocol;

  /// @inheritdoc IPoolFactory
  uint256 public liquidationProtocolFeePercentage;

  constructor(address _implementation) {
    implementation = _implementation;
    treasury = msg.sender;
  }

  /// @inheritdoc IPoolFactory
  function poolsLength() external view returns (uint256) {
    return pools.length;
  }

  /// @inheritdoc IPoolFactory
  function createPool(DataTypes.InitPoolParams memory params) external returns (IPool pool) {
    // create the pool
    pool = IPool(address(new RevokableBeaconProxy(address(this), msg.sender)));
    pool.initialize(params);

    // give roles to the user
    configurator.initRoles(address(pool), msg.sender);

    // track the pool
    pools.push(pool);
    isPool[address(pool)] = true;
    emit PoolCreated(pool, pools.length, msg.sender);

    // TODO: once pool is created ask users to deposit some funds to
    // set the liquidity index properly
  }

  /// @inheritdoc IPoolFactory
  function setImplementation(address impl) external onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }

  /// @inheritdoc IPoolFactory
  function setConfigurator(address impl) external onlyOwner {
    address old = address(configurator);
    configurator = IPoolConfigurator(impl);
    emit ConfiguratorUpdated(old, impl, msg.sender);

    // give some of the master roles (pool = address(0x0)) to the msg.sender
    configurator.initRoles(address(0), msg.sender);
  }

  /// @inheritdoc IPoolFactory
  function setTreasury(address _treasury) external onlyOwner {
    address old = treasury;
    treasury = _treasury;
    emit TreasuryUpdated(old, _treasury, msg.sender);
  }

  /// @inheritdoc IPoolFactory
  function setReserveFactor(uint256 updated) external onlyOwner {
    uint256 old = reserveFactor;
    reserveFactor = updated;
    emit ReserveFactorUpdated(old, updated, msg.sender);
  }

  /// @inheritdoc IPoolFactory
  function setRewardsController(address _controller) external onlyOwner {
    address old = rewardsController;
    rewardsController = _controller;
    emit RewardsControllerUpdated(old, _controller, msg.sender);
  }

  /// @inheritdoc IPoolFactory
  function setFlashloanPremium(uint256 updated) external onlyOwner {
    uint256 old = flashLoanPremiumToProtocol;
    flashLoanPremiumToProtocol = updated;
    emit FlashLoanPremiumToProtocolUpdated(old, updated, msg.sender);
  }
}
