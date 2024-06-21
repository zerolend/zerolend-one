# Solidity API

## FlashLoanLogic

Implements the logic for the flash loans

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, uint256 premium)
```

### FlashLoanLocalVars

```solidity
struct FlashLoanLocalVars {
  contract IFlashLoanSimpleReceiver receiver;
  uint256 i;
  address currentAsset;
  uint256 currentAmount;
  uint256[] totalPremiums;
  uint256 flashloanPremiumTotal;
}
```

### executeFlashLoanSimple

```solidity
function executeFlashLoanSimple(address pool, struct DataTypes.ReserveData reserve, struct DataTypes.FlashloanSimpleParams params) external
```

Implements the simple flashloan feature that allow users to access liquidity of ONE reserve for one
transaction as long as the amount taken plus fee is returned.

_Does not waive fee for approved flashborrowers nor allow taking on debt instead of repaying to save gas
At the end of the transaction the pool will pull amount borrowed + fee from the receiver,
if the receiver have not approved the pool the transaction will revert.
Emits the `FlashLoan()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| reserve | struct DataTypes.ReserveData | The state of the flashloaned reserve |
| params | struct DataTypes.FlashloanSimpleParams | The additional parameters needed to execute the simple flashloan function |

### _handleFlashLoanRepayment

```solidity
function _handleFlashLoanRepayment(struct DataTypes.ReserveData reserve, struct DataTypes.FlashLoanRepaymentParams params) internal
```

Handles repayment of flashloaned assets + premium

_Will pull the amount + premium from the receiver, so must have approved pool_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the flashloaned reserve |
| params | struct DataTypes.FlashLoanRepaymentParams | The additional parameters needed to execute the repayment function |

