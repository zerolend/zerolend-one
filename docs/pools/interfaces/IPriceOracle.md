# Solidity API

## IPriceOracle

Defines the basic interface for a Price oracle.

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

### setAssetPrice

```solidity
function setAssetPrice(address asset, uint256 price) external
```

Set the price of the asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |
| price | uint256 | The price of the asset |

