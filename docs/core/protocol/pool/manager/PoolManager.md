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

### _scheduleAction

```solidity
function _scheduleAction(address pool, bytes data) internal
```

### cancelAction

```solidity
function cancelAction(address pool, bytes32 id) external
```

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) public
```

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) public
```

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) public
```

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) public view returns (bool)
```

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) public view returns (bool)
```

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) public view returns (bool)
```

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) public
```

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) public
```

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) public
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
