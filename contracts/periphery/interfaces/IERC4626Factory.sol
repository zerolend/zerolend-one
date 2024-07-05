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

import {IPoolERC4626Vault} from './IPoolERC4626Vault.sol';
import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';

interface IERC4626Factory is IBeacon {
  event ImplementationUpdated(address indexed old, address indexed updated, address owner);
  event VaultCreated(IPoolERC4626Vault indexed vault, uint256 indexed index, address creator);

  function createVault(address pool, address token) external returns (IPoolERC4626Vault vault);

  function vaults(uint256 index) external view returns (IPoolERC4626Vault);

  function setImplementation(address updated) external;

  function vaultsLength() external view returns (uint256);

  function isVault(address pool) external view returns (bool);
}
