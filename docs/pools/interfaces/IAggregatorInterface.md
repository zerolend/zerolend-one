# Solidity API

## IAggregatorInterface

### latestAnswer

```solidity
function latestAnswer() external view returns (int256)
```

### latestTimestamp

```solidity
function latestTimestamp() external view returns (uint256)
```

### latestRound

```solidity
function latestRound() external view returns (uint256)
```

### getAnswer

```solidity
function getAnswer(uint256 roundId) external view returns (int256)
```

### getTimestamp

```solidity
function getTimestamp(uint256 roundId) external view returns (uint256)
```

### AnswerUpdated

```solidity
event AnswerUpdated(int256 current, uint256 roundId, uint256 updatedAt)
```

### NewRound

```solidity
event NewRound(uint256 roundId, address startedBy, uint256 startedAt)
```

