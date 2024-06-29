# Solidity API

## PoolSetters

### _supply

```solidity
function _supply(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) internal
```

### _withdraw

```solidity
function _withdraw(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) internal returns (uint256 withdrawalAmount)
```

### _borrow

```solidity
function _borrow(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) internal
```

### _repay

```solidity
function _repay(address asset, uint256 amount, uint256 index, struct DataTypes.ExtraData data) internal returns (uint256 paybackAmount)
```

### _liquidate

```solidity
function _liquidate(address collat, address debt, bytes32 pos, uint256 debtAmt, struct DataTypes.ExtraData data) internal
```

### _flashLoan

```solidity
function _flashLoan(address receiverAddress, address asset, uint256 amount, bytes params, struct DataTypes.ExtraData data) public virtual
```

