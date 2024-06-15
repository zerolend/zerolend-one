# Solidity API

## IPriceOracleSentinel

Defines the basic interface for the PriceOracleSentinel

### SequencerOracleUpdated

```solidity
event SequencerOracleUpdated(address newSequencerOracle)
```

_Emitted after the sequencer oracle is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSequencerOracle | address | The new sequencer oracle |

### GracePeriodUpdated

```solidity
event GracePeriodUpdated(uint256 newGracePeriod)
```

_Emitted after the grace period is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newGracePeriod | uint256 | The new grace period value |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### isBorrowAllowed

```solidity
function isBorrowAllowed() external view returns (bool)
```

Returns true if the `borrow` operation is allowed.

_Operation not allowed when PriceOracle is down or grace period not passed._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the `borrow` operation is allowed, false otherwise. |

### isLiquidationAllowed

```solidity
function isLiquidationAllowed() external view returns (bool)
```

Returns true if the `liquidation` operation is allowed.

_Operation not allowed when PriceOracle is down or grace period not passed._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the `liquidation` operation is allowed, false otherwise. |

### setSequencerOracle

```solidity
function setSequencerOracle(address newSequencerOracle) external
```

Updates the address of the sequencer oracle

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSequencerOracle | address | The address of the new Sequencer Oracle to use |

### setGracePeriod

```solidity
function setGracePeriod(uint256 newGracePeriod) external
```

Updates the duration of the grace period

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newGracePeriod | uint256 | The value of the new grace period duration |

### getSequencerOracle

```solidity
function getSequencerOracle() external view returns (address)
```

Returns the SequencerOracle

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the sequencer oracle contract |

### getGracePeriod

```solidity
function getGracePeriod() external view returns (uint256)
```

Returns the grace period

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The duration of the grace period |

