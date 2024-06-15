# Solidity API

## BaseAdminUpgradeabilityProxy

_This contract combines an upgradeability proxy with an authorization
mechanism for administrative tasks.
All external functions in this contract must be guarded by the
`ifAdmin` modifier. See ethereum/solidity#3864 for a Solidity
feature proposal that would enable this to be done automatically._

### AdminChanged

```solidity
event AdminChanged(address previousAdmin, address newAdmin)
```

_Emitted when the administration has been transferred._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| previousAdmin | address | Address of the previous admin. |
| newAdmin | address | Address of the new admin. |

### ADMIN_SLOT

```solidity
bytes32 ADMIN_SLOT
```

_Storage slot with the admin of the contract.
This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1, and is
validated in the constructor._

### ifAdmin

```solidity
modifier ifAdmin()
```

_Modifier to check whether the `msg.sender` is the admin.
If it is, it will run the function. Otherwise, it will delegate the call
to the implementation._

### admin

```solidity
function admin() external returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the proxy admin. |

### implementation

```solidity
function implementation() external returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation. |

### changeAdmin

```solidity
function changeAdmin(address newAdmin) external
```

_Changes the admin of the proxy.
Only the current admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAdmin | address | Address to transfer proxy administration to. |

### upgradeTo

```solidity
function upgradeTo(address newImplementation) external
```

_Upgrade the backing implementation of the proxy.
Only the admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

### upgradeToAndCall

```solidity
function upgradeToAndCall(address newImplementation, bytes data) external payable
```

_Upgrade the backing implementation of the proxy and call a function
on the new implementation.
This is useful to initialize the proxied contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |
| data | bytes | Data to send as msg.data in the low level call. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. |

### _admin

```solidity
function _admin() internal view returns (address adm)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| adm | address | The admin slot. |

### _setAdmin

```solidity
function _setAdmin(address newAdmin) internal
```

_Sets the address of the proxy admin._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAdmin | address | Address of the new proxy admin. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

_Only fall back when the sender is not the admin._

