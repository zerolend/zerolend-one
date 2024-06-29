# Solidity API

## PoolFactory

### implementation

```solidity
address implementation
```

_Must return an address that can be used as a delegate call target.

{BeaconProxy} will check that this address is a contract._

### treasury

```solidity
address treasury
```

### rewardsController

```solidity
address rewardsController
```

### pools

```solidity
contract IPool[] pools
```

### isPool

```solidity
mapping(address => bool) isPool
```

### configurator

```solidity
contract IPoolConfigurator configurator
```

### reserveFactor

```solidity
uint256 reserveFactor
```

### flashLoanPremiumToProtocol

```solidity
uint256 flashLoanPremiumToProtocol
```

### liquidationProtocolFeePercentage

```solidity
uint256 liquidationProtocolFeePercentage
```

### constructor

```solidity
constructor(address _implementation) public
```

### poolsLength

```solidity
function poolsLength() external view returns (uint256)
```

### createPool

```solidity
function createPool(struct DataTypes.InitPoolParams params) external returns (contract IPool pool)
```

### setImplementation

```solidity
function setImplementation(address impl) external
```

### setConfigurator

```solidity
function setConfigurator(address impl) external
```

### setTreasury

```solidity
function setTreasury(address _treasury) external
```

### setReserveFactor

```solidity
function setReserveFactor(uint256 updated) external
```

### setRewardsController

```solidity
function setRewardsController(address _controller) external
```

### setFlashloanPremium

```solidity
function setFlashloanPremium(uint256 updated) external
```

