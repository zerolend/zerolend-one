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

import {Address} from '@openzeppelin/contracts/utils/Address.sol';
import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';
import {Proxy} from '@openzeppelin/contracts/proxy/Proxy.sol';
import {StorageSlot} from '@openzeppelin/contracts/utils/StorageSlot.sol';

/**
 * @title A beacon proxy with the ability to have it's upgradability revoked
 * @author ZeroLend
 * @notice This is a beacon proxy contract that has the ability for the proxy admin to revoke
 * the beacon's ability to upgrade the contract.
 */
contract RevokableBeaconProxy is Proxy {
  bytes32 internal constant _IMPLEMENTATION_SLOT = keccak256('eip1967.proxy.impl');
  bytes32 internal constant _BEACON_SLOT = keccak256('eip1967.proxy.beacon');
  bytes32 internal constant _ADMIN_SLOT = keccak256('eip1967.proxy.admin');

  constructor(address _beacon, address _admin) {
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = _beacon;
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = _admin;
  }

  // todo add events for admin and implementation changes

  /**
   * @inheritdoc Proxy
   */
  function _implementation() internal view virtual override returns (address) {
    address _beacon = _getBeacon();
    if (_beacon != address(0)) return IBeacon(_beacon).implementation();

    // if beacon was revoked, the use the last implementation
    return _getFrozenImpl();
  }

  /**
   * @notice Transfer the ownership of the proxy to another address
   * @dev Can only be called by the proxy admin
   * @param newAdmin The new admin to transfer ownership to
   */
  function setAdmin(address newAdmin) external {
    require(msg.sender == _getAdmin(), 'not proxy admin');
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = newAdmin;
  }

  /**
   * @notice Revokes the beacon's ability to upgrade this contract and forver seals the implementation
   * into the code forever.
   * @dev Can only be called by the proxy admin
   */
  function revokeBeacon() external {
    require(msg.sender == _getAdmin(), 'not proxy admin');
    _revokeBeacon();
  }

  /**
   * @notice Revoke the beacon's admin
   * @dev Can only be called by the proxy admin
   */
  function revokeAdmin() external {
    require(msg.sender == _getAdmin(), 'not proxy admin');
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = address(0);
  }

  /**
   * @notice Returns the implementation of the current proxy
   * @return The proxy's current implementation
   */
  function implementation() external view returns (address) {
    return _implementation();
  }

  function admin() external view returns (address) {
    return _getAdmin();
  }

  function beacon() external view returns (address) {
    return _getBeacon();
  }

  /**
   * @notice Checks if the beacon is revoked in which case the contract is as good as immutable.
   * @dev The revoked implementation address can be found in the `implementation()` call.
   * @return revoked True iff the beacon has been revoked.
   */
  function isBeaconRevoked() external view returns (bool revoked) {
    revoked = _getBeacon() == address(0);
  }

  function _getBeacon() private view returns (address) {
    return StorageSlot.getAddressSlot(_BEACON_SLOT).value;
  }

  function _getAdmin() private view returns (address) {
    return StorageSlot.getAddressSlot(_ADMIN_SLOT).value;
  }

  function _getFrozenImpl() private view returns (address) {
    return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
  }

  /**
   * @notice Stores a new beacon in the EIP1967 beacon slot.
   */
  function _setBeacon(address newBeacon) private {
    require(Address.isContract(newBeacon), '!beacon');
    require(Address.isContract(IBeacon(newBeacon).implementation()), '!implementation');
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = newBeacon;
  }

  /**
   * @notice Revokes the beacon implementation and stores the implementation
   * forever into the storage.
   */
  function _revokeBeacon() private {
    address impl = _implementation();
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = address(0);
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = address(0);
    StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = impl;
  }
}
