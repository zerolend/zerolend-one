# Solidity API

## PendingLib

Library to manage pending values and their validity timestamp.

### update

```solidity
function update(struct PendingUint192 pending, uint184 newValue, uint256 timelock) internal
```

_Updates `pending`'s value to `newValue` and its corresponding `validAt` timestamp.
Assumes `timelock` <= `MAX_TIMELOCK`._

### update

```solidity
function update(struct PendingAddress pending, address newValue, uint256 timelock) internal
```

_Updates `pending`'s value to `newValue` and its corresponding `validAt` timestamp.
Assumes `timelock` <= `MAX_TIMELOCK`._

