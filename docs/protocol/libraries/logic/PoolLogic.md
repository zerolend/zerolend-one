# Solidity API

## PoolLogic

Implements the logic for Pool specific functions

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### executeInitReserve

```solidity
function executeInitReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.InitReserveParams params) external returns (bool)
```

Initialize an asset reserve and add the reserve to the list of reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.InitReserveParams | Additional parameters needed for initiation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true if appended, false if inserted at existing empty spot |

### executeRescueTokens

```solidity
function executeRescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

### executeMintToTreasury

```solidity
function executeMintToTreasury(mapping(address => struct DataTypes.ReserveData) reservesData, address[] assets) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### executeResetIsolationModeTotalDebt

```solidity
function executeResetIsolationModeTotalDebt(mapping(address => struct DataTypes.ReserveData) reservesData, address asset) external
```

Resets the isolation mode total debt of the given asset to zero

_It requires the given asset has zero debt ceiling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| asset | address | The address of the underlying asset to reset the isolationModeTotalDebt |

### executeDropReserve

```solidity
function executeDropReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, address asset) external
```

Drop a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| asset | address | The address of the underlying asset of the reserve |

### executeGetUserAccountData

```solidity
function executeGetUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.CalculateUserAccountDataParams params) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
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

