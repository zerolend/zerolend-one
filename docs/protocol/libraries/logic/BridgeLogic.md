# Solidity API

## BridgeLogic

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

### MintUnbacked

```solidity
event MintUnbacked(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

### BackUnbacked

```solidity
event BackUnbacked(address reserve, address backer, uint256 amount, uint256 fee)
```

### executeMintUnbacked

```solidity
function executeMintUnbacked(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external
```

Mint unbacked aTokens to a user and updates the unbacked for the reserve.

_Essentially a supply without transferring the underlying.
Emits the `MintUnbacked` event
Emits the `ReserveUsedAsCollateralEnabled` if asset is set as collateral_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| asset | address | The address of the underlying asset to mint aTokens of |
| amount | uint256 | The amount to mint |
| onBehalfOf | address | The address that will receive the aTokens |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### executeBackUnbacked

```solidity
function executeBackUnbacked(struct DataTypes.ReserveData reserve, address asset, uint256 amount, uint256 fee, uint256 protocolFeeBps) external returns (uint256)
```

Back the current unbacked with `amount` and pay `fee`.

_It is not possible to back more than the existing unbacked amount of the reserve
Emits the `BackUnbacked` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve to back unbacked for |
| asset | address | The address of the underlying asset to repay |
| amount | uint256 | The amount to back |
| fee | uint256 | The amount paid in fees |
| protocolFeeBps | uint256 | The fraction of fees in basis points paid to the protocol |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The backed amount |

