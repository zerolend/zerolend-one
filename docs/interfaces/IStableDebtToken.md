# Solidity API

## IStableDebtToken

Defines the interface for the stable debt token

_It does not inherit from IERC20 to save in code size_

### Mint

```solidity
event Mint(address user, address onBehalfOf, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 newRate, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is minted_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user who triggered the minting |
| onBehalfOf | address | The recipient of stable debt tokens |
| amount | uint256 | The amount minted (user entered amount + balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of the user 'onBehalfOf' |
| newRate | uint256 | The rate of the debt after the minting |
| avgStableRate | uint256 | The next average stable rate after the minting |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### Burn

```solidity
event Burn(address from, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is burned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount being burned (user entered amount - balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of 'from' |
| avgStableRate | uint256 | The next average stable rate after the burning |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 rate) external returns (bool, uint256, uint256)
```

Mints debt token to the `onBehalfOf` address.

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt tokens to mint |
| rate | uint256 | The rate of the debt being minted |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if it is the first borrow, false otherwise |
| [1] | uint256 | The total stable debt |
| [2] | uint256 | The average stable borrow rate |

### burn

```solidity
function burn(address from, uint256 amount) external returns (uint256, uint256)
```

Burns debt of `user`

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt
In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest the user earned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount of debt tokens getting burned |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total stable debt |
| [1] | uint256 | The average stable borrow rate |

### getAverageStableRate

```solidity
function getAverageStableRate() external view returns (uint256)
```

Returns the average rate of all the stable rate loans.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The average stable rate |

### getUserStableRate

```solidity
function getUserStableRate(address user) external view returns (uint256)
```

Returns the stable rate of the user debt

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable rate of the user |

### getUserLastUpdated

```solidity
function getUserLastUpdated(address user) external view returns (uint40)
```

Returns the timestamp of the last update of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getSupplyData

```solidity
function getSupplyData() external view returns (uint256, uint256, uint256, uint40)
```

Returns the principal, the total supply, the average stable rate and the timestamp for the last update

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The principal |
| [1] | uint256 | The total supply |
| [2] | uint256 | The average stable rate |
| [3] | uint40 | The timestamp of the last update |

### getTotalSupplyLastUpdated

```solidity
function getTotalSupplyLastUpdated() external view returns (uint40)
```

Returns the timestamp of the last update of the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getTotalSupplyAndAvgRate

```solidity
function getTotalSupplyAndAvgRate() external view returns (uint256, uint256)
```

Returns the total supply and the average stable rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply |
| [1] | uint256 | The average rate |

### principalBalanceOf

```solidity
function principalBalanceOf(address user) external view returns (uint256)
```

Returns the principal debt balance of the user

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt balance of the user since the last burn/mint action |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this stableDebtToken (E.g. WETH for stableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

