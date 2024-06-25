# Solidity API

## BorrowLogic

Implements the base logic for all the actions related to borrowing

### Borrow

```solidity
event Borrow(address reserve, address user, bytes32 position, uint256 amount, uint256 borrowRate)
```

### Repay

```solidity
event Repay(address reserve, bytes32 position, address repayer, uint256 amount)
```

### executeBorrow

```solidity
function executeBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances, mapping(address => struct DataTypes.ReserveSupplies) totalSupplies, struct DataTypes.ExecuteBorrowParams params) public
```

Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
protocol proportionally to their collateralization power.

_Emits the `Borrow()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| totalSupplies | mapping(address &#x3D;&gt; struct DataTypes.ReserveSupplies) |  |
| params | struct DataTypes.ExecuteBorrowParams | The additional parameters needed to execute the borrow function |

### executeRepay

```solidity
function executeRepay(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) balances, mapping(address => struct DataTypes.ReserveSupplies) totalSupplies, struct DataTypes.ExecuteRepayParams params) external returns (uint256)
```

Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
equivalent amount of debt for the user by burning the corresponding debt token.

_Emits the `Repay()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| totalSupplies | mapping(address &#x3D;&gt; struct DataTypes.ReserveSupplies) |  |
| params | struct DataTypes.ExecuteRepayParams | The additional parameters needed to execute the repay function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount being repaid |

