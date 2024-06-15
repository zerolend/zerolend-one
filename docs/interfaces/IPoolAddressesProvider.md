# Solidity API

## IPoolAddressesProvider

Defines the basic interface for a Pool Addresses Provider.

### MarketIdSet

```solidity
event MarketIdSet(string oldMarketId, string newMarketId)
```

_Emitted when the market identifier is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldMarketId | string | The old id of the market |
| newMarketId | string | The new id of the market |

### PoolUpdated

```solidity
event PoolUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the Pool |
| newAddress | address | The new address of the Pool |

### PoolConfiguratorUpdated

```solidity
event PoolConfiguratorUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool configurator is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolConfigurator |
| newAddress | address | The new address of the PoolConfigurator |

### PriceOracleUpdated

```solidity
event PriceOracleUpdated(address oldAddress, address newAddress)
```

_Emitted when the price oracle is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PriceOracle |
| newAddress | address | The new address of the PriceOracle |

### ACLManagerUpdated

```solidity
event ACLManagerUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL manager is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLManager |
| newAddress | address | The new address of the ACLManager |

### ACLAdminUpdated

```solidity
event ACLAdminUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL admin is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLAdmin |
| newAddress | address | The new address of the ACLAdmin |

### PriceOracleSentinelUpdated

```solidity
event PriceOracleSentinelUpdated(address oldAddress, address newAddress)
```

_Emitted when the price oracle sentinel is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PriceOracleSentinel |
| newAddress | address | The new address of the PriceOracleSentinel |

### PoolDataProviderUpdated

```solidity
event PoolDataProviderUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool data provider is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolDataProvider |
| newAddress | address | The new address of the PoolDataProvider |

### ProxyCreated

```solidity
event ProxyCreated(bytes32 id, address proxyAddress, address implementationAddress)
```

_Emitted when a new proxy is created._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the proxy |
| proxyAddress | address | The address of the created proxy contract |
| implementationAddress | address | The address of the implementation contract |

### AddressSet

```solidity
event AddressSet(bytes32 id, address oldAddress, address newAddress)
```

_Emitted when a new non-proxied contract address is registered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| oldAddress | address | The address of the old contract |
| newAddress | address | The address of the new contract |

### AddressSetAsProxy

```solidity
event AddressSetAsProxy(bytes32 id, address proxyAddress, address oldImplementationAddress, address newImplementationAddress)
```

_Emitted when the implementation of the proxy registered with id is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| proxyAddress | address | The address of the proxy contract |
| oldImplementationAddress | address | The address of the old implementation contract |
| newImplementationAddress | address | The address of the new implementation contract |

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
function getAddress(bytes32 id) external view returns (address)
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

### getPriceOracleSentinel

```solidity
function getPriceOracleSentinel() external view returns (address)
```

Returns the address of the price oracle sentinel.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracleSentinel |

### setPriceOracleSentinel

```solidity
function setPriceOracleSentinel(address newPriceOracleSentinel) external
```

Updates the address of the price oracle sentinel.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracleSentinel | address | The address of the new PriceOracleSentinel |

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

