# Solidity API

## IHook

### afterInitialize

```solidity
function afterInitialize(address sender, address pool) external returns (bytes4)
```

### beforeSupply

```solidity
function beforeSupply(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### afterSupply

```solidity
function afterSupply(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### beforeWithdraw

```solidity
function beforeWithdraw(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### afterWithdraw

```solidity
function afterWithdraw(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### beforeRepay

```solidity
function beforeRepay(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### afterRepay

```solidity
function afterRepay(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### beforeBorrow

```solidity
function beforeBorrow(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### afterBorrow

```solidity
function afterBorrow(address sender, bytes32 position, address asset, address pool, uint256 amount, bytes hookData) external
```

### beforeLiquidate

```solidity
function beforeLiquidate(address liquidator, bytes32 position, address collateralAsset, address debtAsset, uint256 debtToCover, address pool, bytes hookData) external
```

### afterLiquidate

```solidity
function afterLiquidate(address liquidator, bytes32 position, address collateralAsset, address debtAsset, uint256 debtToCover, address pool, bytes hookData) external
```

