// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {AccessControl} from '../../../dependencies/openzeppelin/contracts/AccessControl.sol';
import {IPoolAddressesProvider} from '../../../interfaces/IPoolAddressesProvider.sol';
import {IACLManager} from '../../../interfaces/IACLManager.sol';
import {Errors} from '../../libraries/helpers/Errors.sol';
import {TimelockedActions} from './TimelockedActions.sol';

/**
 * @title ACLManager
 * @author Aave
 * @notice Access Control List Manager. Main registry of system roles and permissions.
 */

contract PoolManager is TimelockedActions {
  bytes32 public constant POOL_ADMIN_ROLE = keccak256('POOL_ADMIN');
  bytes32 public constant EMERGENCY_ADMIN_ROLE = keccak256('EMERGENCY_ADMIN');
  bytes32 public constant RISK_ADMIN_ROLE = keccak256('RISK_ADMIN');

  constructor(IPoolAddressesProvider provider) TimelockedActions(0, msg.sender) {
    address aclAdmin = provider.getACLAdmin();
    require(aclAdmin != address(0), Errors.ACL_ADMIN_CANNOT_BE_ZERO);
    _setupRole(DEFAULT_ADMIN_ROLE, aclAdmin);
  }

  function setRoleAdmin(bytes32 role, bytes32 adminRole) external onlyRole(DEFAULT_ADMIN_ROLE) {
    _setRoleAdmin(role, adminRole);
  }

  function addPoolAdmin(address pool, address admin) external {
    grantRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
  }

  function removePoolAdmin(address pool, address admin) external {
    revokeRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
  }

  function isPoolAdmin(address pool, address admin) external view returns (bool) {
    return hasRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
  }

  function addEmergencyAdmin(address pool, address admin) external {
    grantRole(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), admin);
  }

  function removeEmergencyAdmin(address pool, address admin) external {
    revokeRole(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), admin);
  }

  function isEmergencyAdmin(address pool, address admin) external view returns (bool) {
    return hasRole(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), admin);
  }

  function addRiskAdmin(address pool, address admin) external {
    grantRole(getRoleFromPool(pool, RISK_ADMIN_ROLE), admin);
  }

  function removeRiskAdmin(address pool, address admin) external {
    revokeRole(getRoleFromPool(pool, RISK_ADMIN_ROLE), admin);
  }

  function isRiskAdmin(address pool, address admin) external view returns (bool) {
    return hasRole(getRoleFromPool(pool, RISK_ADMIN_ROLE), admin);
  }

  /**
   * @dev Only pool admin can call functions marked by this modifier.
   */
  modifier onlyPoolAdmin(address pool) {
    require(hasRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), msg.sender), 'not risk or pool admin');
    _;
  }

  modifier onlyEmergencyAdmin(address pool) {
    require(
      hasRole(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), msg.sender),
      'not risk or pool admin'
    );
    _;
  }

  modifier onlyEmergencyOrPoolAdmin(address pool) {
    require(
      hasRole(getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE), msg.sender) ||
        hasRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), msg.sender),
      'not emergency or pool admin'
    );
    _;
  }

  modifier onlyRiskOrPoolAdmins(address pool) {
    require(
      hasRole(getRoleFromPool(pool, RISK_ADMIN_ROLE), msg.sender) ||
        hasRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), msg.sender),
      'not risk or pool admin'
    );
    _;
  }
}
