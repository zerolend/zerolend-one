# Solidity API

## MintableIncentivizedERC20

Implements mint and burn functions for IncentivizedERC20

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

### _mint

```solidity
function _mint(address account, uint128 amount) internal virtual
```

Mints tokens to an account and apply incentives if defined

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The address receiving tokens |
| amount | uint128 | The amount of tokens to mint |

### _burn

```solidity
function _burn(address account, uint128 amount) internal virtual
```

Burns tokens from an account and apply incentives if defined

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The account whose tokens are burnt |
| amount | uint128 | The amount of tokens to burn |

