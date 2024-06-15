# Solidity API

## PoolAddressesProviderRegistry

Main registry of PoolAddressesProvider of Aave markets.

_Used for indexing purposes of Aave protocol's markets. The id assigned to a PoolAddressesProvider refers to the
market it is connected with, for example with `1` for the Aave main market and `2` for the next created._

### constructor

```solidity
constructor(address owner) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner address of this contract. |

### getAddressesProvidersList

```solidity
function getAddressesProvidersList() external view returns (address[])
```

Returns the list of registered addresses providers

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The list of addresses providers |

### registerAddressesProvider

```solidity
function registerAddressesProvider(address provider, uint256 id) external
```

Registers an addresses provider

_The PoolAddressesProvider must not already be registered in the registry
The id must not be used by an already registered PoolAddressesProvider_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the new PoolAddressesProvider |
| id | uint256 | The id for the new PoolAddressesProvider, referring to the market it belongs to |

### unregisterAddressesProvider

```solidity
function unregisterAddressesProvider(address provider) external
```

Removes an addresses provider from the list of registered addresses providers

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The PoolAddressesProvider address |

### getAddressesProviderIdByAddress

```solidity
function getAddressesProviderIdByAddress(address addressesProvider) external view returns (uint256)
```

Returns the id of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the PoolAddressesProvider |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The id of the PoolAddressesProvider or 0 if is not registered |

### getAddressesProviderAddressById

```solidity
function getAddressesProviderAddressById(uint256 id) external view returns (address)
```

Returns the address of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint256 | The id of the market |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PoolAddressesProvider with the given id or zero address if it is not registered |

### _addToAddressesProvidersList

```solidity
function _addToAddressesProvidersList(address provider) internal
```

Adds the addresses provider address to the list.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the PoolAddressesProvider |

### _removeFromAddressesProvidersList

```solidity
function _removeFromAddressesProvidersList(address provider) internal
```

Removes the addresses provider address from the list.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the PoolAddressesProvider |

