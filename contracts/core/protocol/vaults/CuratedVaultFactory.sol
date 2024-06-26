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

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {BeaconProxy} from '../factory/BeaconProxy.sol';
import {ICuratedVaultFactory, ICuratedVault, IBeacon} from './interfaces/ICuratedVaultFactory.sol';

contract CuratedVaultFactory is ICuratedVaultFactory, Ownable {
  /// @inheritdoc IBeacon
  address public implementation;

  /// @inheritdoc ICuratedVaultFactory
  ICuratedVault[] public vaults;

  /// @inheritdoc ICuratedVaultFactory
  mapping(address => bool) public isVault;

  constructor(address _implementation) {
    implementation = _implementation;
  }

  /// @inheritdoc ICuratedVaultFactory
  function vaultsLength() external view returns (uint256) {
    return vaults.length;
  }

  /// @inheritdoc ICuratedVaultFactory
  function createVault(
    address initialOwner,
    address initialProxyOwner,
    uint256 initialTimelock,
    address asset,
    string memory name,
    string memory symbol,
    bytes32 salt
  ) external returns (ICuratedVault pool) {
    // create the pool
    pool = ICuratedVault(address(new BeaconProxy{salt: salt}(address(this), initialProxyOwner)));
    pool.initialize(initialOwner, initialTimelock, asset, name, symbol);

    // track the pool
    vaults.push(pool);
    isVault[address(pool)] = true;
    emit VaultCreated(pool, vaults.length, msg.sender);

    // TODO: once pool is created ask users to deposit some funds to
    // set the liquidity index properly
  }

  /// @inheritdoc ICuratedVaultFactory
  function setImplementation(address impl) external onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }
}
