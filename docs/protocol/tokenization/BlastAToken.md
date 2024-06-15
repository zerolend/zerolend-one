# Solidity API

## BlastAToken

### constructor

```solidity
constructor(contract IPool pool) public
```

### initialize

```solidity
function initialize(contract IPool initializingPool, address treasury, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params) public virtual
```

Initializes the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| initializingPool | contract IPool |  |
| treasury | address | The address of the Aave treasury, receiving the fees on this aToken |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| aTokenDecimals | uint8 | The decimals of the aToken, same as the underlying asset's |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

### claimYield

```solidity
function claimYield(address to) public virtual returns (uint256)
```

