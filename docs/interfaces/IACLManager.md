# Solidity API

## IACLManager

Defines the basic interface for the ACL Manager

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the contract address of the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider |

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

### FLASH_BORROWER_ROLE

```solidity
function FLASH_BORROWER_ROLE() external view returns (bytes32)
```

Returns the identifier of the FlashBorrower role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the FlashBorrower role |

### BRIDGE_ROLE

```solidity
function BRIDGE_ROLE() external view returns (bytes32)
```

Returns the identifier of the Bridge role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the Bridge role |

### ASSET_LISTING_ADMIN_ROLE

```solidity
function ASSET_LISTING_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the AssetListingAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the AssetListingAdmin role |

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) external
```

Set the role as admin of a specific role.

_By default the admin role for all roles is `DEFAULT_ADMIN_ROLE`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| role | bytes32 | The role to be managed by the admin role |
| adminRole | bytes32 | The admin role |

### addPoolAdmin

```solidity
function addPoolAdmin(address admin) external
```

Adds a new admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removePoolAdmin

```solidity
function removePoolAdmin(address admin) external
```

Removes an admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isPoolAdmin

```solidity
function isPoolAdmin(address admin) external view returns (bool)
```

Returns true if the address is PoolAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is PoolAdmin, false otherwise |

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address admin) external
```

Adds a new admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address admin) external
```

Removes an admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address admin) external view returns (bool)
```

Returns true if the address is EmergencyAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is EmergencyAdmin, false otherwise |

### addRiskAdmin

```solidity
function addRiskAdmin(address admin) external
```

Adds a new admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeRiskAdmin

```solidity
function removeRiskAdmin(address admin) external
```

Removes an admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isRiskAdmin

```solidity
function isRiskAdmin(address admin) external view returns (bool)
```

Returns true if the address is RiskAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is RiskAdmin, false otherwise |

### addFlashBorrower

```solidity
function addFlashBorrower(address borrower) external
```

Adds a new address as FlashBorrower

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address of the new FlashBorrower |

### removeFlashBorrower

```solidity
function removeFlashBorrower(address borrower) external
```

Removes an address as FlashBorrower

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address of the FlashBorrower to remove |

### isFlashBorrower

```solidity
function isFlashBorrower(address borrower) external view returns (bool)
```

Returns true if the address is FlashBorrower, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is FlashBorrower, false otherwise |

### addBridge

```solidity
function addBridge(address bridge) external
```

Adds a new address as Bridge

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address of the new Bridge |

### removeBridge

```solidity
function removeBridge(address bridge) external
```

Removes an address as Bridge

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address of the bridge to remove |

### isBridge

```solidity
function isBridge(address bridge) external view returns (bool)
```

Returns true if the address is Bridge, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is Bridge, false otherwise |

### addAssetListingAdmin

```solidity
function addAssetListingAdmin(address admin) external
```

Adds a new admin as AssetListingAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeAssetListingAdmin

```solidity
function removeAssetListingAdmin(address admin) external
```

Removes an admin as AssetListingAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isAssetListingAdmin

```solidity
function isAssetListingAdmin(address admin) external view returns (bool)
```

Returns true if the address is AssetListingAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is AssetListingAdmin, false otherwise |

