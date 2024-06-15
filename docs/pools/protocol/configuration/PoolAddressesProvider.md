# Solidity API

## PoolAddressesProvider

Main registry of addresses part of or connected to the protocol, including permissioned roles

_Acts as factory of proxies and admin of those, so with right to change its implementations
Owned by the Aave Governance_

### constructor

```solidity
constructor(string marketId, address owner) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| marketId | string | The identifier of the market. |
| owner | address | The owner address of this contract. |

### getMarketId

```solidity
function getMarketId() external view returns (string)
```

Returns the id of the Aave market to which this contract points to.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The market id |

### setMarketId

```solidity
function setMarketId(string newMarketId) external
```

Associates an id with a specific PoolAddressesProvider.

_This can be used to create an onchain registry of PoolAddressesProviders to
identify and validate multiple Aave markets._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The market id |

### getAddress

```solidity
function getAddress(bytes32 id) public view returns (address)
```

Returns an address by its identifier.

_The returned address might be an EOA or a contract, potentially proxied
It returns ZERO if there is no registered address with the given id_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the registered for the specified id |

### setAddress

```solidity
function setAddress(bytes32 id, address newAddress) external
```

Sets an address for an id replacing the address saved in the addresses map.

_IMPORTANT Use this function carefully, as it will do a hard replacement_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newAddress | address | The address to set |

### setAddressAsProxy

```solidity
function setAddressAsProxy(bytes32 id, address newImplementationAddress) external
```

General function to update the implementation of a proxy registered with
certain `id`. If there is no proxy registered, it will instantiate one and
set as implementation the `newImplementationAddress`.

_IMPORTANT Use this function carefully, only for ids that don't have an explicit
setter function, in order to avoid unexpected consequences_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newImplementationAddress | address | The address of the new implementation |

### getPool

```solidity
function getPool() external view returns (address)
```

Returns the address of the Pool proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Pool proxy address |

### setPoolImpl

```solidity
function setPoolImpl(address newPoolImpl) external
```

Updates the implementation of the Pool, or creates a proxy
setting the new `pool` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolImpl | address | The new Pool implementation |

### getPoolConfigurator

```solidity
function getPoolConfigurator() external view returns (address)
```

Returns the address of the PoolConfigurator proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The PoolConfigurator proxy address |

### setPoolConfiguratorImpl

```solidity
function setPoolConfiguratorImpl(address newPoolConfiguratorImpl) external
```

Updates the implementation of the PoolConfigurator, or creates a proxy
setting the new `PoolConfigurator` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolConfiguratorImpl | address | The new PoolConfigurator implementation |

### getPriceOracle

```solidity
function getPriceOracle() external view returns (address)
```

Returns the address of the price oracle.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracle |

### setPriceOracle

```solidity
function setPriceOracle(address newPriceOracle) external
```

Updates the address of the price oracle.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracle | address | The address of the new PriceOracle |

### getACLManager

```solidity
function getACLManager() external view returns (address)
```

Returns the address of the ACL manager.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACLManager |

### setACLManager

```solidity
function setACLManager(address newAclManager) external
```

Updates the address of the ACL manager.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclManager | address | The address of the new ACLManager |

### getACLAdmin

```solidity
function getACLAdmin() external view returns (address)
```

Returns the address of the ACL admin.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACL admin |

### setACLAdmin

```solidity
function setACLAdmin(address newAclAdmin) external
```

Updates the address of the ACL admin.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclAdmin | address | The address of the new ACL admin |

### getPoolDataProvider

```solidity
function getPoolDataProvider() external view returns (address)
```

Returns the address of the data provider.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the DataProvider |

### setPoolDataProvider

```solidity
function setPoolDataProvider(address newDataProvider) external
```

Updates the address of the data provider.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newDataProvider | address | The address of the new DataProvider |

### _updateImpl

```solidity
function _updateImpl(bytes32 id, address newAddress) internal
```

Internal function to update the implementation of a specific proxied component of the protocol.

_If there is no proxy registered with the given identifier, it creates the proxy setting `newAddress`
  as implementation and calls the initialize() function on the proxy
If there is already a proxy registered, it just updates the implementation to `newAddress` and
  calls the initialize() function via upgradeToAndCall() in the proxy_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id of the proxy to be updated |
| newAddress | address | The address of the new implementation |

### _setMarketId

```solidity
function _setMarketId(string newMarketId) internal
```

Updates the identifier of the Aave market.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The new id of the market |

### _getProxyImplementation

```solidity
function _getProxyImplementation(bytes32 id) internal returns (address)
```

Returns the the implementation contract of the proxy contract by its identifier.

_It returns ZERO if there is no registered address with the given id
It reverts if the registered address with the given id is not `InitializableImmutableAdminUpgradeabilityProxy`_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation contract |

