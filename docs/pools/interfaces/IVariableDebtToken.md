# Solidity API

## IVariableDebtToken

Defines the basic interface for a variable debt token.

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 index) external returns (bool, uint256)
```

Mints debt token to the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt being minted |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the previous balance of the user is 0, false otherwise |
| [1] | uint256 | The scaled total debt of the reserve |

### burn

```solidity
function burn(address from, uint256 amount, uint256 index) external returns (uint256)
```

Burns user variable debt

_In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount getting burned |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total debt of the reserve |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this debtToken (E.g. WETH for variableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

