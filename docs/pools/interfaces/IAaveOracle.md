# Solidity API

## IAaveOracle

Defines the basic interface for the Aave Oracle

### BaseCurrencySet

```solidity
event BaseCurrencySet(address baseCurrency, uint256 baseCurrencyUnit)
```

_Emitted after the base currency is set_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| baseCurrency | address | The base currency of used for price quotes |
| baseCurrencyUnit | uint256 | The unit of the base currency |

### AssetSourceUpdated

```solidity
event AssetSourceUpdated(address asset, address source)
```

_Emitted after the price source of an asset is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |
| source | address | The price source of the asset |

### FallbackOracleUpdated

```solidity
event FallbackOracleUpdated(address fallbackOracle)
```

_Emitted after the address of fallback oracle is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fallbackOracle | address | The address of the fallback oracle |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### setAssetSources

```solidity
function setAssetSources(address pool, address[] assets, address[] sources) external
```

Sets or replaces price sources of assets

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| assets | address[] | The addresses of the assets |
| sources | address[] | The addresses of the price sources |

### setFallbackOracle

```solidity
function setFallbackOracle(address pool, address fallbackOracle) external
```

Sets the fallback oracle

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| fallbackOracle | address | The address of the fallback oracle |

### getAssetsPrices

```solidity
function getAssetsPrices(address pool, address[] assets) external view returns (uint256[])
```

Returns a list of prices from a list of assets addresses

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| assets | address[] | The list of assets addresses |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256[] | The prices of the given assets |

### getSourceOfAsset

```solidity
function getSourceOfAsset(address pool, address asset) external view returns (address)
```

Returns the address of the source for an asset address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the source |

### getFallbackOracle

```solidity
function getFallbackOracle(address pool) external view returns (address)
```

Returns the address of the fallback oracle

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the fallback oracle |

