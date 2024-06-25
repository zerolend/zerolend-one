# Solidity API

## SupplyLogic

Implements the base logic for supply/withdraw

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, bytes32 position)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, bytes32 position)
```

### Withdraw

```solidity
event Withdraw(address reserve, bytes32 pos, address to, uint256 amount)
```

### Supply

```solidity
event Supply(address reserve, bytes32 pos, uint256 amount)
```

### executeSupply

```solidity
function executeSupply(mapping(address => struct DataTypes.ReserveData) reservesData, struct DataTypes.UserConfigurationMap userConfig, mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) balances, mapping(address => struct DataTypes.ReserveSupplies) totalSupplies, struct DataTypes.ExecuteSupplyParams params) external
```

Implements the supply feature. Through `supply()`, users supply assets to the Aave protocol.

_Emits the `Supply()` event.
In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
collateral._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| userConfig | struct DataTypes.UserConfigurationMap |  |
| balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| totalSupplies | mapping(address &#x3D;&gt; struct DataTypes.ReserveSupplies) |  |
| params | struct DataTypes.ExecuteSupplyParams | The additional parameters needed to execute the supply function |

### executeWithdraw

```solidity
function executeWithdraw(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) balances, mapping(address => struct DataTypes.ReserveSupplies) totalSupplies, struct DataTypes.ExecuteWithdrawParams params) external returns (uint256)
```

Implements the withdraw feature. Through `withdraw()`, users redeem their aTokens for the underlying asset
previously supplied in the Aave protocol.

_Emits the `Withdraw()` event.
If the user withdraws everything, `ReserveUsedAsCollateralDisabled()` is emitted._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; struct DataTypes.PositionBalance)) |  |
| totalSupplies | mapping(address &#x3D;&gt; struct DataTypes.ReserveSupplies) |  |
| params | struct DataTypes.ExecuteWithdrawParams | The additional parameters needed to execute the withdraw function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount withdrawn |

