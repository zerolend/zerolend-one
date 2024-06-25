# Solidity API

## TimelockControllerEnumerable

### constructor

```solidity
constructor(uint256 minDelay, address[] proposers, address[] executors, address admin) public
```

_Sets the value for {name} and {version}_

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### _grantRole

```solidity
function _grantRole(bytes32 role, address account) internal virtual
```

_Overload {_grantRole} to track enumerable memberships_

### _revokeRole

```solidity
function _revokeRole(bytes32 role, address account) internal virtual
```

_Overload {_revokeRole} to track enumerable memberships_

