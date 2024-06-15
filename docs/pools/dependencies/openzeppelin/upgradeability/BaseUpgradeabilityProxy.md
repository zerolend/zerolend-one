# Solidity API

## BaseUpgradeabilityProxy

_This contract implements a proxy that allows to change the
implementation address to which it will delegate.
Such a change is called an implementation upgrade._

### Upgraded

```solidity
event Upgraded(address implementation)
```

_Emitted when the implementation is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | Address of the new implementation. |

### IMPLEMENTATION_SLOT

```solidity
bytes32 IMPLEMENTATION_SLOT
```

_Storage slot with the address of the current implementation.
This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1, and is
validated in the constructor._

### _implementation

```solidity
function _implementation() internal view returns (address impl)
```

_Returns the current implementation._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| impl | address | Address of the current implementation |

### _upgradeTo

```solidity
function _upgradeTo(address newImplementation) internal
```

_Upgrades the proxy to a new implementation._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

### _setImplementation

```solidity
function _setImplementation(address newImplementation) internal
```

_Sets the implementation address of the proxy._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

