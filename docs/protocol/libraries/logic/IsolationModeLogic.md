# Solidity API

## IsolationModeLogic

Implements the base logic for handling repayments for assets borrowed in isolation mode

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### updateIsolatedDebtIfIsolated

```solidity
function updateIsolatedDebtIfIsolated(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveCache reserveCache, uint256 repayAmount) internal
```

updated the isolated debt whenever a position collateralized by an isolated asset is repaid or liquidated

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| repayAmount | uint256 | The amount being repaid |

