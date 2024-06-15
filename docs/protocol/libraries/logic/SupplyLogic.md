# Solidity API

## SupplyLogic

Implements the base logic for supply/withdraw

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

### Withdraw

```solidity
event Withdraw(address reserve, address user, address to, uint256 amount)
```

### Supply

```solidity
event Supply(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

### executeSupply

```solidity
function executeSupply(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteSupplyParams params) external
```

Implements the supply feature. Through `supply()`, users supply assets to the Aave protocol.

_Emits the `Supply()` event.
In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
collateral._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteSupplyParams | The additional parameters needed to execute the supply function |

### executeWithdraw

```solidity
function executeWithdraw(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteWithdrawParams params) external returns (uint256)
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
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteWithdrawParams | The additional parameters needed to execute the withdraw function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount withdrawn |

### executeFinalizeTransfer

```solidity
function executeFinalizeTransfer(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, mapping(address => struct DataTypes.UserConfigurationMap) usersConfig, struct DataTypes.FinalizeTransferParams params) external
```

Validates a transfer of aTokens. The sender is subjected to health factor validation to avoid
collateralization constraints violation.

_Emits the `ReserveUsedAsCollateralEnabled()` event for the `to` account, if the asset is being activated as
collateral.
In case the `from` user transfers everything, `ReserveUsedAsCollateralDisabled()` is emitted for `from`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| usersConfig | mapping(address &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| params | struct DataTypes.FinalizeTransferParams | The additional parameters needed to execute the finalizeTransfer function |

### executeUseReserveAsCollateral

```solidity
function executeUseReserveAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address asset, bool useAsCollateral, uint256 reservesCount, address priceOracle, uint8 userEModeCategory) external
```

Executes the 'set as collateral' feature. A user can choose to activate or deactivate an asset as
collateral at any point in time. Deactivating an asset as collateral is subjected to the usual health factor
checks to ensure collateralization.

_Emits the `ReserveUsedAsCollateralEnabled()` event if the asset can be activated as collateral.
In case the asset is being deactivated as collateral, `ReserveUsedAsCollateralDisabled()` is emitted._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The users configuration mapping that track the supplied/borrowed assets |
| asset | address | The address of the asset being configured as collateral |
| useAsCollateral | bool | True if the user wants to set the asset as collateral, false otherwise |
| reservesCount | uint256 | The number of initialized reserves |
| priceOracle | address | The address of the price oracle |
| userEModeCategory | uint8 | The eMode category chosen by the user |

