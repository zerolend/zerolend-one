# Solidity API

## BeaconProxy

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
constructor(address _beacon, address _admin, bytes _data) public payable
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

