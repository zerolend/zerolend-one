# Solidity API

## MockFlashLoanSimpleReceiver

### ExecutedWithFail

```solidity
event ExecutedWithFail(address asset, uint256 amount, uint256 premium)
```

### ExecutedWithSuccess

```solidity
event ExecutedWithSuccess(address asset, uint256 amount, uint256 premium)
```

### _failExecution

```solidity
bool _failExecution
```

### _amountToApprove

```solidity
uint256 _amountToApprove
```

### _simulateEOA

```solidity
bool _simulateEOA
```

### constructor

```solidity
constructor(contract IPool pool) public
```

### setFailExecutionTransfer

```solidity
function setFailExecutionTransfer(bool fail) public
```

### setAmountToApprove

```solidity
function setAmountToApprove(uint256 amountToApprove) public
```

### setSimulateEOA

```solidity
function setSimulateEOA(bool flag) public
```

### getAmountToApprove

```solidity
function getAmountToApprove() public view returns (uint256)
```

### simulateEOA

```solidity
function simulateEOA() public view returns (bool)
```

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address, bytes) public returns (bool)
```

