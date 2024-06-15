# Solidity API

## FlashLoanLogic

Implements the logic for the flash loans

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 premium, uint16 referralCode)
```

### FlashLoanLocalVars

```solidity
struct FlashLoanLocalVars {
  contract IFlashLoanReceiver receiver;
  uint256 i;
  address currentAsset;
  uint256 currentAmount;
  uint256[] totalPremiums;
  uint256 flashloanPremiumTotal;
  uint256 flashloanPremiumToProtocol;
}
```

### executeFlashLoan

```solidity
function executeFlashLoan(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.FlashloanParams params) external
```

Implements the flashloan feature that allow users to access liquidity of the pool for one transaction
as long as the amount taken plus fee is returned or debt is opened.

_For authorized flashborrowers the fee is waived
At the end of the transaction the pool will pull amount borrowed + fee from the receiver,
if the receiver have not approved the pool the transaction will revert.
Emits the `FlashLoan()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.FlashloanParams | The additional parameters needed to execute the flashloan function |

### executeFlashLoanSimple

```solidity
function executeFlashLoanSimple(struct DataTypes.ReserveData reserve, struct DataTypes.FlashloanSimpleParams params) external
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

