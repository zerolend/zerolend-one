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

### ACTIVE_MASK

```solidity
uint256 ACTIVE_MASK
```

### FROZEN_MASK

```solidity
uint256 FROZEN_MASK
```

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### STABLE_BORROWING_MASK

```solidity
uint256 STABLE_BORROWING_MASK
```

### PAUSED_MASK

```solidity
uint256 PAUSED_MASK
```

### BORROWABLE_IN_ISOLATION_MASK

```solidity
uint256 BORROWABLE_IN_ISOLATION_MASK
```

### SILOED_BORROWING_MASK

```solidity
uint256 SILOED_BORROWING_MASK
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

### LIQUIDATION_PROTOCOL_FEE_MASK

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_MASK
```

### EMODE_CATEGORY_MASK

```solidity
uint256 EMODE_CATEGORY_MASK
```

### UNBACKED_MINT_CAP_MASK

```solidity
uint256 UNBACKED_MINT_CAP_MASK
```

### DEBT_CEILING_MASK

```solidity
uint256 DEBT_CEILING_MASK
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

### LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION
```

### EMODE_CATEGORY_START_BIT_POSITION

```solidity
uint256 EMODE_CATEGORY_START_BIT_POSITION
```

### UNBACKED_MINT_CAP_START_BIT_POSITION

```solidity
uint256 UNBACKED_MINT_CAP_START_BIT_POSITION
```

### DEBT_CEILING_START_BIT_POSITION

```solidity
uint256 DEBT_CEILING_START_BIT_POSITION
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

### MAX_VALID_EMODE_CATEGORY

```solidity
uint256 MAX_VALID_EMODE_CATEGORY
```

### MAX_VALID_UNBACKED_MINT_CAP

```solidity
uint256 MAX_VALID_UNBACKED_MINT_CAP
```

### MAX_VALID_DEBT_CEILING

```solidity
uint256 MAX_VALID_DEBT_CEILING
```

### DEBT_CEILING_DECIMALS

```solidity
uint256 DEBT_CEILING_DECIMALS
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

### setActive

```solidity
function setActive(struct DataTypes.ReserveConfigurationMap self, bool active) internal pure
```

Sets the active state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| active | bool | The active state |

### getActive

```solidity
function getActive(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the active state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The active state |

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

### setPaused

```solidity
function setPaused(struct DataTypes.ReserveConfigurationMap self, bool paused) internal pure
```

Sets the paused state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| paused | bool | The paused state |

### getPaused

```solidity
function getPaused(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the paused state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The paused state |

### setBorrowableInIsolation

```solidity
function setBorrowableInIsolation(struct DataTypes.ReserveConfigurationMap self, bool borrowable) internal pure
```

Sets the borrowable in isolation flag for the reserve.

_When this flag is set to true, the asset will be borrowable against isolated collaterals and the borrowed
amount will be accumulated in the isolated collateral's total debt exposure.
Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
consistency in the debt ceiling calculations._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| borrowable | bool | True if the asset is borrowable |

### getBorrowableInIsolation

```solidity
function getBorrowableInIsolation(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the borrowable in isolation flag for the reserve.

_If the returned flag is true, the asset is borrowable against isolated collateral. Assets borrowed with
isolated collateral is accounted for in the isolated collateral's total debt exposure.
Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
consistency in the debt ceiling calculations._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The borrowable in isolation flag |

### setSiloedBorrowing

```solidity
function setSiloedBorrowing(struct DataTypes.ReserveConfigurationMap self, bool siloed) internal pure
```

Sets the siloed borrowing flag for the reserve.

_When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| siloed | bool | True if the asset is siloed |

### getSiloedBorrowing

```solidity
function getSiloedBorrowing(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the siloed borrowing flag for the reserve.

_When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The siloed borrowing flag |

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

### setStableRateBorrowingEnabled

```solidity
function setStableRateBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self, bool enabled) internal pure
```

Enables or disables stable rate borrowing on the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| enabled | bool | True if the stable rate borrowing needs to be enabled, false otherwise |

### getStableRateBorrowingEnabled

```solidity
function getStableRateBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the stable rate borrowing state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The stable rate borrowing state |

### setReserveFactor

```solidity
function setReserveFactor(struct DataTypes.ReserveConfigurationMap self, uint256 reserveFactor) internal pure
```

Sets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| reserveFactor | uint256 | The reserve factor |

### getReserveFactor

```solidity
function getReserveFactor(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve factor |

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

### setDebtCeiling

```solidity
function setDebtCeiling(struct DataTypes.ReserveConfigurationMap self, uint256 ceiling) internal pure
```

Sets the debt ceiling in isolation mode for the asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| ceiling | uint256 | The maximum debt ceiling for the asset |

### getDebtCeiling

```solidity
function getDebtCeiling(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the debt ceiling for the asset if the asset is in isolation mode

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling (0 = isolation mode disabled) |

### setLiquidationProtocolFee

```solidity
function setLiquidationProtocolFee(struct DataTypes.ReserveConfigurationMap self, uint256 liquidationProtocolFee) internal pure
```

Sets the liquidation protocol fee of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| liquidationProtocolFee | uint256 | The liquidation protocol fee |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the liquidation protocol fee_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation protocol fee |

### setUnbackedMintCap

```solidity
function setUnbackedMintCap(struct DataTypes.ReserveConfigurationMap self, uint256 unbackedMintCap) internal pure
```

Sets the unbacked mint cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| unbackedMintCap | uint256 | The unbacked mint cap |

### getUnbackedMintCap

```solidity
function getUnbackedMintCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the unbacked mint cap of the reserve_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The unbacked mint cap |

### setEModeCategory

```solidity
function setEModeCategory(struct DataTypes.ReserveConfigurationMap self, uint256 category) internal pure
```

Sets the eMode asset category

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| category | uint256 | The asset category when the user selects the eMode |

### getEModeCategory

```solidity
function getEModeCategory(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the eMode asset category_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode category for the asset |

### setFlashLoanEnabled

```solidity
function setFlashLoanEnabled(struct DataTypes.ReserveConfigurationMap self, bool flashLoanEnabled) internal pure
```

Sets the flashloanable flag for the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| flashLoanEnabled | bool | True if the asset is flashloanable, false otherwise |

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the flashloanable flag for the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The flashloanable flag |

### getFlags

```solidity
function getFlags(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool, bool, bool, bool, bool)
```

Gets the configuration flags of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The state flag representing active |
| [1] | bool | The state flag representing frozen |
| [2] | bool | The state flag representing borrowing enabled |
| [3] | bool | The state flag representing stableRateBorrowing enabled |
| [4] | bool | The state flag representing paused |

### getParams

```solidity
function getParams(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256, uint256, uint256, uint256, uint256)
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
| [5] | uint256 | The state param representing eMode category |

### getCaps

```solidity
function getCaps(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256)
```

Gets the caps parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing borrow cap |
| [1] | uint256 | The state param representing supply cap. |

