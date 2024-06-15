# Solidity API

## IPriceOracleGetter

Interface for the Aave price oracle.

### BASE_CURRENCY

```solidity
function BASE_CURRENCY() external view returns (address)
```

Returns the base currency address

_Address 0x0 is reserved for USD as base currency._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Returns the base currency address. |

### BASE_CURRENCY_UNIT

```solidity
function BASE_CURRENCY_UNIT() external view returns (uint256)
```

Returns the base currency unit

_1 ether for ETH, 1e8 for USD._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | Returns the base currency unit. |

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

