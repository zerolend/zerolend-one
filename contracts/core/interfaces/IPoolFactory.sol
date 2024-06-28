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

import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';
import {IPool} from './IPool.sol';
import {DataTypes} from '../protocol/libraries/types/DataTypes.sol';
import {IPoolConfigurator} from './IPoolConfigurator.sol';

interface IPoolFactory is IBeacon {
  event PoolCreated(IPool indexed pool, uint256 indexed index, address creator);
  event ImplementationUpdated(address indexed old, address indexed updated, address owner);
  event TreasuryUpdated(address indexed old, address indexed updated, address owner);
  event ReserveFactorUpdated(uint256 indexed old, uint256 indexed updated, address owner);
  event ConfiguratorUpdated(address indexed old, address indexed updated, address owner);
  event RewardsControllerUpdated(address indexed old, address indexed updated, address owner);
  event FlashLoanPremiumToProtocolUpdated(
    uint256 indexed old,
    uint256 indexed updated,
    address owner
  );

  function configurator() external view returns (IPoolConfigurator);

  function createPool(DataTypes.InitPoolParams memory params) external returns (IPool pool);

  function setConfigurator(address impl) external;

  function flashLoanPremiumToProtocol() external view returns (uint256);

  function liquidationProtocolFeePercentage() external view returns (uint256);

  function pools(uint256 index) external view returns (IPool);

  function isPool(address pool) external view returns (bool);

  function poolsLength() external view returns (uint256);

  function reserveFactor() external view returns (uint256);

  function rewardsController() external view returns (address);

  function setFlashloanPremium(uint256 updated) external;

  function setImplementation(address updated) external;

  function setReserveFactor(uint256 updated) external;

  function setRewardsController(address _controller) external;

  function setTreasury(address updated) external;

  function treasury() external view returns (address);
}
