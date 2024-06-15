# Solidity API

## IInitializableAToken

Interface for the initialize function on AToken

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address treasury, address incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params)
```

_Emitted when an aToken is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| treasury | address | The address of the treasury |
| incentivesController | address | The address of the incentives controller for this aToken |
| aTokenDecimals | uint8 | The decimals of the underlying |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address treasury, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params) external
```

Initializes the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| treasury | address | The address of the Aave treasury, receiving the fees on this aToken |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| aTokenDecimals | uint8 | The decimals of the aToken, same as the underlying asset's |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

