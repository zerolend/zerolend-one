# Solidity API

## PoolLogic

Implements the logic for Pool specific functions

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

### CollateralConfigurationChanged

```solidity
event CollateralConfigurationChanged(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus)
```

### ReserveInitialized

```solidity
event ReserveInitialized(address asset, address oracle, address interestRateStrategyAddress)
```

### executeInitReserve

```solidity
function executeInitReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.InitReserveParams params) external
```

Initialize an asset reserve and add the reserve to the list of reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.InitReserveParams | Additional parameters needed for initiation |

### executeMintToTreasury

```solidity
function executeMintToTreasury(mapping(address => struct DataTypes.ReserveData) reservesData, address asset) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| asset | address | The reserves for which the minting needs to be executed |

### executeGetUserAccountData

```solidity
function executeGetUserAccountData(mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.CalculateUserAccountDataParams params) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional params needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

### setReserveConfiguration

```solidity
function setReserveConfiguration(mapping(address => struct DataTypes.ReserveData) _reserves, address asset, address rateStrategyAddress, address source, struct DataTypes.ReserveConfigurationMap config) public
```

