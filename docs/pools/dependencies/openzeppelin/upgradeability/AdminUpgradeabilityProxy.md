# Solidity API

## AdminUpgradeabilityProxy

_Extends from BaseAdminUpgradeabilityProxy with a constructor for
initializing the implementation, admin, and init data._

### constructor

```solidity
constructor(address _logic, address _admin, bytes _data) public payable
```

Contract constructor.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _logic | address | address of the initial implementation. |
| _admin | address | Address of the proxy administrator. |
| _data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

### _willFallback

```solidity
function _willFallback() internal
```

_Only fall back when the sender is not the admin._
