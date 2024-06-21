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
  event FlashLoanPremiumToProtocolUpdated(
    uint256 indexed old,
    uint256 indexed updated,
    address owner
  );

  function configurator() external returns (IPoolConfigurator);

  function createPool(IPool.InitParams memory params) external returns (IPool pool);

  function flashLoanPremiumToProtocol() external returns (uint256);

  function pools(uint256 index) external returns (IPool);

  function poolsLength() external view returns (uint256);

  function reserveFactor() external returns (uint256);

  function setFlashloanPremium(uint256 updated) external;

  function setImplementation(address updated) external;

  function setReserveFactor(uint256 updated) external;

  function setTreasury(address updated) external;

  function treasury() external returns (address);
}
