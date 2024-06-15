# Solidity API

## PoolManager

### POOL_ADMIN_ROLE

```solidity
bytes32 POOL_ADMIN_ROLE
```

### EMERGENCY_ADMIN_ROLE

```solidity
bytes32 EMERGENCY_ADMIN_ROLE
```

### RISK_ADMIN_ROLE

```solidity
bytes32 RISK_ADMIN_ROLE
```

### governance

```solidity
address governance
```

### constructor

```solidity
constructor(address _governance) public
```

### initRoles

```solidity
function initRoles(address pool, address admin) internal
```

### _scheduleAction

```solidity
function _scheduleAction(address pool, bytes data) internal
```

### cancelAction

```solidity
function cancelAction(address pool, bytes32 id) external
```

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) public
```

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) public
```

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) public
```

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) public view returns (bool)
```

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) public
```

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) public
```

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) public view returns (bool)
```

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) public
```

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) public
```

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) public view returns (bool)
```

### onlyPoolAdmin

```solidity
modifier onlyPoolAdmin(address pool)
```

_Only pool admin can call functions marked by this modifier._

### onlyEmergencyAdmin

```solidity
modifier onlyEmergencyAdmin(address pool)
```

### onlyEmergencyOrPoolAdmin

```solidity
modifier onlyEmergencyOrPoolAdmin(address pool)
```

### onlyRiskOrPoolAdmins

```solidity
modifier onlyRiskOrPoolAdmins(address pool)
```

### getRoleFromPool

```solidity
function getRoleFromPool(address pool, bytes32 role) public pure returns (bytes32)
```

