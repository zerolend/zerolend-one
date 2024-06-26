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
import {ICuratedVault} from './ICuratedVault.sol';

interface ICuratedVaultFactory is IBeacon {
  event VaultCreated(ICuratedVault indexed vault, uint256 indexed index, address creator);
  event ImplementationUpdated(address indexed old, address indexed updated, address owner);

  function createVault(
    address initialOwner,
    uint256 initialTimelock,
    address asset,
    string memory name,
    string memory symbol,
    bytes32 salt
  ) external returns (ICuratedVault pool);

  function vaults(uint256 index) external view returns (ICuratedVault);

  function isVault(address vault) external view returns (bool);

  function vaultsLength() external view returns (uint256);

  function setImplementation(address updated) external;
}
