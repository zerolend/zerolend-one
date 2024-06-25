# Solidity API

## ZeroLendGovernor

### constructor

```solidity
constructor(contract IVotes _token, contract TimelockController _timelock) public
```

### votingDelay

```solidity
function votingDelay() public view returns (uint256)
```

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

### votingPeriod

```solidity
function votingPeriod() public view returns (uint256)
```

### quorum

```solidity
function quorum(uint256 blockNumber) public view returns (uint256)
```

### state

```solidity
function state(uint256 proposalId) public view returns (enum IGovernor.ProposalState)
```

### proposalThreshold

```solidity
function proposalThreshold() public view returns (uint256)
```

### _cancel

```solidity
function _cancel(address[] targets, uint256[] values, bytes[] calldatas, bytes32 descriptionHash) internal returns (uint256)
```

### _executor

```solidity
function _executor() internal view returns (address)
```

### _execute

```solidity
function _execute(uint256 id, address[] targets, uint256[] values, bytes[] calldatas, bytes32 descriptionHash) internal virtual
```

