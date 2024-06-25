# Solidity API

## PoolGetters

### getReserveData

```solidity
function getReserveData(address asset) external view virtual returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### getBalance

```solidity
function getBalance(address asset, bytes32 positionId) external view returns (uint256 balance)
```

Get the balance of a specific asset in a specific position.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset. |
| positionId | bytes32 | The ID of the position. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| balance | uint256 | The balance of the specified asset in the specified position. |

### getHook

```solidity
function getHook() external view returns (contract IHook)
```

### getBalance

```solidity
function getBalance(address asset, address who, uint256 index) external view returns (uint256 balance)
```

### getBalanceRaw

```solidity
function getBalanceRaw(address asset, bytes32 positionId) external view returns (struct DataTypes.PositionBalance)
```

### getBalanceRaw

```solidity
function getBalanceRaw(address asset, address who, uint256 index) external view returns (struct DataTypes.PositionBalance)
```

### getTotalSupplyRaw

```solidity
function getTotalSupplyRaw(address asset) external view returns (struct DataTypes.ReserveSupplies)
```

### getDebt

```solidity
function getDebt(address asset, bytes32 positionId) external view returns (uint256 debt)
```

Get the debt of a specific asset in a specific position.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset. |
| positionId | bytes32 | The ID of the position. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| debt | uint256 | The debt of the specified asset in the specified position. |

### getDebt

```solidity
function getDebt(address asset, address who, uint256 index) external view returns (uint256 debt)
```

### getUserAccountData

```solidity
function getUserAccountData(address user, uint256 index) external view virtual returns (uint256, uint256, uint256, uint256, uint256, uint256)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 |  |
| [1] | uint256 |  |
| [2] | uint256 |  |
| [3] | uint256 |  |
| [4] | uint256 |  |
| [5] | uint256 |  |

### getConfiguration

```solidity
function getConfiguration(address asset) external view virtual returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user, uint256 index) external view virtual returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address reserve) external view virtual returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address reserve) external view virtual returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReservesList

```solidity
function getReservesList() external view virtual returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view virtual returns (uint256)
```

Returns the number of initialized reserves

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

### getAssetPrice

```solidity
function getAssetPrice(address reserve) public view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

### factory

```solidity
function factory() external view returns (contract IFactory)
```

### getReserveFactor

```solidity
function getReserveFactor() external view returns (uint256 reseveFactor)
```

