# Solidity API

## IPoolManager

Defines the basic interface for the ACL Manager

### POOL_ADMIN_ROLE

```solidity
function POOL_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the PoolAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the PoolAdmin role |

### EMERGENCY_ADMIN_ROLE

```solidity
function EMERGENCY_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the EmergencyAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the EmergencyAdmin role |

### RISK_ADMIN_ROLE

```solidity
function RISK_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the RiskAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the RiskAdmin role |

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) external
```

Adds a new admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) external
```

Removes an admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) external view returns (bool)
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

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) external
```

Adds a new admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) external
```

Removes an admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) external view returns (bool)
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

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) external
```

Adds a new admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) external
```

Removes an admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) external view returns (bool)
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

### getRoleFromPool

```solidity
function getRoleFromPool(address pool, bytes32 role) external pure returns (bytes32)
```

