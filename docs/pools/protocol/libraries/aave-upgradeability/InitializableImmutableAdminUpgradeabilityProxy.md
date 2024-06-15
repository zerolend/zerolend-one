# Solidity API

## InitializableImmutableAdminUpgradeabilityProxy

_Extends BaseAdminUpgradeabilityProxy with an initializer function_

### constructor

```solidity
constructor(address admin) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin |

### _willFallback

```solidity
function _willFallback() internal
```

Only fall back when the sender is not the admin.

