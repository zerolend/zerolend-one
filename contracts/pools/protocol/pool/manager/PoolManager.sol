// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IACLManager} from '../../../interfaces/IACLManager.sol';
import {Errors} from '../../libraries/helpers/Errors.sol';
import {TimelockedActions} from './TimelockedActions.sol';

contract PoolManager is TimelockedActions {
  bytes32 public constant POOL_ADMIN_ROLE = keccak256('POOL_ADMIN');
  bytes32 public constant EMERGENCY_ADMIN_ROLE = keccak256('EMERGENCY_ADMIN');
  bytes32 public constant RISK_ADMIN_ROLE = keccak256('RISK_ADMIN');

  address public governance;

  constructor(address _governance) TimelockedActions(86400 * 3) {
    governance = _governance;
    _setupRole(DEFAULT_ADMIN_ROLE, _governance);
  }

  function initRoles(address pool, address admin) internal {
    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), admin);
    _setupRole(getRoleFromPool(pool, POOL_ADMIN_ROLE), governance);

    _setRoleAdmin(getRoleFromPool(pool, POOL_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(getRoleFromPool(pool, RISK_ADMIN_ROLE), getRoleFromPool(pool, POOL_ADMIN_ROLE));
    _setRoleAdmin(
      getRoleFromPool(pool, EMERGENCY_ADMIN_ROLE),
      getRoleFromPool(pool, POOL_ADMIN_ROLE)
    );
  }

  function _scheduleAction(address pool, bytes calldata data) internal {
    _schedule(
      pool, // address target,
      0, // uint256 value,
      data, // bytes calldata data,
      keccak256(abi.encode(block.timestamp)), // bytes32 salt,
      86400 * 3 // uint256 delay
    );
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

  function getRoleFromPool(address pool, bytes32 role) public pure returns (bytes32) {
    return keccak256(abi.encode(pool, role));
  }
}
