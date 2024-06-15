# Solidity API

## TimelockedActions

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

### _DONE_TIMESTAMP

```solidity
uint256 _DONE_TIMESTAMP
```

### PROPOSER_ROLE

```solidity
bytes32 PROPOSER_ROLE
```

### CANCELLER_ROLE

```solidity
bytes32 CANCELLER_ROLE
```

### constructor

```solidity
constructor(uint256 minDelay, address admin) public
```

_Initializes the contract with the following parameters:

- `minDelay`: initial minimum delay in seconds for operations
- `proposers`: accounts to be granted proposer and canceller roles
- `executors`: accounts to be granted executor role
- `admin`: optional account to be granted admin role; disable with zero address

IMPORTANT: The optional admin can aid with initial configuration of roles after deployment
without being subject to delay, but this role should be subsequently renounced in favor of
administration through timelocked proposals. Previous versions of this contract would assign
this admin to the deployer automatically and should be renounced as well._

### onlyRoleOrOpenRole

```solidity
modifier onlyRoleOrOpenRole(bytes32 role)
```

_Modifier to make a function callable only by a certain role. In
addition to checking the sender's role, `address(0)` 's role is also
considered. Granting a role to `address(0)` is equivalent to enabling
this role for everyone._

### receive

```solidity
receive() external payable
```

_Contract might receive/hold ETH as part of the maintenance process._

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
function hashOperation(address target, uint256 value, bytes data, bytes32 predecessor, bytes32 salt) public pure virtual returns (bytes32)
```

_Returns the identifier of an operation containing a single
transaction._

### hashOperationBatch

```solidity
function hashOperationBatch(address[] targets, uint256[] values, bytes[] payloads, bytes32 predecessor, bytes32 salt) public pure virtual returns (bytes32)
```

_Returns the identifier of an operation containing a batch of
transactions._

### schedule

```solidity
function schedule(address target, uint256 value, bytes data, bytes32 predecessor, bytes32 salt, uint256 delay) internal virtual
```

_Schedule an operation containing a single transaction.

Emits {CallSalt} if salt is nonzero, and {CallScheduled}.

Requirements:

- the caller must have the 'proposer' role._

### cancel

```solidity
function cancel(bytes32 id) public virtual
```

_Cancel an operation.

Requirements:

- the caller must have the 'canceller' role._

### execute

```solidity
function execute(address target, uint256 value, bytes payload, bytes32 predecessor, bytes32 salt) public payable virtual
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

### getRoleFromPool

```solidity
function getRoleFromPool(address pool, bytes32 role) public pure returns (bytes32)
```

