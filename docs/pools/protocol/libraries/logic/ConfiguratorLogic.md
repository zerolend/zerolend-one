# Solidity API

## ConfiguratorLogic

Implements the functions to initialize reserves and update aTokens and debtTokens

### ReserveInitialized

```solidity
event ReserveInitialized(address asset, address interestRateStrategyAddress)
```

### ATokenUpgraded

```solidity
event ATokenUpgraded(address asset, address proxy, address implementation)
```

### VariableDebtTokenUpgraded

```solidity
event VariableDebtTokenUpgraded(address asset, address proxy, address implementation)
```

### executeInitReserve

```solidity
function executeInitReserve(contract IPool pool, struct ConfiguratorInputTypes.InitReserveInput input) public
```

Initialize a reserve by creating and initializing aToken, stable debt token and variable debt token

_Emits the `ReserveInitialized` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The Pool in which the reserve will be initialized |
| input | struct ConfiguratorInputTypes.InitReserveInput | The needed parameters for the initialization |

