# Solidity API

## AaveProtocolDataProvider

Peripheral contract to collect and pre-process information from the Pool.

### ETH

```solidity
address ETH
```

### ADDRESSES_PROVIDER

```solidity
contract IPoolAddressesProvider ADDRESSES_PROVIDER
```

Returns the address for the PoolAddressesProvider contract.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### constructor

```solidity
constructor(contract IPoolAddressesProvider addressesProvider) internal
```

Constructor

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### getAllReservesTokens

```solidity
function getAllReservesTokens() external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing reserves in the pool.

_Handling MKR and ETH in a different way since they do not have standard `symbol` functions._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of reserves, pairs of symbols and addresses |

### getAllATokens

```solidity
function getAllATokens() external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing ATokens in the pool.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of ATokens, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool stableBorrowRateEnabled, bool isActive, bool isFrozen)
```

Returns the configuration data of the reserve

_Not returning borrow and supply caps for compatibility, nor pause flag_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
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
| stableBorrowRateEnabled | bool | True if stable rate borrowing is enabled, false otherwise |
| isActive | bool | True if it is active, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveCaps

```solidity
function getReserveCaps(address asset) external view returns (uint256 borrowCap, uint256 supplyCap)
```

Returns the caps parameters of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrowCap | uint256 | The borrow cap of the reserve |
| supplyCap | uint256 | The supply cap of the reserve |

### getPaused

```solidity
function getPaused(address asset) external view returns (bool isPaused)
```

Returns if the pool is paused

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| isPaused | bool | True if the pool is paused, false otherwise |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(address asset) external view returns (uint256)
```

Returns the protocol fee on the liquidation bonus

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The protocol fee on liquidation |

### getDebtCeiling

```solidity
function getDebtCeiling(address asset) external view returns (uint256)
```

Returns the debt ceiling of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling of the reserve |

### getDebtCeilingDecimals

```solidity
function getDebtCeilingDecimals() external pure returns (uint256)
```

Returns the debt ceiling decimals

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling decimals |

### getATokenTotalSupply

```solidity
function getATokenTotalSupply(address asset) external view returns (uint256)
```

Returns the total supply of aTokens for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply of the aToken |

### getTotalDebt

```solidity
function getTotalDebt(address asset) external view returns (uint256)
```

Returns the total debt for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total debt for asset |

### getUserReserveData

```solidity
function getUserReserveData(address asset, address user) external view returns (uint256 currentATokenBalance, uint256 currentStableDebt, uint256 currentVariableDebt, uint256 principalStableDebt, uint256 scaledVariableDebt, uint256 stableBorrowRate, uint256 liquidityRate, uint40 stableRateLastUpdated, bool usageAsCollateralEnabled)
```

Returns the user data in a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| currentATokenBalance | uint256 | The current AToken balance of the user |
| currentStableDebt | uint256 | The current stable debt of the user |
| currentVariableDebt | uint256 | The current variable debt of the user |
| principalStableDebt | uint256 | The principal stable debt of the user |
| scaledVariableDebt | uint256 | The scaled variable debt of the user |
| stableBorrowRate | uint256 | The stable borrow rate of the user |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| stableRateLastUpdated | uint40 | The timestamp of the last update of the user stable rate |
| usageAsCollateralEnabled | bool | True if the user is using the asset as collateral, false         otherwise |

### getInterestRateStrategyAddress

```solidity
function getInterestRateStrategyAddress(address asset) external view returns (address irStrategyAddress)
```

Returns the address of the Interest Rate strategy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| irStrategyAddress | address | The address of the Interest Rate strategy |

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(address asset) external view returns (bool)
```

Returns whether the reserve has FlashLoans enabled or disabled

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if FlashLoans are enabled, false otherwise |

