# Solidity API

## Proxy

_Implements delegation of calls to other contracts, with proper
forwarding of return values and bubbling of failures.
It defines a fallback function that delegates all calls to the address
returned by the abstract _implementation() internal function._

### fallback

```solidity
fallback() external payable
```

_Fallback function.
Will run if no other function in the contract matches the call data.
Implemented entirely in `_fallback`._

### _implementation

```solidity
function _implementation() internal view virtual returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Address of the implementation. |

### _delegate

```solidity
function _delegate(address implementation) internal
```

_Delegates execution to an implementation contract.
This is a low level function that doesn't return to its internal call site.
It will return to the external caller whatever the implementation returns._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | Address to delegate. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

_Function that is run as the first thing in the fallback function.
Can be redefined in derived contracts to add functionality.
Redefinitions must call super._willFallback()._

### _fallback

```solidity
function _fallback() internal
```

_fallback implementation.
Extracted to enable manual triggering._

