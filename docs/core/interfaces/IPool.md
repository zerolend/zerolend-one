# Solidity API

## IPool

Defines the basic interface for a ZeroLend Pool.

### Supply

```solidity
event Supply(address reserve, address user, address onBehalfOf, uint256 amount)
```

_Emitted on supply()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address initiating the supply |
| onBehalfOf | address | The beneficiary of the supply, receiving the aTokens |
| amount | uint256 | The amount supplied |

### Withdraw

```solidity
event Withdraw(address reserve, address user, address to, uint256 amount)
```

_Emitted on withdraw()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being withdrawn |
| user | address | The address initiating the withdrawal, owner of aTokens |
| to | address | The address that will receive the underlying |
| amount | uint256 | The amount to be withdrawn |

### Borrow

```solidity
event Borrow(address reserve, address user, address onBehalfOf, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 borrowRate)
```

_Emitted on borrow() and flashLoan() when debt needs to be opened_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being borrowed |
| user | address | The address of the user initiating the borrow(), receiving the funds on borrow() or just initiator of the transaction on flashLoan() |
| onBehalfOf | address | The address that will be getting the debt |
| amount | uint256 | The amount borrowed out |
| interestRateMode | enum DataTypes.InterestRateMode | The rate mode: 1 for Stable, 2 for Variable |
| borrowRate | uint256 | The numeric rate at which the user has borrowed, expressed in ray |

### Repay

```solidity
event Repay(address reserve, address user, address repayer, uint256 amount, bool useATokens)
```

_Emitted on repay()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The beneficiary of the repayment, getting his debt reduced |
| repayer | address | The address of the user initiating the repay(), providing the funds |
| amount | uint256 | The amount repaid |
| useATokens | bool | True if the repayment is done using aTokens, `false` if done with underlying asset directly |

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, uint256 premium)
```

_Emitted on flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The address of the flash loan receiver contract |
| initiator | address | The address initiating the flash loan |
| asset | address | The address of the asset being flash borrowed |
| amount | uint256 | The amount flash borrowed |
| premium | uint256 | The fee flash borrowed |

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator, bool receiveAToken)
```

_Emitted when a borrower is liquidated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| liquidatedCollateralAmount | uint256 | The amount of collateral received by the liquidator |
| liquidator | address | The address of the liquidator |
| receiveAToken | bool | True if the liquidators wants to receive the collateral aTokens, `false` if he wants to receive the underlying collateral asset directly |

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

_Emitted when the state of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| liquidityRate | uint256 | The next liquidity rate |
| variableBorrowRate | uint256 | The next variable borrow rate |
| liquidityIndex | uint256 | The next liquidity index |
| variableBorrowIndex | uint256 | The next variable borrow index |

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

_Emitted when the protocol treasury receives minted aTokens from the accrued interest._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the reserve |
| amountMinted | uint256 | The amount minted to the treasury |

### CollateralConfigurationChanged

```solidity
event CollateralConfigurationChanged(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus)
```

_Emitted when the collateralization risk parameters for the specified asset are updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| ltv | uint256 | The loan to value of the asset when used as collateral |
| liquidationThreshold | uint256 | The threshold at which loans using this asset as collateral will be considered undercollateralized |
| liquidationBonus | uint256 | The bonus liquidators receive to liquidate this asset |

### ReserveInitialized

```solidity
event ReserveInitialized(address asset, address oracle, address interestRateStrategyAddress)
```

_Emitted when a reserve is initialized._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oracle | address | The address of the oracle |
| interestRateStrategyAddress | address | The address of the interest rate strategy for the reserve |

### InitParams

```solidity
struct InitParams {
  address hook;
  address[] assets;
  address[] rateStrategyAddresses;
  address[] sources;
  struct DataTypes.ReserveConfigurationMap[] configurations;
}
```

### initialize

```solidity
function initialize(struct IPool.InitParams params) external
```

### supply

```solidity
function supply(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) external
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| index | uint256 |  |
| data | struct DataTypes.ExtraData |  |

### supply

```solidity
function supply(address asset, uint256 amount, uint256 index) external
```

### withdraw

```solidity
function withdraw(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) external returns (uint256)
```

Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to withdraw |
| amount | uint256 | The underlying amount to be withdrawn   - Send the value type(uint256).max in order to withdraw the whole aToken balance |
| index | uint256 |  |
| data | struct DataTypes.ExtraData |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount withdrawn |

### withdraw

```solidity
function withdraw(address asset, uint256 amount, uint256 index) external returns (uint256)
```

### borrow

```solidity
function borrow(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) external
```

Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
already supplied enough collateral, or he was given enough allowance by a credit delegator on the
corresponding debt token (StableDebtToken or VariableDebtToken)
- E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
  and 100 stable/variable debt tokens, depending on the `interestRateMode`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to borrow |
| amount | uint256 | The amount to be borrowed |
| index | uint256 |  |
| data | struct DataTypes.ExtraData |  |

### borrow

```solidity
function borrow(address asset, uint256 amount, uint256 index) external
```

### getHook

```solidity
function getHook() external view returns (contract IHook)
```

### repay

```solidity
function repay(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) external returns (uint256)
```

Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
- E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| index | uint256 |  |
| data | struct DataTypes.ExtraData |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### repay

```solidity
function repay(address asset, uint256 amount, uint256 index) external returns (uint256)
```

### liquidate

```solidity
function liquidate(address collateralAsset, address debtAsset, bytes32 position, uint256 debtToCover, struct DataTypes.ExtraData data) external
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| position | bytes32 |  |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| data | struct DataTypes.ExtraData |  |

### liquidate

```solidity
function liquidate(address collateralAsset, address debtAsset, bytes32 position, uint256 debtToCover) external
```

### flashLoan

```solidity
function flashLoan(address receiverAddress, address asset, uint256 amount, bytes params) external
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface |
| asset | address | The address of the asset being flash-borrowed |
| amount | uint256 | The amount of the asset being flash-borrowed |
| params | bytes | Variadic packed params to pass to the receiver as extra information |

### getBalance

```solidity
function getBalance(address asset, bytes32 positionId) external view returns (uint256 balance)
```

Get the balance of a specific asset in a specific position.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset. |
| positionId | bytes32 | The ID of the position. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| balance | uint256 | The balance of the specified asset in the specified position. |

### getBalance

```solidity
function getBalance(address asset, address who, uint256 index) external view returns (uint256 balance)
```

### getDebt

```solidity
function getDebt(address asset, address who, uint256 index) external view returns (uint256 debt)
```

### getDebt

```solidity
function getDebt(address asset, bytes32 positionId) external view returns (uint256 debt)
```

Get the debt of a specific asset in a specific position.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset. |
| positionId | bytes32 | The ID of the position. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| debt | uint256 | The debt of the specified asset in the specified position. |

### getReserveFactor

```solidity
function getReserveFactor() external view returns (uint256 reseveFactor)
```

### factory

```solidity
function factory() external view returns (contract IFactory f)
```

### getUserAccountData

```solidity
function getUserAccountData(address user, uint256 index) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |
| index | uint256 |  |

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
function setReserveConfiguration(address asset, address rateStrategyAddress, address source, struct DataTypes.ReserveConfigurationMap configuration) external
```

Sets the configuration bitmap of the reserve as a whole

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| rateStrategyAddress | address |  |
| source | address |  |
| configuration | struct DataTypes.ReserveConfigurationMap | The new configuration bitmap |

### getConfiguration

```solidity
function getConfiguration(address asset) external view returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user, uint256 index) external view returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address asset) external view returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address asset) external view returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReserveData

```solidity
function getReserveData(address asset) external view returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### getReservesList

```solidity
function getReservesList() external view returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view returns (uint256)
```

Returns the number of initialized reserves

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

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

