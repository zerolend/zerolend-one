# Solidity API

## RevokableBeaconProxy

This is a beacon proxy contract that has the ability for the proxy admin to revoke
the beacon's ability to upgrade the contract.

### _IMPLEMENTATION_SLOT

```solidity
bytes32 _IMPLEMENTATION_SLOT
```

### _BEACON_SLOT

```solidity
bytes32 _BEACON_SLOT
```

### _ADMIN_SLOT

```solidity
bytes32 _ADMIN_SLOT
```

### constructor

```solidity
constructor(address _beacon, address _admin) public payable
```

### _implementation

```solidity
function _implementation() internal view virtual returns (address)
```

_Returns the current implementation address of the associated beacon._

### setAdmin

```solidity
function setAdmin(address newAdmin) external
```

### revokeBeacon

```solidity
function revokeBeacon() external
```

Revokes the beacon's ability to upgrade this contract and forver seals the implementation
into the code forever.

### implementation

```solidity
function implementation() external view returns (address)
```

### admin

```solidity
function admin() external view returns (address)
```

### beacon

```solidity
function beacon() external view returns (address)
```

### isBeaconRevoked

```solidity
function isBeaconRevoked() external view returns (bool revoked)
```

Checks if the beacon is revoked in which case the contract is as good as immutable.

_The revoked implementation address can be found in the `implementation()` call._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| revoked | bool | True iff the beacon has been revoked. |

