# Solidity API

## PoolManager

### POOL_ADMIN_ROLE

```solidity
bytes32 POOL_ADMIN_ROLE
```

Returns the identifier of the PoolAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### EMERGENCY_ADMIN_ROLE

```solidity
bytes32 EMERGENCY_ADMIN_ROLE
```

Returns the identifier of the EmergencyAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### RISK_ADMIN_ROLE

```solidity
bytes32 RISK_ADMIN_ROLE
```

Returns the identifier of the RiskAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

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

Adds a new admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) public
```

Adds a new admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) public
```

Adds a new admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) public view returns (bool)
```

Returns true if the address is PoolAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is PoolAdmin, false otherwise |

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) public view returns (bool)
```

Returns true if the address is EmergencyAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is EmergencyAdmin, false otherwise |

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) public view returns (bool)
```

Returns true if the address is RiskAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is RiskAdmin, false otherwise |

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) public
```

Removes an admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) public
```

Removes an admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) public
```

Removes an admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

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

