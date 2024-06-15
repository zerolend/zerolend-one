# Solidity API

## InitializableUpgradeabilityProxy

_Extends BaseUpgradeabilityProxy with an initializer for initializing
implementation and init data._

### initialize

```solidity
function initialize(address _logic, bytes _data) public payable
```

_Contract initializer._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _logic | address | Address of the initial implementation. |
| _data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

