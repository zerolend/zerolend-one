# Solidity API

## Helpers

### getUserCurrentDebt

```solidity
function getUserCurrentDebt(address user, struct DataTypes.ReserveCache reserveCache) internal view returns (uint256, uint256)
```

Fetches the user current stable and variable debt balances

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| reserveCache | struct DataTypes.ReserveCache | The reserve cache data object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable debt balance |
| [1] | uint256 | The variable debt balance |

