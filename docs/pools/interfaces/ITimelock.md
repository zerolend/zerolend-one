# Solidity API

## ITimelock

_Contract module which acts as a timelocked controller. When set as the
owner of an `Ownable` smart contract, it enforces a timelock on all
`onlyOwner` maintenance operations. This gives time for users of the
controlled contract to exit before a potentially dangerous maintenance
operation is applied.

By default, this contract is self administered, meaning administration tasks
have to go through the timelock process. The proposer (resp executor) role
is in charge of proposing (resp executing) operations. A common use case is
to position this {TimelockController} as the owner of a smart contract, with
a multisig or a DAO as the sole proposer._

### OperationState

```solidity
enum OperationState {
  Unset,
  Waiting,
  Ready,
  Done
}
```

### TimelockInvalidOperationLength

```solidity
error TimelockInvalidOperationLength(uint256 targets, uint256 payloads, uint256 values)
```

_Mismatch between the parameters length for an operation call._

### TimelockInsufficientDelay

```solidity
error TimelockInsufficientDelay(uint256 delay, uint256 minDelay)
```

_The schedule operation doesn't meet the minimum delay._

### TimelockUnexpectedOperationState

```solidity
error TimelockUnexpectedOperationState(bytes32 operationId, bytes32 expectedStates)
```

_The current state of an operation is not as required.
The `expectedStates` is a bitmap with the bits enabled for each OperationState enum position
counting from right to left.

See {_encodeStateBitmap}._

### TimelockUnexecutedPredecessor

```solidity
error TimelockUnexecutedPredecessor(bytes32 predecessorId)
```

_The predecessor to an operation not yet done._

### TimelockUnauthorizedCaller

```solidity
error TimelockUnauthorizedCaller(address caller)
```

_The caller account is not authorized._

### CallScheduled

```solidity
event CallScheduled(bytes32 id, uint256 index, address target, uint256 value, bytes data, bytes32 predecessor, uint256 delay)
```

_Emitted when a call is scheduled as part of operation `id`._

### CallExecuted

```solidity
event CallExecuted(bytes32 id, uint256 index, address target, uint256 value, bytes data)
```

_Emitted when a call is performed as part of operation `id`._

### CallSalt

```solidity
event CallSalt(bytes32 id, bytes32 salt)
```

_Emitted when new proposal is scheduled with non-zero salt._

### Cancelled

```solidity
event Cancelled(bytes32 id)
```

_Emitted when operation `id` is cancelled._

### MinDelayChange

```solidity
event MinDelayChange(uint256 oldDuration, uint256 newDuration)
```

_Emitted when the minimum delay for future operations is modified._

