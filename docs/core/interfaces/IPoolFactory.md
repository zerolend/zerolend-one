# Solidity API

## IPoolFactory

### PoolCreated

```solidity
event PoolCreated(contract IPool pool, uint256 index, address creator)
```

### ImplementationUpdated

```solidity
event ImplementationUpdated(address old, address updated, address owner)
```

### TreasuryUpdated

```solidity
event TreasuryUpdated(address old, address updated, address owner)
```

### ReserveFactorUpdated

```solidity
event ReserveFactorUpdated(uint256 old, uint256 updated, address owner)
```

### ConfiguratorUpdated

```solidity
event ConfiguratorUpdated(address old, address updated, address owner)
```

### RewardsControllerUpdated

```solidity
event RewardsControllerUpdated(address old, address updated, address owner)
```

### FlashLoanPremiumToProtocolUpdated

```solidity
event FlashLoanPremiumToProtocolUpdated(uint256 old, uint256 updated, address owner)
```

### configurator

```solidity
function configurator() external view returns (contract IPoolConfigurator)
```

### createPool

```solidity
function createPool(struct DataTypes.InitPoolParams params) external returns (contract IPool pool)
```

### setConfigurator

```solidity
function setConfigurator(address impl) external
```

### flashLoanPremiumToProtocol

```solidity
function flashLoanPremiumToProtocol() external view returns (uint256)
```

### liquidationProtocolFeePercentage

```solidity
function liquidationProtocolFeePercentage() external view returns (uint256)
```

### pools

```solidity
function pools(uint256 index) external view returns (contract IPool)
```

### isPool

```solidity
function isPool(address pool) external view returns (bool)
```

### poolsLength

```solidity
function poolsLength() external view returns (uint256)
```

### reserveFactor

```solidity
function reserveFactor() external view returns (uint256)
```

### rewardsController

```solidity
function rewardsController() external view returns (address)
```

### setFlashloanPremium

```solidity
function setFlashloanPremium(uint256 updated) external
```

### setImplementation

```solidity
function setImplementation(address updated) external
```

### setReserveFactor

```solidity
function setReserveFactor(uint256 updated) external
```

### setRewardsController

```solidity
function setRewardsController(address _controller) external
```

### setTreasury

```solidity
function setTreasury(address updated) external
```

### treasury

```solidity
function treasury() external view returns (address)
```

