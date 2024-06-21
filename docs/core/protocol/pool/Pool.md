# Solidity API

## Pool

### initialize

```solidity
function initialize(struct IPool.InitParams params) public virtual
```

Initializes the Pool.

_This function is invoked by the factory contract when the Pool is created_

### supply

```solidity
function supply(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) public virtual
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
function supply(address asset, uint256 amount, uint256 index) public virtual
```

### withdraw

```solidity
function withdraw(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) public virtual returns (uint256)
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
function withdraw(address asset, uint256 amount, uint256 index) public virtual returns (uint256)
```

### borrow

```solidity
function borrow(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) public virtual
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
function borrow(address asset, uint256 amount, uint256 index) public virtual
```

### repay

```solidity
function repay(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) public virtual returns (uint256)
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
function repay(address asset, uint256 amount, uint256 index) public virtual returns (uint256)
```

### liquidate

```solidity
function liquidate(address collat, address debt, bytes32 pos, uint256 debtAmt, struct DataTypes.ExtraData data) public virtual
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collat | address |  |
| debt | address |  |
| pos | bytes32 |  |
| debtAmt | uint256 |  |
| data | struct DataTypes.ExtraData |  |

### liquidate

```solidity
function liquidate(address collat, address debt, bytes32 pos, uint256 debtAmt) public virtual
```

### flashLoan

```solidity
function flashLoan(address receiverAddress, address asset, uint256 amount, bytes params) public virtual
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

### setReserveConfiguration

```solidity
function setReserveConfiguration(address asset, address rateStrategyAddress, address source, struct DataTypes.ReserveConfigurationMap configuration) external virtual
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

