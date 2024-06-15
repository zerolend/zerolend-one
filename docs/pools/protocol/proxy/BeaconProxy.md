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
constructor(address beacon, address _admin, bytes data) public payable
```

### _beacon

```solidity
function _beacon() internal view virtual returns (address)
```

_Returns the current beacon address._

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

### _getBeacon

```solidity
function _getBeacon() internal view returns (address)
```

### _getAdmin

```solidity
function _getAdmin() internal view returns (address)
```

### _getFrozenImpl

```solidity
function _getFrozenImpl() internal view returns (address)
```

