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

import {DataTypes} from '../libraries/types/DataTypes.sol';
import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {IFactory} from '../../interfaces/IFactory.sol';
import {IHook} from '../../interfaces/IHook.sol';

contract PoolStorage {
  /// @notice Map of reserves and their data (underlyingAssetOfReserve => reserveData)
  mapping(address asset => DataTypes.ReserveData data) internal _reserves;

  /// @notice Map of positions and their configuration data (userAddress => userConfiguration)
  mapping(bytes32 position => DataTypes.UserConfigurationMap config) internal _usersConfig;

  /// @notice Map of position's individual balances
  mapping(address reserve => mapping(bytes32 position => DataTypes.PositionBalance balance))
    internal _balances;

  /// @notice Map of total supply of tokens
  mapping(address reserve => DataTypes.ReserveSupplies totalSupply) internal _totalSupplies;

  /// @notice List of reserves as a map (reserveId => reserve).
  /// It is structured as a mapping for gas savings reasons, using the reserve id as index
  mapping(uint256 reserveId => address reserve) internal _reservesList;

  /// @notice Number of active reserves in the pool
  uint16 internal _reservesCount;

  /// @notice Map of asset price sources (asset => priceSource)
  mapping(address reserve => IAggregatorInterface oracle) internal _assetsSources;

  /// @notice The pool configurator contract that can make changes
  address public configurator;

  /// @notice The original factory contract with protocol-level control variables
  IFactory internal _factory;

  /// @notice The assigned hook for this pool
  IHook internal _hook;
}
