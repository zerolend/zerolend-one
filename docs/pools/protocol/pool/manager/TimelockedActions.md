# Solidity API

## TimelockedActions

### _DONE_TIMESTAMP

```solidity
uint256 _DONE_TIMESTAMP
```

### constructor

```solidity
constructor(uint256 minDelay) public
```

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### isOperation

```solidity
function isOperation(bytes32 id) public view returns (bool)
```

_Returns whether an id corresponds to a registered operation. This
includes both Waiting, Ready, and Done operations._

### isOperationPending

```solidity
function isOperationPending(bytes32 id) public view returns (bool)
```

_Returns whether an operation is pending or not. Note that a "pending" operation may also be "ready"._

### isOperationReady

```solidity
function isOperationReady(bytes32 id) public view returns (bool)
```

_Returns whether an operation is ready for execution. Note that a "ready" operation is also "pending"._

### isOperationDone

```solidity
function isOperationDone(bytes32 id) public view returns (bool)
```

_Returns whether an operation is done or not._

### getTimestamp

```solidity
function getTimestamp(bytes32 id) public view virtual returns (uint256)
```

_Returns the timestamp at which an operation becomes ready (0 for
unset operations, 1 for done operations)._

### getOperationState

```solidity
function getOperationState(bytes32 id) public view virtual returns (enum ITimelock.OperationState)
```

_Returns operation state._

### getMinDelay

```solidity
function getMinDelay() public view virtual returns (uint256)
```

_Returns the minimum delay in seconds for an operation to become valid.

This value can be changed by executing an operation that calls `updateDelay`._

### hashOperation

```solidity
function hashOperation(address target, uint256 value, bytes data, bytes32 salt) public pure virtual returns (bytes32)
```

_Returns the identifier of an operation containing a single
transaction._

### _schedule

```solidity
function _schedule(address target, uint256 value, bytes data, bytes32 salt, uint256 delay) internal virtual
```

_Schedule an operation containing a single transaction.

Emits {CallSalt} if salt is nonzero, and {CallScheduled}.

Requirements:

- the caller must have the 'proposer' role._

### cancel

```solidity
function cancel(bytes32 id) internal
```

_Cancel an operation.

Requirements:

- the caller must have the 'canceller' role._

### execute

```solidity
function execute(address target, uint256 value, bytes payload, bytes32 salt) public payable virtual
```

_Execute an (ready) operation containing a single transaction.

Emits a {CallExecuted} event.

Requirements:

- the caller must have the 'executor' role._

### _execute

```solidity
function _execute(address target, uint256 value, bytes data) internal virtual
```

_Execute an operation's call._

### _encodeStateBitmap

```solidity
function _encodeStateBitmap(enum ITimelock.OperationState operationState) internal pure returns (bytes32)
```

_Encodes a `OperationState` into a `bytes32` representation where each bit enabled corresponds to
the underlying position in the `OperationState` enum. For example:

0x000...1000
  ^^^^^^----- ...
        ^---- Done
         ^--- Ready
          ^-- Waiting
           ^- Unset_

