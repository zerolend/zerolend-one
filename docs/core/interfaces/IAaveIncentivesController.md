# Solidity API

## IAaveIncentivesController

Defines the basic interface for an Aave Incentives Controller.

_It only contains one single function, needed as a hook on aToken and debtToken transfers._

### handleAction

```solidity
function handleAction(address user, uint256 totalSupply, uint256 userBalance) external
```

_Called by the corresponding asset on transfer hook in order to update the rewards distribution.
The units of `totalSupply` and `userBalance` should be the same._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user whose asset balance has changed |
| totalSupply | uint256 | The total supply of the asset prior to user balance change |
| userBalance | uint256 | The previous user balance prior to balance change |

