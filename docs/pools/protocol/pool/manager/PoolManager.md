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

### constructor

```solidity
constructor(address _governance) public
```

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) external
```

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) external
```

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) external
```

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) external view returns (bool)
```

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) external
```

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) external
```

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) external view returns (bool)
```

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) external
```

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) external
```

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) external view returns (bool)
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

