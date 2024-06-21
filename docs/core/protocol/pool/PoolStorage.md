# Solidity API

## PoolStorage

### _reserves

```solidity
mapping(address => struct DataTypes.ReserveData) _reserves
```

Map of reserves and their data (underlyingAssetOfReserve => reserveData)

### _usersConfig

```solidity
mapping(bytes32 => struct DataTypes.UserConfigurationMap) _usersConfig
```

Map of positions and their configuration data (userAddress => userConfiguration)

### _balances

```solidity
mapping(address => mapping(bytes32 => struct DataTypes.PositionBalance)) _balances
```

Map of position's individual balances

### _totalSupplies

```solidity
mapping(address => struct DataTypes.ReserveSupplies) _totalSupplies
```

Map of total supply of tokens

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

List of reserves as a map (reserveId => reserve).
It is structured as a mapping for gas savings reasons, using the reserve id as index

### _reservesCount

```solidity
uint16 _reservesCount
```

Number of active reserves in the pool

### _assetsSources

```solidity
mapping(address => contract IAggregatorInterface) _assetsSources
```

Map of asset price sources (asset => priceSource)

### configurator

```solidity
address configurator
```

The pool configurator contract that can make changes

### _factory

```solidity
contract IFactory _factory
```

The original factory contract with protocol-level control variables

### hook

```solidity
contract IHook hook
```

The assigned hook for this pool

