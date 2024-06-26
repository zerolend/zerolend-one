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

import {BeaconProxy} from '../../core/protocol/factory/BeaconProxy.sol';
import {IBeacon, IPoolERC4626Vault, IERC4626Factory} from '../interfaces/IERC4626Factory.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract ERC4626Factory is Ownable, IERC4626Factory {
  /// @inheritdoc IBeacon
  address public implementation;

  /// @inheritdoc IERC4626Factory
  mapping(address => bool) public isVault;

  /// @inheritdoc IERC4626Factory
  IPoolERC4626Vault[] public vaults;

  constructor(address _implementation) {
    implementation = _implementation;
  }

  /// @inheritdoc IERC4626Factory
  function vaultsLength() external view returns (uint256) {
    return vaults.length;
  }

  /// @inheritdoc IERC4626Factory
  function createVault(address pool, address token) external returns (IPoolERC4626Vault vault) {
    // create the pool
    vault = IPoolERC4626Vault(address(new BeaconProxy(address(this), msg.sender)));
    vault.initialize(pool, token);

    // track the pool
    vaults.push(vault);
    isVault[address(vault)] = true;
    emit VaultCreated(vault, vaults.length, msg.sender);
  }

  /// @inheritdoc IERC4626Factory
  function setImplementation(address impl) external onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }
}
