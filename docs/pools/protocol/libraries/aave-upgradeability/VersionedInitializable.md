# Solidity API

## VersionedInitializable

Helper contract to implement initializer functions. To use it, replace
the constructor with a function that has the `initializer` modifier.

_WARNING: Unlike constructors, initializer functions must be manually
invoked. This applies both to deploying an Initializable contract, as well
as extending an Initializable contract via inheritance.
WARNING: When used with inheritance, manual care must be taken to not invoke
a parent initializer twice, or ensure that all initializers are idempotent,
because this is not dealt with automatically as with constructors._

### initializer

```solidity
modifier initializer()
```

_Modifier to use in the initializer function of a contract._

### getRevision

```solidity
function getRevision() internal pure virtual returns (uint256)
```

Returns the revision number of the contract

_Needs to be defined in the inherited class as a constant._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The revision number |

