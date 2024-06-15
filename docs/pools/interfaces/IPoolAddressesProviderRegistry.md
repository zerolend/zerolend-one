# Solidity API

## IPoolAddressesProviderRegistry

Defines the basic interface for an Aave Pool Addresses Provider Registry.

### AddressesProviderRegistered

```solidity
event AddressesProviderRegistered(address addressesProvider, uint256 id)
```

_Emitted when a new AddressesProvider is registered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the registered PoolAddressesProvider |
| id | uint256 | The id of the registered PoolAddressesProvider |

### AddressesProviderUnregistered

```solidity
event AddressesProviderUnregistered(address addressesProvider, uint256 id)
```

_Emitted when an AddressesProvider is unregistered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the unregistered PoolAddressesProvider |
| id | uint256 | The id of the unregistered PoolAddressesProvider |

### getAddressesProvidersList

```solidity
function getAddressesProvidersList() external view returns (address[])
```

Returns the list of registered addresses providers

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The list of addresses providers |

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

