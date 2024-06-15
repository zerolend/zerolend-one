# Solidity API

## IPoolDataProvider

Defines the basic interface of a PoolDataProvider

### TokenData

```solidity
struct TokenData {
  string symbol;
  address tokenAddress;
}
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

### getAllATokens

```solidity
function getAllATokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing ATokens in the pool.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of ATokens, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address pool, address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool isActive, bool isFrozen)
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
| isActive | bool | True if it is active, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveEModeCategory

```solidity
function getReserveEModeCategory(address pool, address asset) external view returns (uint256)
```

Returns the efficiency mode category of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode id of the reserve |

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

### getPaused

```solidity
function getPaused(address pool, address asset) external view returns (bool isPaused)
```

Returns if the pool is paused

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| isPaused | bool | True if the pool is paused, false otherwise |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(address pool, address asset) external view returns (uint256)
```

Returns the protocol fee on the liquidation bonus

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The protocol fee on liquidation |

### getUnbackedMintCap

```solidity
function getUnbackedMintCap(address pool, address asset) external view returns (uint256)
```

Returns the unbacked mint cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The unbacked mint cap of the reserve |

### getDebtCeiling

```solidity
function getDebtCeiling(address pool, address asset) external view returns (uint256)
```

Returns the debt ceiling of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling of the reserve |

### getDebtCeilingDecimals

```solidity
function getDebtCeilingDecimals(address pool) external pure returns (uint256)
```

Returns the debt ceiling decimals

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling decimals |

### getReserveData

```solidity
function getReserveData(address pool, address asset) external view returns (uint256 unbacked, uint256 accruedToTreasuryScaled, uint256 totalAToken, uint256 totalVariableDebt, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex, uint40 lastUpdateTimestamp)
```

Returns the reserve data

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| unbacked | uint256 | The amount of unbacked tokens |
| accruedToTreasuryScaled | uint256 | The scaled amount of tokens accrued to treasury that is to be minted |
| totalAToken | uint256 | The total supply of the aToken |
| totalVariableDebt | uint256 | The total variable debt of the reserve |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| variableBorrowRate | uint256 | The variable borrow rate of the reserve |
| liquidityIndex | uint256 | The liquidity index of the reserve |
| variableBorrowIndex | uint256 | The variable borrow index of the reserve |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the reserve |

### getATokenTotalSupply

```solidity
function getATokenTotalSupply(address pool, address asset) external view returns (uint256)
```

Returns the total supply of aTokens for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply of the aToken |

### getTotalDebt

```solidity
function getTotalDebt(address pool, address asset) external view returns (uint256)
```

Returns the total debt for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total debt for asset |

### getUserReserveData

```solidity
function getUserReserveData(address pool, address asset, address user) external view returns (uint256 currentATokenBalance, uint256 currentVariableDebt, uint256 scaledVariableDebt, uint256 liquidityRate, bool usageAsCollateralEnabled)
```

Returns the user data in a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| currentATokenBalance | uint256 | The current AToken balance of the user |
| currentVariableDebt | uint256 | The current variable debt of the user |
| scaledVariableDebt | uint256 | The scaled variable debt of the user |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| usageAsCollateralEnabled | bool | True if the user is using the asset as collateral, false         otherwise |

### getReserveTokensAddresses

```solidity
function getReserveTokensAddresses(address pool, address asset) external view returns (address aTokenAddress, address variableDebtTokenAddress)
```

Returns the token addresses of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| aTokenAddress | address | The AToken address of the reserve |
| variableDebtTokenAddress | address | The VariableDebtToken address of the reserve |

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

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(address pool, address asset) external view returns (bool)
```

Returns whether the reserve has FlashLoans enabled or disabled

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if FlashLoans are enabled, false otherwise |

