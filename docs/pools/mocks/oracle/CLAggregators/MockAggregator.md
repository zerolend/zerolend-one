# Solidity API

## MockAggregator

### AnswerUpdated

```solidity
event AnswerUpdated(int256 current, uint256 roundId, uint256 updatedAt)
```

### constructor

```solidity
constructor(int256 initialAnswer) public
```

### latestAnswer

```solidity
function latestAnswer() external view returns (int256)
```

### getTokenType

```solidity
function getTokenType() external pure returns (uint256)
```

### decimals

```solidity
function decimals() external pure returns (uint8)
```

