# Solidity API

## EModeLogic

Implements the base logic for all the actions related to the eMode

### UserEModeSet

```solidity
event UserEModeSet(address user, uint8 categoryId)
```

### executeSetUserEMode

```solidity
function executeSetUserEMode(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, mapping(address => uint8) usersEModeCategory, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteSetUserEModeParams params) external
```

Updates the user efficiency mode category

_Will revert if user is borrowing non-compatible asset or change will drop HF < HEALTH_FACTOR_LIQUIDATION_THRESHOLD
Emits the `UserEModeSet` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| usersEModeCategory | mapping(address &#x3D;&gt; uint8) | The state of all users efficiency mode category |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteSetUserEModeParams | The additional parameters needed to execute the setUserEMode function |

### getEModeConfiguration

```solidity
function getEModeConfiguration(struct DataTypes.EModeCategory category, contract IPriceOracleGetter oracle) internal view returns (uint256, uint256, uint256)
```

Gets the eMode configuration and calculates the eMode asset price if a custom oracle is configured

_The eMode asset price returned is 0 if no oracle is specified_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| category | struct DataTypes.EModeCategory | The user eMode category |
| oracle | contract IPriceOracleGetter | The price oracle |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode ltv |
| [1] | uint256 | The eMode liquidation threshold |
| [2] | uint256 | The eMode asset price |

### isInEModeCategory

```solidity
function isInEModeCategory(uint256 eModeUserCategory, uint256 eModeAssetCategory) internal pure returns (bool)
```

Checks if eMode is active for a user and if yes, if the asset belongs to the eMode category chosen

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| eModeUserCategory | uint256 | The user eMode category |
| eModeAssetCategory | uint256 | The asset eMode category |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if eMode is active and the asset belongs to the eMode category chosen by the user, false otherwise |

