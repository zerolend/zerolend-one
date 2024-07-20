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

import {IBeacon, ICuratedVault, ICuratedVaultFactory} from '../../interfaces/vaults/ICuratedVaultFactory.sol';
import {RevokableBeaconProxy} from '../proxy/RevokableBeaconProxy.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

/// @title CuratedVaultFactory
/// @author ZeroLend
/// @notice Creates and tracks CuratedVaults.
contract CuratedVaultFactory is ICuratedVaultFactory, Ownable {
  /// @inheritdoc IBeacon
  address public implementation;

  /// @inheritdoc ICuratedVaultFactory
  ICuratedVault[] public vaults;

  /// @inheritdoc ICuratedVaultFactory
  mapping(address => bool) public isVault;

  /**
   * Initializes the factory with the implementation of the vaults.
   * @param _implementation The address of the implementation contract.
   */
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
  ) external returns (ICuratedVault vault) {
    // create the vault
    vault = ICuratedVault(address(new RevokableBeaconProxy{salt: salt}(address(this), initialProxyOwner)));
    emit VaultCreated(vault, vaults.length, msg.sender, initialOwner, initialProxyOwner, initialTimelock, asset, name, symbol, salt);

    vault.initialize(initialOwner, initialTimelock, asset, name, symbol);

    // track the vault
    vaults.push(vault);
    isVault[address(vault)] = true;
  }

  /// @inheritdoc ICuratedVaultFactory
  function setImplementation(address impl) external onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }
}
