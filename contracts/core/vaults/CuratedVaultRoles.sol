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

import {DataTypes, IPool} from '../../interfaces/IPool.sol';

import {ICuratedVaultBase, ICuratedVaultStaticTyping} from '../../interfaces/vaults/ICuratedVaultStaticTyping.sol';

import {AccessControlEnumerableUpgradeable} from '@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol';

abstract contract CuratedVaultRoles is AccessControlEnumerableUpgradeable, ICuratedVaultStaticTyping {
  /// @dev the keccak256 hash of the guardian role.
  bytes32 public immutable GUARDIAN_ROLE = keccak256('GUARDIAN_ROLE');

  /// @dev the keccak256 hash of the curator role.
  bytes32 public immutable CURATOR_ROLE = keccak256('GUARDIAN_ROLE');

  /// @dev the keccak256 hash of the allocator role.
  bytes32 public immutable ALLOCATOR_ROLE = keccak256('GUARDIAN_ROLE');

  function __CuratedVaultRoles_init(address _owner) internal initializer {
    __AccessControlEnumerable_init();
    _setupRole(DEFAULT_ADMIN_ROLE, _owner);
  }

  /* MODIFIERS */

  /// @dev Reverts if the caller doesn't have the curator role.
  modifier onlyCuratorRole() {
    address sender = _msgSender();
    if (!isOwner(_msgSender()) && !isCurator(_msgSender())) revert NotGuardianRole();
    _;
  }

  /// @dev Reverts if the caller doesn't have the allocator role.
  modifier onlyAllocator() {
    address sender = _msgSender();
    if (!isOwner(_msgSender()) && !isAllocator(_msgSender())) {
      revert NotAllocatorRole();
    }
    _;
  }

  /// @dev Reverts if the caller doesn't have the guardian role.
  modifier onlyGuardian() {
    if (!isOwner(_msgSender()) && !isGuardian(_msgSender())) revert NotGuardianRole();
    _;
  }

  /// @dev Reverts if the caller is not eh default admin
  modifier onlyOwner() {
    if (!isOwner(_msgSender())) revert NotOwnerRole();
    _;
  }

  /// @dev Reverts if the caller doesn't have the curator nor the guardian role.
  modifier onlyCuratorOrGuardian() {
    if (!isOwner(_msgSender()) && !isCurator(_msgSender()) && !isGuardian(_msgSender())) {
      revert NotCuratorNorGuardianRole();
    }
    _;
  }

  function isCurator(address who) public view returns (bool) {
    return hasRole(CURATOR_ROLE, who);
  }

  function isGuardian(address who) public view returns (bool) {
    return hasRole(GUARDIAN_ROLE, who);
  }

  function isOwner(address who) public view returns (bool) {
    return hasRole(DEFAULT_ADMIN_ROLE, who);
  }

  /// @inheritdoc ICuratedVaultBase
  function isAllocator(address who) public view returns (bool) {
    return hasRole(ALLOCATOR_ROLE, who);
  }

  function grantCuratorRole(address who) public {
    _grantRole(CURATOR_ROLE, who);
  }

  function grantGuardianRole(address who) public {
    _grantRole(GUARDIAN_ROLE, who);
  }

  function grantOwnerRole(address who) public {
    _grantRole(DEFAULT_ADMIN_ROLE, who);
  }

  function grantAllocatorRole(address who) public {
    _grantRole(ALLOCATOR_ROLE, who);
  }

  function revokeCuratorRole(address who) public {
    _revokeRole(CURATOR_ROLE, who);
  }

  function revokeGuardianRole(address who) public {
    _revokeRole(GUARDIAN_ROLE, who);
  }

  function revokeOwnerRole(address who) public {
    _revokeRole(DEFAULT_ADMIN_ROLE, who);
  }

  function revokeAllocatorRole(address who) public {
    _revokeRole(ALLOCATOR_ROLE, who);
  }
}
