# Solidity API

## ReserveConfiguration

Implements the bitmap logic to handle the reserve configuration

### LTV_MASK

```solidity
uint256 LTV_MASK
```

### LIQUIDATION_THRESHOLD_MASK

```solidity
uint256 LIQUIDATION_THRESHOLD_MASK
```

### LIQUIDATION_BONUS_MASK

```solidity
uint256 LIQUIDATION_BONUS_MASK
```

### DECIMALS_MASK

```solidity
uint256 DECIMALS_MASK
```

### FROZEN_MASK

```solidity
uint256 FROZEN_MASK
```

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### FLASHLOAN_ENABLED_MASK

```solidity
uint256 FLASHLOAN_ENABLED_MASK
```

### RESERVE_FACTOR_MASK

```solidity
uint256 RESERVE_FACTOR_MASK
```

### BORROW_CAP_MASK

```solidity
uint256 BORROW_CAP_MASK
```

### SUPPLY_CAP_MASK

```solidity
uint256 SUPPLY_CAP_MASK
```

### LIQUIDATION_THRESHOLD_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_THRESHOLD_START_BIT_POSITION
```

_For the LTV, the start bit is 0 (up to 15), hence no bitshifting is needed_

### LIQUIDATION_BONUS_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_BONUS_START_BIT_POSITION
```

### RESERVE_DECIMALS_START_BIT_POSITION

```solidity
uint256 RESERVE_DECIMALS_START_BIT_POSITION
```

### IS_ACTIVE_START_BIT_POSITION

```solidity
uint256 IS_ACTIVE_START_BIT_POSITION
```

### IS_FROZEN_START_BIT_POSITION

```solidity
uint256 IS_FROZEN_START_BIT_POSITION
```

### BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 BORROWING_ENABLED_START_BIT_POSITION
```

### STABLE_BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 STABLE_BORROWING_ENABLED_START_BIT_POSITION
```

### IS_PAUSED_START_BIT_POSITION

```solidity
uint256 IS_PAUSED_START_BIT_POSITION
```

### BORROWABLE_IN_ISOLATION_START_BIT_POSITION

```solidity
uint256 BORROWABLE_IN_ISOLATION_START_BIT_POSITION
```

### SILOED_BORROWING_START_BIT_POSITION

```solidity
uint256 SILOED_BORROWING_START_BIT_POSITION
```

### FLASHLOAN_ENABLED_START_BIT_POSITION

```solidity
uint256 FLASHLOAN_ENABLED_START_BIT_POSITION
```

### RESERVE_FACTOR_START_BIT_POSITION

```solidity
uint256 RESERVE_FACTOR_START_BIT_POSITION
```

### BORROW_CAP_START_BIT_POSITION

```solidity
uint256 BORROW_CAP_START_BIT_POSITION
```

### SUPPLY_CAP_START_BIT_POSITION

```solidity
uint256 SUPPLY_CAP_START_BIT_POSITION
```

### MAX_VALID_LTV

```solidity
uint256 MAX_VALID_LTV
```

### MAX_VALID_LIQUIDATION_THRESHOLD

```solidity
uint256 MAX_VALID_LIQUIDATION_THRESHOLD
```

### MAX_VALID_LIQUIDATION_BONUS

```solidity
uint256 MAX_VALID_LIQUIDATION_BONUS
```

### MAX_VALID_DECIMALS

```solidity
uint256 MAX_VALID_DECIMALS
```

### MAX_VALID_RESERVE_FACTOR

```solidity
uint256 MAX_VALID_RESERVE_FACTOR
```

### MAX_VALID_BORROW_CAP

```solidity
uint256 MAX_VALID_BORROW_CAP
```

### MAX_VALID_SUPPLY_CAP

```solidity
uint256 MAX_VALID_SUPPLY_CAP
```

### MAX_VALID_LIQUIDATION_PROTOCOL_FEE

```solidity
uint256 MAX_VALID_LIQUIDATION_PROTOCOL_FEE
```

### MAX_RESERVES_COUNT

```solidity
uint16 MAX_RESERVES_COUNT
```

### setLtv

```solidity
function setLtv(struct DataTypes.ReserveConfigurationMap self, uint256 ltv) internal pure
```

Sets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| ltv | uint256 | The new ltv |

### getLtv

```solidity
function getLtv(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The loan to value |

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self, uint256 threshold) internal pure
```

Sets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| threshold | uint256 | The new liquidation threshold |

### getLiquidationThreshold

```solidity
function getLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation threshold |

### setLiquidationBonus

```solidity
function setLiquidationBonus(struct DataTypes.ReserveConfigurationMap self, uint256 bonus) internal pure
```

Sets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| bonus | uint256 | The new liquidation bonus |

### getLiquidationBonus

```solidity
function getLiquidationBonus(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation bonus |

### setDecimals

```solidity
function setDecimals(struct DataTypes.ReserveConfigurationMap self, uint256 decimals) internal pure
```

Sets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| decimals | uint256 | The decimals |

### getDecimals

```solidity
function getDecimals(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The decimals of the asset |

### setFrozen

```solidity
function setFrozen(struct DataTypes.ReserveConfigurationMap self, bool frozen) internal pure
```

Sets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| frozen | bool | The frozen state |

### getFrozen

```solidity
function getFrozen(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The frozen state |

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self, bool enabled) internal pure
```

Enables or disables borrowing on the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| enabled | bool | True if the borrowing needs to be enabled, false otherwise |

### getBorrowingEnabled

```solidity
function getBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the borrowing state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The borrowing state |

### setBorrowCap

```solidity
function setBorrowCap(struct DataTypes.ReserveConfigurationMap self, uint256 borrowCap) internal pure
```

Sets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| borrowCap | uint256 | The borrow cap |

### getBorrowCap

```solidity
function getBorrowCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The borrow cap |

### setSupplyCap

```solidity
function setSupplyCap(struct DataTypes.ReserveConfigurationMap self, uint256 supplyCap) internal pure
```

Sets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| supplyCap | uint256 | The supply cap |

### getSupplyCap

```solidity
function getSupplyCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The supply cap |

### getFlags

```solidity
function getFlags(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool, bool)
```

Gets the configuration flags of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The state flag representing frozen |
| [1] | bool | The state flag representing borrowing enabled |

### getParams

```solidity
function getParams(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256, uint256, uint256, uint256)
```

Gets the configuration parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing ltv |
| [1] | uint256 | The state param representing liquidation threshold |
| [2] | uint256 | The state param representing liquidation bonus |
| [3] | uint256 | The state param representing reserve decimals |
| [4] | uint256 | The state param representing reserve factor |

