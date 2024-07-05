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

import {IPool} from '../IPool.sol';
import {ICuratedVaultBase} from './ICuratedVaultBase.sol';

/// @dev This interface is inherited by ZeroLend so that function signatures are checked by the compiler.
/// @dev Consider using the ICuratedVault interface instead of this one.
interface ICuratedVaultStaticTyping is ICuratedVaultBase {
  /// @notice Returns the current configuration of each market.
  function config(IPool) external view returns (uint184 cap, bool enabled, uint64 removableAt);

  /// @notice Returns the pending guardian.
  function pendingGuardian() external view returns (address guardian, uint64 validAt);

  /// @notice Returns the pending cap for each market.
  function pendingCap(IPool) external view returns (uint192 value, uint64 validAt);

  /// @notice Returns the pending timelock.
  function pendingTimelock() external view returns (uint192 value, uint64 validAt);

  /// @notice Initializes the vault with the initial owner and timelock.
  /// @dev Called only by the factory contract
  function initialize(address initialOwner, uint256 initialTimelock, address asset, string memory name, string memory symbol) external;
}
