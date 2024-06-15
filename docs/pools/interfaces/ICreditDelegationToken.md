# Solidity API

## ICreditDelegationToken

Defines the basic interface for a token supporting credit delegation.

### BorrowAllowanceDelegated

```solidity
event BorrowAllowanceDelegated(address fromUser, address toUser, address asset, uint256 amount)
```

_Emitted on `approveDelegation` and `borrowAllowance_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromUser | address | The address of the delegator |
| toUser | address | The address of the delegatee |
| asset | address | The address of the delegated asset |
| amount | uint256 | The amount being delegated |

### approveDelegation

```solidity
function approveDelegation(address delegatee, uint256 amount) external
```

Delegates borrowing power to a user on the specific debt token.
Delegation will still respect the liquidation constraints (even if delegated, a
delegatee cannot force a delegator HF to go below 1)

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| delegatee | address | The address receiving the delegated borrowing power |
| amount | uint256 | The maximum amount being delegated. |

### borrowAllowance

```solidity
function borrowAllowance(address fromUser, address toUser) external view returns (uint256)
```

Returns the borrow allowance of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromUser | address | The user to giving allowance |
| toUser | address | The user to give allowance to |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The current allowance of `toUser` |

