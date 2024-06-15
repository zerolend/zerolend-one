# Solidity API

## IInitializableDebtToken

Interface for the initialize function common between debt tokens

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params)
```

_Emitted when a debt token is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| incentivesController | address | The address of the incentives controller for this aToken |
| debtTokenDecimals | uint8 | The decimals of the debt token |
| debtTokenName | string | The name of the debt token |
| debtTokenSymbol | string | The symbol of the debt token |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params) external
```

Initializes the debt token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| debtTokenDecimals | uint8 | The decimals of the debtToken, same as the underlying asset's |
| debtTokenName | string | The name of the token |
| debtTokenSymbol | string | The symbol of the token |
| params | bytes | A set of encoded parameters for additional initialization |

