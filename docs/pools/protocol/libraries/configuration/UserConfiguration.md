# Solidity API

## UserConfiguration

Implements the bitmap logic to handle the user configuration

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### COLLATERAL_MASK

```solidity
uint256 COLLATERAL_MASK
```

### setBorrowing

```solidity
function setBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool borrowing) internal
```

Sets if the user is borrowing the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| borrowing | bool | True if the user is borrowing the reserve, false otherwise |

### setUsingAsCollateral

```solidity
function setUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool usingAsCollateral) internal
```

Sets if the user is using as collateral the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| usingAsCollateral | bool | True if the user is using the reserve as collateral, false otherwise |

### isUsingAsCollateralOrBorrowing

```solidity
function isUsingAsCollateralOrBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Returns if a user has been using the reserve for borrowing or as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing or as collateral, false otherwise |

### isBorrowing

```solidity
function isBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve for borrowing

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing, false otherwise |

### isUsingAsCollateral

```solidity
function isUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve as collateral, false otherwise |

### isUsingAsCollateralOne

```solidity
function isUsingAsCollateralOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying only one reserve as collateral

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isUsingAsCollateralAny

```solidity
function isUsingAsCollateralAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying any reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral any reserve, false otherwise |

### isBorrowingOne

```solidity
function isBorrowingOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing only one asset

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isBorrowingAny

```solidity
function isBorrowingAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing from any reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been borrowing any reserve, false otherwise |

### isEmpty

```solidity
function isEmpty(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has not been using any reserve for borrowing or supply

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has not been borrowing or supplying any reserve, false otherwise |

### _getFirstAssetIdByMask

```solidity
function _getFirstAssetIdByMask(struct DataTypes.UserConfigurationMap self, uint256 mask) internal pure returns (uint256)
```

Returns the address of the first asset flagged in the bitmap given the corresponding bitmask

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| mask | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The index of the first asset flagged in the bitmap once the corresponding mask is applied |

