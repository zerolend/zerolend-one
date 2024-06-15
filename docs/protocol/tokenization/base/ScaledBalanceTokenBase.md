# Solidity API

## ScaledBalanceTokenBase

Basic ERC20 implementation of scaled balance token

### constructor

```solidity
constructor(contract IPool pool, string name, string symbol, uint8 decimals) internal
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The reference to the main Pool contract |
| name | string | The name of the token |
| symbol | string | The symbol of the token |
| decimals | uint8 | The number of decimals of the token |

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
function scaledTotalSupply() public view virtual returns (uint256)
```

Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total supply |

### getPreviousIndex

```solidity
function getPreviousIndex(address user) external view virtual returns (uint256)
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

### _mintScaled

```solidity
function _mintScaled(address caller, address onBehalfOf, uint256 amount, uint256 index) internal returns (bool)
```

Implements the basic logic to mint a scaled balance token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the scaled tokens |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` if the the previous balance of the user was 0 |

### _burnScaled

```solidity
function _burnScaled(address user, address target, uint256 amount, uint256 index) internal
```

Implements the basic logic to burn a scaled balance token.

_In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user which debt is burnt |
| target | address | The address that will receive the underlying, if any |
| amount | uint256 | The amount getting burned |
| index | uint256 | The variable debt index of the reserve |

### _transfer

```solidity
function _transfer(address sender, address recipient, uint256 amount, uint256 index) internal
```

Implements the basic logic to transfer scaled balance tokens between two users

_It emits a mint event with the interest accrued per user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | The source address |
| recipient | address | The destination address |
| amount | uint256 | The amount getting transferred |
| index | uint256 | The next liquidity index of the reserve |

