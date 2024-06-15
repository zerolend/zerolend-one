// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (proxy/beacon/BeaconProxy.sol)

pragma solidity 0.8.19;

import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';
import {Proxy} from '@openzeppelin/contracts/proxy/Proxy.sol';
import {StorageSlot} from '@openzeppelin/contracts/utils/StorageSlot.sol';
import {Address} from '@openzeppelin/contracts/utils/Address.sol';

contract BeaconProxy is Proxy {
  bytes32 internal constant _IMPLEMENTATION_SLOT = keccak256('eip1967.proxy.impl');
  bytes32 internal constant _BEACON_SLOT = keccak256('eip1967.proxy.beacon');
  bytes32 internal constant _ADMIN_SLOT = keccak256('eip1967.proxy.admin');

  constructor(address _beacon, address _admin, bytes memory _data) payable {
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = _beacon;
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = _admin;
    if (_data.length > 0) Address.functionDelegateCall(IBeacon(_beacon).implementation(), _data);
  }

  /**
   * @dev Returns the current implementation address of the associated beacon.
   */
  function _implementation() internal view virtual override returns (address) {
    address _beacon = _getBeacon();
    if (_beacon != address(0)) return IBeacon(_beacon).implementation();

    // if beacon was revoked, the use the last implementation
    return _getFrozenImpl();
  }

  function setAdmin(address newAdmin) external {
    require(msg.sender == _getAdmin(), 'not proxy admin');
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = newAdmin;
  }

  function revokeBeacon() external {
    require(msg.sender == _getAdmin(), 'not proxy admin');
    _revokeBeacon();
  }

  function implementation() external view returns (address) {
    return _implementation();
  }

  function admin() external view returns (address) {
    return _getAdmin();
  }

  function beacon() external view returns (address) {
    return _getBeacon();
  }

  function _getBeacon() internal view returns (address) {
    return StorageSlot.getAddressSlot(_BEACON_SLOT).value;
  }

  function _getAdmin() internal view returns (address) {
    return StorageSlot.getAddressSlot(_ADMIN_SLOT).value;
  }

  function _getFrozenImpl() internal view returns (address) {
    return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
  }

  /**
   * @dev Stores a new beacon in the EIP1967 beacon slot.
   */
  function _setBeacon(address newBeacon) private {
    require(Address.isContract(newBeacon), 'ERC1967: new beacon is not a contract');
    require(
      Address.isContract(IBeacon(newBeacon).implementation()),
      'ERC1967: beacon implementation is not a contract'
    );
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = newBeacon;
  }

  function _revokeBeacon() private {
    address impl = _implementation();
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = address(0);
    StorageSlot.getAddressSlot(_ADMIN_SLOT).value = address(0);
    StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = impl;
  }
}
