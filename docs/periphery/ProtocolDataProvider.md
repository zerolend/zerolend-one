# Solidity API

## ProtocolDataProvider

### ETH

```solidity
address ETH
```

### getAllReservesTokens

```solidity
function getAllReservesTokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing reserves in the pool.

_Handling MKR and ETH in a different way since they do not have standard `symbol` functions._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of reserves, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address pool, address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool isFrozen)
```

Returns the configuration data of the reserve

_Not returning borrow and supply caps for compatibility, nor pause flag_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| decimals | uint256 | The number of decimals of the reserve |
| ltv | uint256 | The ltv of the reserve |
| liquidationThreshold | uint256 | The liquidationThreshold of the reserve |
| liquidationBonus | uint256 | The liquidationBonus of the reserve |
| reserveFactor | uint256 | The reserveFactor of the reserve |
| usageAsCollateralEnabled | bool | True if the usage as collateral is enabled, false otherwise |
| borrowingEnabled | bool | True if borrowing is enabled, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveCaps

```solidity
function getReserveCaps(address pool, address asset) external view returns (uint256 borrowCap, uint256 supplyCap)
```

Returns the caps parameters of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrowCap | uint256 | The borrow cap of the reserve |
| supplyCap | uint256 | The supply cap of the reserve |

### getInterestRateStrategyAddress

```solidity
function getInterestRateStrategyAddress(address pool, address asset) external view returns (address irStrategyAddress)
```

Returns the address of the Interest Rate strategy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| irStrategyAddress | address | The address of the Interest Rate strategy |

