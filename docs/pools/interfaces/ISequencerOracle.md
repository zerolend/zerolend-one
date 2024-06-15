# Solidity API

## ISequencerOracle

Defines the basic interface for a Sequencer oracle.

### latestRoundData

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
```

Returns the health status of the sequencer.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| roundId | uint80 | The round ID from the aggregator for which the data was retrieved combined with a phase to ensure that round IDs get larger as time moves forward. |
| answer | int256 | The answer for the latest round: 0 if the sequencer is up, 1 if it is down. |
| startedAt | uint256 | The timestamp when the round was started. |
| updatedAt | uint256 | The timestamp of the block in which the answer was updated on L1. |
| answeredInRound | uint80 | The round ID of the round in which the answer was computed. |

