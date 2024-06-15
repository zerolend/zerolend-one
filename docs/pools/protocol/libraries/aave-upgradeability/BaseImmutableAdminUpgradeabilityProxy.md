# Solidity API

## BaseImmutableAdminUpgradeabilityProxy

This contract combines an upgradeability proxy with an authorization
mechanism for administrative tasks.

_The admin role is stored in an immutable, which helps saving transactions costs
All external functions in this contract must be guarded by the
`ifAdmin` modifier. See ethereum/solidity#3864 for a Solidity
feature proposal that would enable this to be done automatically._

### _admin

```solidity
address _admin
```

### constructor

```solidity
constructor(address admin) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin |

### ifAdmin

```solidity
modifier ifAdmin()
```

### admin

```solidity
function admin() external returns (address)
```

Return the admin address

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the proxy admin. |

### implementation

```solidity
function implementation() external returns (address)
```

Return the implementation address

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation. |

### upgradeTo

```solidity
function upgradeTo(address newImplementation) external
```

Upgrade the backing implementation of the proxy.

_Only the admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | The address of the new implementation. |

### upgradeToAndCall

```solidity
function upgradeToAndCall(address newImplementation, bytes data) external payable
```

Upgrade the backing implementation of the proxy and call a function
on the new implementation.

_This is useful to initialize the proxied contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | The address of the new implementation. |
| data | bytes | Data to send as msg.data in the low level call. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

Only fall back when the sender is not the admin.

