# Solidity API

## PriceOracle

### prices

```solidity
mapping(address => uint256) prices
```

### ethPriceUsd

```solidity
uint256 ethPriceUsd
```

### AssetPriceUpdated

```solidity
event AssetPriceUpdated(address asset, uint256 price, uint256 timestamp)
```

### EthPriceUpdated

```solidity
event EthPriceUpdated(uint256 price, uint256 timestamp)
```

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

### getEthUsdPrice

```solidity
function getEthUsdPrice() external view returns (uint256)
```

### setEthUsdPrice

```solidity
function setEthUsdPrice(uint256 price) external
```

