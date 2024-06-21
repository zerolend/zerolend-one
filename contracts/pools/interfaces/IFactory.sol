// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';
import {IPool} from './IPool.sol';
import {IPoolConfigurator} from './IPoolConfigurator.sol';

interface IFactory is IBeacon {
  event PoolCreated(IPool indexed pool, uint256 indexed index, address creator);
  event ImplementationUpdated(address indexed old, address indexed updated, address owner);
  event TreasuryUpdated(address indexed old, address indexed updated, address owner);
  event ReserveFactorUpdated(uint256 indexed old, uint256 indexed updated, address owner);

  function configurator() external returns (IPoolConfigurator);

  function createPool(IPool.InitParams memory params) external returns (IPool pool);

  function pools(uint256 index) external returns (IPool);

  function poolsLength() external view returns (uint256);

  function reserveFactor() external returns (uint256);

  function setImplementation(address impl) external;

  function setReserveFactor(uint256 factor) external;

  function setTreasury(address _treasury) external;

  function treasury() external returns (address);
}
