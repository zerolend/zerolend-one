# Solidity API

## IScaledBalanceToken

Defines the basic interface for a scaled-balance token.

### Mint

```solidity
event Mint(address caller, address onBehalfOf, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the mint action_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted tokens |
| value | uint256 | The scaled-up amount being minted (based on user entered amount and balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'onBehalfOf' |
| index | uint256 | The next liquidity index of the reserve |

### Burn

```solidity
event Burn(address from, address target, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the burn action
If the burn function does not involve a transfer of the underlying asset, the target defaults to zero address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the tokens will be burned |
| target | address | The address that will receive the underlying, if any |
| value | uint256 | The scaled-up amount being burned (user entered amount - balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'from' |
| index | uint256 | The next liquidity index of the reserve |

### scaledBalanceOf

```solidity
function scaledBalanceOf(address user) external view returns (uint256)
```

Returns the scaled balance of the user.

_The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
at the moment of the update_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user whose balance is calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |

### getScaledUserBalanceAndSupply

```solidity
function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256)
```

Returns the scaled balance of the user and the scaled total supply.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |
| [1] | uint256 | The scaled total supply |

### scaledTotalSupply

```solidity
function scaledTotalSupply() external view returns (uint256)
```

Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total supply |

### getPreviousIndex

```solidity
function getPreviousIndex(address user) external view returns (uint256)
```

Returns last index interest was accrued to the user's balance

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The last index interest was accrued to the user's balance, expressed in ray |

