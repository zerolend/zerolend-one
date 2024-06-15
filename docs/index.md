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

## FlashloanAttacker

### _pool

```solidity
contract IPool _pool
```

### supplyAsset

```solidity
function supplyAsset(address asset, uint256 amount) public
```

### _innerBorrow

```solidity
function _innerBorrow(address asset) internal
```

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address, bytes) public returns (bool)
```

## MintableERC20

_ERC20 minting logic_

### EIP712_REVISION

```solidity
bytes EIP712_REVISION
```

### EIP712_DOMAIN

```solidity
bytes32 EIP712_DOMAIN
```

### PERMIT_TYPEHASH

```solidity
bytes32 PERMIT_TYPEHASH
```

### _nonces

```solidity
mapping(address => uint256) _nonces
```

### DOMAIN_SEPARATOR

```solidity
bytes32 DOMAIN_SEPARATOR
```

### constructor

```solidity
constructor(string name, string symbol) public
```

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

### mint

```solidity
function mint(uint256 value) public returns (bool)
```

_Function to mint tokens_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### mint

```solidity
function mint(address account, uint256 value) public returns (bool)
```

_Function to mint tokens to address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The account to mint tokens. |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### nonces

```solidity
function nonces(address owner) public view virtual returns (uint256)
```

## IACLManager

Defines the basic interface for the ACL Manager

### POOL_ADMIN_ROLE

```solidity
function POOL_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the PoolAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the PoolAdmin role |

### EMERGENCY_ADMIN_ROLE

```solidity
function EMERGENCY_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the EmergencyAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the EmergencyAdmin role |

### RISK_ADMIN_ROLE

```solidity
function RISK_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the RiskAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the RiskAdmin role |

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) external
```

Set the role as admin of a specific role.

_By default the admin role for all roles is `DEFAULT_ADMIN_ROLE`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| role | bytes32 | The role to be managed by the admin role |
| adminRole | bytes32 | The admin role |

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) external
```

Adds a new admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) external
```

Removes an admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) external view returns (bool)
```

Returns true if the address is PoolAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is PoolAdmin, false otherwise |

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) external
```

Adds a new admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) external
```

Removes an admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) external view returns (bool)
```

Returns true if the address is EmergencyAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is EmergencyAdmin, false otherwise |

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) external
```

Adds a new admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the new admin |

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) external
```

Removes an admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address of the admin to remove |

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) external view returns (bool)
```

Returns true if the address is RiskAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is RiskAdmin, false otherwise |

## IAaveIncentivesController

Defines the basic interface for an Aave Incentives Controller.

_It only contains one single function, needed as a hook on aToken and debtToken transfers._

### handleAction

```solidity
function handleAction(address user, uint256 totalSupply, uint256 userBalance) external
```

_Called by the corresponding asset on transfer hook in order to update the rewards distribution.
The units of `totalSupply` and `userBalance` should be the same._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user whose asset balance has changed |
| totalSupply | uint256 | The total supply of the asset prior to user balance change |
| userBalance | uint256 | The previous user balance prior to balance change |

## IERC20WithPermit

Interface for the permit function (EIP-2612)

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

## IInitializableAToken

Interface for the initialize function on AToken

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address treasury, address incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params)
```

_Emitted when an aToken is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| treasury | address | The address of the treasury |
| incentivesController | address | The address of the incentives controller for this aToken |
| aTokenDecimals | uint8 | The decimals of the underlying |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address treasury, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params) external
```

Initializes the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| treasury | address | The address of the Aave treasury, receiving the fees on this aToken |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| aTokenDecimals | uint8 | The decimals of the aToken, same as the underlying asset's |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

## IInitializableDebtToken

Interface for the initialize function common between debt tokens

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params)
```

_Emitted when a debt token is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| incentivesController | address | The address of the incentives controller for this aToken |
| debtTokenDecimals | uint8 | The decimals of the debt token |
| debtTokenName | string | The name of the debt token |
| debtTokenSymbol | string | The symbol of the debt token |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params) external
```

Initializes the debt token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| debtTokenDecimals | uint8 | The decimals of the debtToken, same as the underlying asset's |
| debtTokenName | string | The name of the token |
| debtTokenSymbol | string | The symbol of the token |
| params | bytes | A set of encoded parameters for additional initialization |

## IPool

Defines the basic interface for an Aave Pool.

### MintUnbacked

```solidity
event MintUnbacked(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

_Emitted on mintUnbacked()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address initiating the supply |
| onBehalfOf | address | The beneficiary of the supplied assets, receiving the aTokens |
| amount | uint256 | The amount of supplied assets |
| referralCode | uint16 | The referral code used |

### BackUnbacked

```solidity
event BackUnbacked(address reserve, address backer, uint256 amount, uint256 fee)
```

_Emitted on backUnbacked()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| backer | address | The address paying for the backing |
| amount | uint256 | The amount added as backing |
| fee | uint256 | The amount paid in fees |

### Supply

```solidity
event Supply(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

_Emitted on supply()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address initiating the supply |
| onBehalfOf | address | The beneficiary of the supply, receiving the aTokens |
| amount | uint256 | The amount supplied |
| referralCode | uint16 | The referral code used |

### Withdraw

```solidity
event Withdraw(address reserve, address user, address to, uint256 amount)
```

_Emitted on withdraw()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being withdrawn |
| user | address | The address initiating the withdrawal, owner of aTokens |
| to | address | The address that will receive the underlying |
| amount | uint256 | The amount to be withdrawn |

### Borrow

```solidity
event Borrow(address reserve, address user, address onBehalfOf, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 borrowRate, uint16 referralCode)
```

_Emitted on borrow() and flashLoan() when debt needs to be opened_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being borrowed |
| user | address | The address of the user initiating the borrow(), receiving the funds on borrow() or just initiator of the transaction on flashLoan() |
| onBehalfOf | address | The address that will be getting the debt |
| amount | uint256 | The amount borrowed out |
| interestRateMode | enum DataTypes.InterestRateMode | The rate mode: 1 for Stable, 2 for Variable |
| borrowRate | uint256 | The numeric rate at which the user has borrowed, expressed in ray |
| referralCode | uint16 | The referral code used |

### Repay

```solidity
event Repay(address reserve, address user, address repayer, uint256 amount, bool useATokens)
```

_Emitted on repay()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The beneficiary of the repayment, getting his debt reduced |
| repayer | address | The address of the user initiating the repay(), providing the funds |
| amount | uint256 | The amount repaid |
| useATokens | bool | True if the repayment is done using aTokens, `false` if done with underlying asset directly |

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, uint256 premium, uint16 referralCode)
```

_Emitted on flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The address of the flash loan receiver contract |
| initiator | address | The address initiating the flash loan |
| asset | address | The address of the asset being flash borrowed |
| amount | uint256 | The amount flash borrowed |
| premium | uint256 | The fee flash borrowed |
| referralCode | uint16 | The referral code used |

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator, bool receiveAToken)
```

_Emitted when a borrower is liquidated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| liquidatedCollateralAmount | uint256 | The amount of collateral received by the liquidator |
| liquidator | address | The address of the liquidator |
| receiveAToken | bool | True if the liquidators wants to receive the collateral aTokens, `false` if he wants to receive the underlying collateral asset directly |

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

_Emitted when the state of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| liquidityRate | uint256 | The next liquidity rate |
| variableBorrowRate | uint256 | The next variable borrow rate |
| liquidityIndex | uint256 | The next liquidity index |
| variableBorrowIndex | uint256 | The next variable borrow index |

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

_Emitted when the protocol treasury receives minted aTokens from the accrued interest._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the reserve |
| amountMinted | uint256 | The amount minted to the treasury |

### supply

```solidity
function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode, uint256 index) external
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| index | uint256 |  |

### withdraw

```solidity
function withdraw(address asset, uint256 amount, address to, uint256 index) external returns (uint256)
```

Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to withdraw |
| amount | uint256 | The underlying amount to be withdrawn   - Send the value type(uint256).max in order to withdraw the whole aToken balance |
| to | address | The address that will receive the underlying, same as msg.sender if the user   wants to receive it on his own wallet, or a different address if the beneficiary is a   different wallet |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount withdrawn |

### borrow

```solidity
function borrow(address asset, uint256 amount, uint16 referralCode, address onBehalfOf, uint256 index) external
```

Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
already supplied enough collateral, or he was given enough allowance by a credit delegator on the
corresponding debt token (StableDebtToken or VariableDebtToken)
- E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
  and 100 stable/variable debt tokens, depending on the `interestRateMode`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to borrow |
| amount | uint256 | The amount to be borrowed |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| onBehalfOf | address | The address of the user who will receive the debt. Should be the address of the borrower itself calling the function if he wants to borrow against his own collateral, or the address of the credit delegator if he has been given credit delegation allowance |
| index | uint256 |  |

### repay

```solidity
function repay(address asset, uint256 amount, address onBehalfOf, uint256 index) external returns (uint256)
```

Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
- E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### setUserUseReserveAsCollateral

```solidity
function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) external
```

Allows suppliers to enable/disable a specific supplied asset as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset supplied |
| useAsCollateral | bool | True if the user wants to use the supply as collateral, false otherwise |

### liquidate

```solidity
function liquidate(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 index) external
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| index | uint256 |  |

### flashLoan

```solidity
function flashLoan(address receiverAddress, address asset, uint256 amount, bytes params, uint16 referralCode) external
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface |
| asset | address | The address of the asset being flash-borrowed |
| amount | uint256 | The amount of the asset being flash-borrowed |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### getUserAccountData

```solidity
function getUserAccountData(address user, uint256 index) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

### initReserve

```solidity
function initReserve(address asset, address interestRateStrategyAddress) external
```

Initializes a reserve, activating it, assigning an aToken and debt tokens and an
interest rate strategy

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### setConfiguration

```solidity
function setConfiguration(address asset, struct DataTypes.ReserveConfigurationMap configuration) external
```

Sets the configuration bitmap of the reserve as a whole

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| configuration | struct DataTypes.ReserveConfigurationMap | The new configuration bitmap |

### getConfiguration

```solidity
function getConfiguration(address asset) external view returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user, uint256 index) external view returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address asset) external view returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address asset) external view returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReserveData

```solidity
function getReserveData(address asset) external view returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### getReservesList

```solidity
function getReservesList() external view returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

_It does not include dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view returns (uint256)
```

Returns the number of initialized reserves

_It includes dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

### mintToTreasury

```solidity
function mintToTreasury(address[] assets) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

## IPoolConfigurator

Defines the basic interface for a Pool configurator.

### ReserveInitialized

```solidity
event ReserveInitialized(address asset, address aToken, address variableDebtToken, address interestRateStrategyAddress)
```

_Emitted when a reserve is initialized._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| aToken | address | The address of the associated aToken contract |
| variableDebtToken | address | The address of the associated variable rate debt token |
| interestRateStrategyAddress | address | The address of the interest rate strategy for the reserve |

### ReserveBorrowing

```solidity
event ReserveBorrowing(address asset, bool enabled)
```

_Emitted when borrowing is enabled or disabled on a reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if borrowing is enabled, false otherwise |

### ReserveFlashLoaning

```solidity
event ReserveFlashLoaning(address asset, bool enabled)
```

_Emitted when flashloans are enabled or disabled on a reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if flashloans are enabled, false otherwise |

### CollateralConfigurationChanged

```solidity
event CollateralConfigurationChanged(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus)
```

_Emitted when the collateralization risk parameters for the specified asset are updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| ltv | uint256 | The loan to value of the asset when used as collateral |
| liquidationThreshold | uint256 | The threshold at which loans using this asset as collateral will be considered undercollateralized |
| liquidationBonus | uint256 | The bonus liquidators receive to liquidate this asset |

### ReserveActive

```solidity
event ReserveActive(address asset, bool active)
```

_Emitted when a reserve is activated or deactivated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| active | bool | True if reserve is active, false otherwise |

### ReserveFrozen

```solidity
event ReserveFrozen(address asset, bool frozen)
```

_Emitted when a reserve is frozen or unfrozen_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| frozen | bool | True if reserve is frozen, false otherwise |

### ReservePaused

```solidity
event ReservePaused(address asset, bool paused)
```

_Emitted when a reserve is paused or unpaused_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| paused | bool | True if reserve is paused, false otherwise |

### ReserveDropped

```solidity
event ReserveDropped(address asset)
```

_Emitted when a reserve is dropped._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

### ReserveFactorChanged

```solidity
event ReserveFactorChanged(address asset, uint256 oldReserveFactor, uint256 newReserveFactor)
```

_Emitted when a reserve factor is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldReserveFactor | uint256 | The old reserve factor, expressed in bps |
| newReserveFactor | uint256 | The new reserve factor, expressed in bps |

### BorrowCapChanged

```solidity
event BorrowCapChanged(address asset, uint256 oldBorrowCap, uint256 newBorrowCap)
```

_Emitted when the borrow cap of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldBorrowCap | uint256 | The old borrow cap |
| newBorrowCap | uint256 | The new borrow cap |

### SupplyCapChanged

```solidity
event SupplyCapChanged(address asset, uint256 oldSupplyCap, uint256 newSupplyCap)
```

_Emitted when the supply cap of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldSupplyCap | uint256 | The old supply cap |
| newSupplyCap | uint256 | The new supply cap |

### LiquidationProtocolFeeChanged

```solidity
event LiquidationProtocolFeeChanged(address asset, uint256 oldFee, uint256 newFee)
```

_Emitted when the liquidation protocol fee of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldFee | uint256 | The old liquidation protocol fee, expressed in bps |
| newFee | uint256 | The new liquidation protocol fee, expressed in bps |

### ReserveInterestRateStrategyChanged

```solidity
event ReserveInterestRateStrategyChanged(address asset, address oldStrategy, address newStrategy)
```

_Emitted when a reserve interest strategy contract is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldStrategy | address | The address of the old interest strategy contract |
| newStrategy | address | The address of the new interest strategy contract |

### ATokenUpgraded

```solidity
event ATokenUpgraded(address asset, address proxy, address implementation)
```

_Emitted when an aToken implementation is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| proxy | address | The aToken proxy address |
| implementation | address | The new aToken implementation |

### VariableDebtTokenUpgraded

```solidity
event VariableDebtTokenUpgraded(address asset, address proxy, address implementation)
```

_Emitted when the implementation of a variable debt token is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| proxy | address | The variable debt token proxy address |
| implementation | address | The new aToken implementation |

### DebtCeilingChanged

```solidity
event DebtCeilingChanged(address asset, uint256 oldDebtCeiling, uint256 newDebtCeiling)
```

_Emitted when the debt ceiling of an asset is set._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| oldDebtCeiling | uint256 | The old debt ceiling |
| newDebtCeiling | uint256 | The new debt ceiling |

### BridgeProtocolFeeUpdated

```solidity
event BridgeProtocolFeeUpdated(uint256 oldBridgeProtocolFee, uint256 newBridgeProtocolFee)
```

_Emitted when the bridge protocol fee is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldBridgeProtocolFee | uint256 | The old protocol fee, expressed in bps |
| newBridgeProtocolFee | uint256 | The new protocol fee, expressed in bps |

### FlashloanPremiumTotalUpdated

```solidity
event FlashloanPremiumTotalUpdated(uint128 oldFlashloanPremiumTotal, uint128 newFlashloanPremiumTotal)
```

_Emitted when the total premium on flashloans is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldFlashloanPremiumTotal | uint128 | The old premium, expressed in bps |
| newFlashloanPremiumTotal | uint128 | The new premium, expressed in bps |

### FlashloanPremiumToProtocolUpdated

```solidity
event FlashloanPremiumToProtocolUpdated(uint128 oldFlashloanPremiumToProtocol, uint128 newFlashloanPremiumToProtocol)
```

_Emitted when the part of the premium that goes to protocol is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldFlashloanPremiumToProtocol | uint128 | The old premium, expressed in bps |
| newFlashloanPremiumToProtocol | uint128 | The new premium, expressed in bps |

### initReserves

```solidity
function initReserves(struct ConfiguratorInputTypes.InitReserveInput[] input) external
```

Initializes multiple reserves.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| input | struct ConfiguratorInputTypes.InitReserveInput[] | The array of initialization parameters |

### updateAToken

```solidity
function updateAToken(struct ConfiguratorInputTypes.UpdateATokenInput input) external
```

_Updates the aToken implementation for the reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| input | struct ConfiguratorInputTypes.UpdateATokenInput | The aToken update parameters |

### updateVariableDebtToken

```solidity
function updateVariableDebtToken(struct ConfiguratorInputTypes.UpdateDebtTokenInput input) external
```

Updates the variable debt token implementation for the asset.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| input | struct ConfiguratorInputTypes.UpdateDebtTokenInput | The variableDebtToken update parameters |

### setReserveBorrowing

```solidity
function setReserveBorrowing(address asset, bool enabled) external
```

Configures borrowing on a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if borrowing needs to be enabled, false otherwise |

### configureReserveAsCollateral

```solidity
function configureReserveAsCollateral(address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus) external
```

Configures the reserve collateralization parameters.

_All the values are expressed in bps. A value of 10000, results in 100.00%
The `liquidationBonus` is always above 100%. A value of 105% means the liquidator will receive a 5% bonus_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| ltv | uint256 | The loan to value of the asset when used as collateral |
| liquidationThreshold | uint256 | The threshold at which loans using this asset as collateral will be considered undercollateralized |
| liquidationBonus | uint256 | The bonus liquidators receive to liquidate this asset |

### setReserveFlashLoaning

```solidity
function setReserveFlashLoaning(address asset, bool enabled) external
```

Enable or disable flashloans on a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| enabled | bool | True if flashloans need to be enabled, false otherwise |

### setReserveActive

```solidity
function setReserveActive(address asset, bool active) external
```

Activate or deactivate a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| active | bool | True if the reserve needs to be active, false otherwise |

### setReserveFreeze

```solidity
function setReserveFreeze(address asset, bool freeze) external
```

Freeze or unfreeze a reserve. A frozen reserve doesn't allow any new supply, borrow
or rate swap but allows repayments, liquidations, rate rebalances and withdrawals.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| freeze | bool | True if the reserve needs to be frozen, false otherwise |

### setReservePause

```solidity
function setReservePause(address asset, bool paused) external
```

Pauses a reserve. A paused reserve does not allow any interaction (supply, borrow, repay,
swap interest rate, liquidate, atoken transfers).

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| paused | bool | True if pausing the reserve, false if unpausing |

### setReserveFactor

```solidity
function setReserveFactor(address asset, uint256 newReserveFactor) external
```

Updates the reserve factor of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| newReserveFactor | uint256 | The new reserve factor of the reserve |

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address asset, address newRateStrategyAddress) external
```

Sets the interest rate strategy of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| newRateStrategyAddress | address | The address of the new interest strategy contract |

### setPoolPause

```solidity
function setPoolPause(bool paused) external
```

Pauses or unpauses all the protocol reserves. In the paused state all the protocol interactions
are suspended.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| paused | bool | True if protocol needs to be paused, false otherwise |

### setBorrowCap

```solidity
function setBorrowCap(address asset, uint256 newBorrowCap) external
```

Updates the borrow cap of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| newBorrowCap | uint256 | The new borrow cap of the reserve |

### setSupplyCap

```solidity
function setSupplyCap(address asset, uint256 newSupplyCap) external
```

Updates the supply cap of a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| newSupplyCap | uint256 | The new supply cap of the reserve |

### setLiquidationProtocolFee

```solidity
function setLiquidationProtocolFee(address asset, uint256 newFee) external
```

Updates the liquidation protocol fee of reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| newFee | uint256 | The new liquidation protocol fee of the reserve, expressed in bps |

## IPoolDataProvider

Defines the basic interface of a PoolDataProvider

### TokenData

```solidity
struct TokenData {
  string symbol;
  address tokenAddress;
}
```

### getAllReservesTokens

```solidity
function getAllReservesTokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing reserves in the pool.

_Handling MKR and ETH in a different way since they do not have standard `symbol` functions._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of reserves, pairs of symbols and addresses |

### getAllATokens

```solidity
function getAllATokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing ATokens in the pool.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of ATokens, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address pool, address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool isActive, bool isFrozen)
```

Returns the configuration data of the reserve

_Not returning borrow and supply caps for compatibility, nor pause flag_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| decimals | uint256 | The number of decimals of the reserve |
| ltv | uint256 | The ltv of the reserve |
| liquidationThreshold | uint256 | The liquidationThreshold of the reserve |
| liquidationBonus | uint256 | The liquidationBonus of the reserve |
| reserveFactor | uint256 | The reserveFactor of the reserve |
| usageAsCollateralEnabled | bool | True if the usage as collateral is enabled, false otherwise |
| borrowingEnabled | bool | True if borrowing is enabled, false otherwise |
| isActive | bool | True if it is active, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveEModeCategory

```solidity
function getReserveEModeCategory(address pool, address asset) external view returns (uint256)
```

Returns the efficiency mode category of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode id of the reserve |

### getReserveCaps

```solidity
function getReserveCaps(address pool, address asset) external view returns (uint256 borrowCap, uint256 supplyCap)
```

Returns the caps parameters of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrowCap | uint256 | The borrow cap of the reserve |
| supplyCap | uint256 | The supply cap of the reserve |

### getPaused

```solidity
function getPaused(address pool, address asset) external view returns (bool isPaused)
```

Returns if the pool is paused

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| isPaused | bool | True if the pool is paused, false otherwise |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(address pool, address asset) external view returns (uint256)
```

Returns the protocol fee on the liquidation bonus

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The protocol fee on liquidation |

### getUnbackedMintCap

```solidity
function getUnbackedMintCap(address pool, address asset) external view returns (uint256)
```

Returns the unbacked mint cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The unbacked mint cap of the reserve |

### getDebtCeiling

```solidity
function getDebtCeiling(address pool, address asset) external view returns (uint256)
```

Returns the debt ceiling of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling of the reserve |

### getDebtCeilingDecimals

```solidity
function getDebtCeilingDecimals(address pool) external pure returns (uint256)
```

Returns the debt ceiling decimals

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling decimals |

### getReserveData

```solidity
function getReserveData(address pool, address asset) external view returns (uint256 unbacked, uint256 accruedToTreasuryScaled, uint256 totalAToken, uint256 totalVariableDebt, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex, uint40 lastUpdateTimestamp)
```

Returns the reserve data

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| unbacked | uint256 | The amount of unbacked tokens |
| accruedToTreasuryScaled | uint256 | The scaled amount of tokens accrued to treasury that is to be minted |
| totalAToken | uint256 | The total supply of the aToken |
| totalVariableDebt | uint256 | The total variable debt of the reserve |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| variableBorrowRate | uint256 | The variable borrow rate of the reserve |
| liquidityIndex | uint256 | The liquidity index of the reserve |
| variableBorrowIndex | uint256 | The variable borrow index of the reserve |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the reserve |

### getATokenTotalSupply

```solidity
function getATokenTotalSupply(address pool, address asset) external view returns (uint256)
```

Returns the total supply of aTokens for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply of the aToken |

### getTotalDebt

```solidity
function getTotalDebt(address pool, address asset) external view returns (uint256)
```

Returns the total debt for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total debt for asset |

### getUserReserveData

```solidity
function getUserReserveData(address pool, address asset, address user) external view returns (uint256 currentATokenBalance, uint256 currentVariableDebt, uint256 scaledVariableDebt, uint256 liquidityRate, bool usageAsCollateralEnabled)
```

Returns the user data in a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| currentATokenBalance | uint256 | The current AToken balance of the user |
| currentVariableDebt | uint256 | The current variable debt of the user |
| scaledVariableDebt | uint256 | The scaled variable debt of the user |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| usageAsCollateralEnabled | bool | True if the user is using the asset as collateral, false         otherwise |

### getReserveTokensAddresses

```solidity
function getReserveTokensAddresses(address pool, address asset) external view returns (address aTokenAddress, address variableDebtTokenAddress)
```

Returns the token addresses of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| aTokenAddress | address | The AToken address of the reserve |
| variableDebtTokenAddress | address | The VariableDebtToken address of the reserve |

### getInterestRateStrategyAddress

```solidity
function getInterestRateStrategyAddress(address pool, address asset) external view returns (address irStrategyAddress)
```

Returns the address of the Interest Rate strategy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| irStrategyAddress | address | The address of the Interest Rate strategy |

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(address pool, address asset) external view returns (bool)
```

Returns whether the reserve has FlashLoans enabled or disabled

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if FlashLoans are enabled, false otherwise |

## ITimelock

_Contract module which acts as a timelocked controller. When set as the
owner of an `Ownable` smart contract, it enforces a timelock on all
`onlyOwner` maintenance operations. This gives time for users of the
controlled contract to exit before a potentially dangerous maintenance
operation is applied.

By default, this contract is self administered, meaning administration tasks
have to go through the timelock process. The proposer (resp executor) role
is in charge of proposing (resp executing) operations. A common use case is
to position this {TimelockController} as the owner of a smart contract, with
a multisig or a DAO as the sole proposer._

### OperationState

```solidity
enum OperationState {
  Unset,
  Waiting,
  Ready,
  Done
}
```

### TimelockInvalidOperationLength

```solidity
error TimelockInvalidOperationLength(uint256 targets, uint256 payloads, uint256 values)
```

_Mismatch between the parameters length for an operation call._

### TimelockInsufficientDelay

```solidity
error TimelockInsufficientDelay(uint256 delay, uint256 minDelay)
```

_The schedule operation doesn't meet the minimum delay._

### TimelockUnexpectedOperationState

```solidity
error TimelockUnexpectedOperationState(bytes32 operationId, bytes32 expectedStates)
```

_The current state of an operation is not as required.
The `expectedStates` is a bitmap with the bits enabled for each OperationState enum position
counting from right to left.

See {_encodeStateBitmap}._

### TimelockUnexecutedPredecessor

```solidity
error TimelockUnexecutedPredecessor(bytes32 predecessorId)
```

_The predecessor to an operation not yet done._

### TimelockUnauthorizedCaller

```solidity
error TimelockUnauthorizedCaller(address caller)
```

_The caller account is not authorized._

### CallScheduled

```solidity
event CallScheduled(bytes32 id, uint256 index, address target, uint256 value, bytes data, bytes32 predecessor, uint256 delay)
```

_Emitted when a call is scheduled as part of operation `id`._

### CallExecuted

```solidity
event CallExecuted(bytes32 id, uint256 index, address target, uint256 value, bytes data)
```

_Emitted when a call is performed as part of operation `id`._

### CallSalt

```solidity
event CallSalt(bytes32 id, bytes32 salt)
```

_Emitted when new proposal is scheduled with non-zero salt._

### Cancelled

```solidity
event Cancelled(bytes32 id)
```

_Emitted when operation `id` is cancelled._

### MinDelayChange

```solidity
event MinDelayChange(uint256 oldDuration, uint256 newDuration)
```

_Emitted when the minimum delay for future operations is modified._

## ReserveConfiguration

Implements the bitmap logic to handle the reserve configuration

### LTV_MASK

```solidity
uint256 LTV_MASK
```

### LIQUIDATION_THRESHOLD_MASK

```solidity
uint256 LIQUIDATION_THRESHOLD_MASK
```

### LIQUIDATION_BONUS_MASK

```solidity
uint256 LIQUIDATION_BONUS_MASK
```

### DECIMALS_MASK

```solidity
uint256 DECIMALS_MASK
```

### ACTIVE_MASK

```solidity
uint256 ACTIVE_MASK
```

### FROZEN_MASK

```solidity
uint256 FROZEN_MASK
```

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### STABLE_BORROWING_MASK

```solidity
uint256 STABLE_BORROWING_MASK
```

### PAUSED_MASK

```solidity
uint256 PAUSED_MASK
```

### BORROWABLE_IN_ISOLATION_MASK

```solidity
uint256 BORROWABLE_IN_ISOLATION_MASK
```

### SILOED_BORROWING_MASK

```solidity
uint256 SILOED_BORROWING_MASK
```

### FLASHLOAN_ENABLED_MASK

```solidity
uint256 FLASHLOAN_ENABLED_MASK
```

### RESERVE_FACTOR_MASK

```solidity
uint256 RESERVE_FACTOR_MASK
```

### BORROW_CAP_MASK

```solidity
uint256 BORROW_CAP_MASK
```

### SUPPLY_CAP_MASK

```solidity
uint256 SUPPLY_CAP_MASK
```

### LIQUIDATION_PROTOCOL_FEE_MASK

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_MASK
```

### EMODE_CATEGORY_MASK

```solidity
uint256 EMODE_CATEGORY_MASK
```

### UNBACKED_MINT_CAP_MASK

```solidity
uint256 UNBACKED_MINT_CAP_MASK
```

### DEBT_CEILING_MASK

```solidity
uint256 DEBT_CEILING_MASK
```

### LIQUIDATION_THRESHOLD_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_THRESHOLD_START_BIT_POSITION
```

_For the LTV, the start bit is 0 (up to 15), hence no bitshifting is needed_

### LIQUIDATION_BONUS_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_BONUS_START_BIT_POSITION
```

### RESERVE_DECIMALS_START_BIT_POSITION

```solidity
uint256 RESERVE_DECIMALS_START_BIT_POSITION
```

### IS_ACTIVE_START_BIT_POSITION

```solidity
uint256 IS_ACTIVE_START_BIT_POSITION
```

### IS_FROZEN_START_BIT_POSITION

```solidity
uint256 IS_FROZEN_START_BIT_POSITION
```

### BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 BORROWING_ENABLED_START_BIT_POSITION
```

### STABLE_BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 STABLE_BORROWING_ENABLED_START_BIT_POSITION
```

### IS_PAUSED_START_BIT_POSITION

```solidity
uint256 IS_PAUSED_START_BIT_POSITION
```

### BORROWABLE_IN_ISOLATION_START_BIT_POSITION

```solidity
uint256 BORROWABLE_IN_ISOLATION_START_BIT_POSITION
```

### SILOED_BORROWING_START_BIT_POSITION

```solidity
uint256 SILOED_BORROWING_START_BIT_POSITION
```

### FLASHLOAN_ENABLED_START_BIT_POSITION

```solidity
uint256 FLASHLOAN_ENABLED_START_BIT_POSITION
```

### RESERVE_FACTOR_START_BIT_POSITION

```solidity
uint256 RESERVE_FACTOR_START_BIT_POSITION
```

### BORROW_CAP_START_BIT_POSITION

```solidity
uint256 BORROW_CAP_START_BIT_POSITION
```

### SUPPLY_CAP_START_BIT_POSITION

```solidity
uint256 SUPPLY_CAP_START_BIT_POSITION
```

### LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION
```

### EMODE_CATEGORY_START_BIT_POSITION

```solidity
uint256 EMODE_CATEGORY_START_BIT_POSITION
```

### UNBACKED_MINT_CAP_START_BIT_POSITION

```solidity
uint256 UNBACKED_MINT_CAP_START_BIT_POSITION
```

### DEBT_CEILING_START_BIT_POSITION

```solidity
uint256 DEBT_CEILING_START_BIT_POSITION
```

### MAX_VALID_LTV

```solidity
uint256 MAX_VALID_LTV
```

### MAX_VALID_LIQUIDATION_THRESHOLD

```solidity
uint256 MAX_VALID_LIQUIDATION_THRESHOLD
```

### MAX_VALID_LIQUIDATION_BONUS

```solidity
uint256 MAX_VALID_LIQUIDATION_BONUS
```

### MAX_VALID_DECIMALS

```solidity
uint256 MAX_VALID_DECIMALS
```

### MAX_VALID_RESERVE_FACTOR

```solidity
uint256 MAX_VALID_RESERVE_FACTOR
```

### MAX_VALID_BORROW_CAP

```solidity
uint256 MAX_VALID_BORROW_CAP
```

### MAX_VALID_SUPPLY_CAP

```solidity
uint256 MAX_VALID_SUPPLY_CAP
```

### MAX_VALID_LIQUIDATION_PROTOCOL_FEE

```solidity
uint256 MAX_VALID_LIQUIDATION_PROTOCOL_FEE
```

### MAX_VALID_EMODE_CATEGORY

```solidity
uint256 MAX_VALID_EMODE_CATEGORY
```

### MAX_VALID_UNBACKED_MINT_CAP

```solidity
uint256 MAX_VALID_UNBACKED_MINT_CAP
```

### MAX_VALID_DEBT_CEILING

```solidity
uint256 MAX_VALID_DEBT_CEILING
```

### DEBT_CEILING_DECIMALS

```solidity
uint256 DEBT_CEILING_DECIMALS
```

### MAX_RESERVES_COUNT

```solidity
uint16 MAX_RESERVES_COUNT
```

### setLtv

```solidity
function setLtv(struct DataTypes.ReserveConfigurationMap self, uint256 ltv) internal pure
```

Sets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| ltv | uint256 | The new ltv |

### getLtv

```solidity
function getLtv(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The loan to value |

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self, uint256 threshold) internal pure
```

Sets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| threshold | uint256 | The new liquidation threshold |

### getLiquidationThreshold

```solidity
function getLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation threshold |

### setLiquidationBonus

```solidity
function setLiquidationBonus(struct DataTypes.ReserveConfigurationMap self, uint256 bonus) internal pure
```

Sets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| bonus | uint256 | The new liquidation bonus |

### getLiquidationBonus

```solidity
function getLiquidationBonus(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation bonus |

### setDecimals

```solidity
function setDecimals(struct DataTypes.ReserveConfigurationMap self, uint256 decimals) internal pure
```

Sets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| decimals | uint256 | The decimals |

### getDecimals

```solidity
function getDecimals(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The decimals of the asset |

### setFrozen

```solidity
function setFrozen(struct DataTypes.ReserveConfigurationMap self, bool frozen) internal pure
```

Sets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| frozen | bool | The frozen state |

### getFrozen

```solidity
function getFrozen(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The frozen state |

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self, bool enabled) internal pure
```

Enables or disables borrowing on the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| enabled | bool | True if the borrowing needs to be enabled, false otherwise |

### getBorrowingEnabled

```solidity
function getBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the borrowing state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The borrowing state |

### setReserveFactor

```solidity
function setReserveFactor(struct DataTypes.ReserveConfigurationMap self, uint256 reserveFactor) internal pure
```

Sets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| reserveFactor | uint256 | The reserve factor |

### getReserveFactor

```solidity
function getReserveFactor(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve factor |

### setBorrowCap

```solidity
function setBorrowCap(struct DataTypes.ReserveConfigurationMap self, uint256 borrowCap) internal pure
```

Sets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| borrowCap | uint256 | The borrow cap |

### getBorrowCap

```solidity
function getBorrowCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The borrow cap |

### setSupplyCap

```solidity
function setSupplyCap(struct DataTypes.ReserveConfigurationMap self, uint256 supplyCap) internal pure
```

Sets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| supplyCap | uint256 | The supply cap |

### getSupplyCap

```solidity
function getSupplyCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The supply cap |

### getFlags

```solidity
function getFlags(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool, bool, bool, bool, bool)
```

Gets the configuration flags of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The state flag representing active |
| [1] | bool | The state flag representing frozen |
| [2] | bool | The state flag representing borrowing enabled |
| [3] | bool | The state flag representing stableRateBorrowing enabled |
| [4] | bool | The state flag representing paused |

### getParams

```solidity
function getParams(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256, uint256, uint256, uint256)
```

Gets the configuration parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing ltv |
| [1] | uint256 | The state param representing liquidation threshold |
| [2] | uint256 | The state param representing liquidation bonus |
| [3] | uint256 | The state param representing reserve decimals |
| [4] | uint256 | The state param representing reserve factor |

### getCaps

```solidity
function getCaps(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256)
```

Gets the caps parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing borrow cap |
| [1] | uint256 | The state param representing supply cap. |

## Errors

Defines the error messages emitted by the different contracts of the Aave protocol

### CALLER_NOT_POOL_ADMIN

```solidity
string CALLER_NOT_POOL_ADMIN
```

### CALLER_NOT_EMERGENCY_ADMIN

```solidity
string CALLER_NOT_EMERGENCY_ADMIN
```

### CALLER_NOT_POOL_OR_EMERGENCY_ADMIN

```solidity
string CALLER_NOT_POOL_OR_EMERGENCY_ADMIN
```

### CALLER_NOT_RISK_OR_POOL_ADMIN

```solidity
string CALLER_NOT_RISK_OR_POOL_ADMIN
```

### CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN

```solidity
string CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN
```

### CALLER_NOT_BRIDGE

```solidity
string CALLER_NOT_BRIDGE
```

### ADDRESSES_PROVIDER_NOT_REGISTERED

```solidity
string ADDRESSES_PROVIDER_NOT_REGISTERED
```

### INVALID_ADDRESSES_PROVIDER_ID

```solidity
string INVALID_ADDRESSES_PROVIDER_ID
```

### NOT_CONTRACT

```solidity
string NOT_CONTRACT
```

### CALLER_NOT_POOL_CONFIGURATOR

```solidity
string CALLER_NOT_POOL_CONFIGURATOR
```

### CALLER_NOT_ATOKEN

```solidity
string CALLER_NOT_ATOKEN
```

### INVALID_ADDRESSES_PROVIDER

```solidity
string INVALID_ADDRESSES_PROVIDER
```

### INVALID_FLASHLOAN_EXECUTOR_RETURN

```solidity
string INVALID_FLASHLOAN_EXECUTOR_RETURN
```

### RESERVE_ALREADY_ADDED

```solidity
string RESERVE_ALREADY_ADDED
```

### NO_MORE_RESERVES_ALLOWED

```solidity
string NO_MORE_RESERVES_ALLOWED
```

### RESERVE_LIQUIDITY_NOT_ZERO

```solidity
string RESERVE_LIQUIDITY_NOT_ZERO
```

### FLASHLOAN_PREMIUM_INVALID

```solidity
string FLASHLOAN_PREMIUM_INVALID
```

### INVALID_RESERVE_PARAMS

```solidity
string INVALID_RESERVE_PARAMS
```

### BRIDGE_PROTOCOL_FEE_INVALID

```solidity
string BRIDGE_PROTOCOL_FEE_INVALID
```

### CALLER_MUST_BE_POOL

```solidity
string CALLER_MUST_BE_POOL
```

### INVALID_MINT_AMOUNT

```solidity
string INVALID_MINT_AMOUNT
```

### INVALID_BURN_AMOUNT

```solidity
string INVALID_BURN_AMOUNT
```

### INVALID_AMOUNT

```solidity
string INVALID_AMOUNT
```

### RESERVE_INACTIVE

```solidity
string RESERVE_INACTIVE
```

### RESERVE_FROZEN

```solidity
string RESERVE_FROZEN
```

### RESERVE_PAUSED

```solidity
string RESERVE_PAUSED
```

### BORROWING_NOT_ENABLED

```solidity
string BORROWING_NOT_ENABLED
```

### STABLE_BORROWING_NOT_ENABLED

```solidity
string STABLE_BORROWING_NOT_ENABLED
```

### NOT_ENOUGH_AVAILABLE_USER_BALANCE

```solidity
string NOT_ENOUGH_AVAILABLE_USER_BALANCE
```

### INVALID_INTEREST_RATE_MODE_SELECTED

```solidity
string INVALID_INTEREST_RATE_MODE_SELECTED
```

### COLLATERAL_BALANCE_IS_ZERO

```solidity
string COLLATERAL_BALANCE_IS_ZERO
```

### HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD

```solidity
string HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD
```

### COLLATERAL_CANNOT_COVER_NEW_BORROW

```solidity
string COLLATERAL_CANNOT_COVER_NEW_BORROW
```

### COLLATERAL_SAME_AS_BORROWING_CURRENCY

```solidity
string COLLATERAL_SAME_AS_BORROWING_CURRENCY
```

### AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE

```solidity
string AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE
```

### NO_DEBT_OF_SELECTED_TYPE

```solidity
string NO_DEBT_OF_SELECTED_TYPE
```

### NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF

```solidity
string NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF
```

### NO_OUTSTANDING_STABLE_DEBT

```solidity
string NO_OUTSTANDING_STABLE_DEBT
```

### NO_OUTSTANDING_VARIABLE_DEBT

```solidity
string NO_OUTSTANDING_VARIABLE_DEBT
```

### UNDERLYING_BALANCE_ZERO

```solidity
string UNDERLYING_BALANCE_ZERO
```

### INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET

```solidity
string INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET
```

### HEALTH_FACTOR_NOT_BELOW_THRESHOLD

```solidity
string HEALTH_FACTOR_NOT_BELOW_THRESHOLD
```

### COLLATERAL_CANNOT_BE_LIQUIDATED

```solidity
string COLLATERAL_CANNOT_BE_LIQUIDATED
```

### SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER

```solidity
string SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER
```

### INCONSISTENT_FLASHLOAN_PARAMS

```solidity
string INCONSISTENT_FLASHLOAN_PARAMS
```

### BORROW_CAP_EXCEEDED

```solidity
string BORROW_CAP_EXCEEDED
```

### SUPPLY_CAP_EXCEEDED

```solidity
string SUPPLY_CAP_EXCEEDED
```

### UNBACKED_MINT_CAP_EXCEEDED

```solidity
string UNBACKED_MINT_CAP_EXCEEDED
```

### DEBT_CEILING_EXCEEDED

```solidity
string DEBT_CEILING_EXCEEDED
```

### UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO

```solidity
string UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO
```

### STABLE_DEBT_NOT_ZERO

```solidity
string STABLE_DEBT_NOT_ZERO
```

### VARIABLE_DEBT_SUPPLY_NOT_ZERO

```solidity
string VARIABLE_DEBT_SUPPLY_NOT_ZERO
```

### LTV_VALIDATION_FAILED

```solidity
string LTV_VALIDATION_FAILED
```

### INCONSISTENT_EMODE_CATEGORY

```solidity
string INCONSISTENT_EMODE_CATEGORY
```

### PRICE_ORACLE_SENTINEL_CHECK_FAILED

```solidity
string PRICE_ORACLE_SENTINEL_CHECK_FAILED
```

### RESERVE_ALREADY_INITIALIZED

```solidity
string RESERVE_ALREADY_INITIALIZED
```

### LTV_ZERO

```solidity
string LTV_ZERO
```

### INVALID_LTV

```solidity
string INVALID_LTV
```

### INVALID_LIQ_THRESHOLD

```solidity
string INVALID_LIQ_THRESHOLD
```

### INVALID_LIQ_BONUS

```solidity
string INVALID_LIQ_BONUS
```

### INVALID_DECIMALS

```solidity
string INVALID_DECIMALS
```

### INVALID_RESERVE_FACTOR

```solidity
string INVALID_RESERVE_FACTOR
```

### INVALID_BORROW_CAP

```solidity
string INVALID_BORROW_CAP
```

### INVALID_SUPPLY_CAP

```solidity
string INVALID_SUPPLY_CAP
```

### INVALID_LIQUIDATION_PROTOCOL_FEE

```solidity
string INVALID_LIQUIDATION_PROTOCOL_FEE
```

### INVALID_EMODE_CATEGORY

```solidity
string INVALID_EMODE_CATEGORY
```

### INVALID_UNBACKED_MINT_CAP

```solidity
string INVALID_UNBACKED_MINT_CAP
```

### INVALID_DEBT_CEILING

```solidity
string INVALID_DEBT_CEILING
```

### INVALID_RESERVE_INDEX

```solidity
string INVALID_RESERVE_INDEX
```

### ACL_ADMIN_CANNOT_BE_ZERO

```solidity
string ACL_ADMIN_CANNOT_BE_ZERO
```

### INCONSISTENT_PARAMS_LENGTH

```solidity
string INCONSISTENT_PARAMS_LENGTH
```

### ZERO_ADDRESS_NOT_VALID

```solidity
string ZERO_ADDRESS_NOT_VALID
```

### INVALID_EXPIRATION

```solidity
string INVALID_EXPIRATION
```

### INVALID_SIGNATURE

```solidity
string INVALID_SIGNATURE
```

### OPERATION_NOT_SUPPORTED

```solidity
string OPERATION_NOT_SUPPORTED
```

### DEBT_CEILING_NOT_ZERO

```solidity
string DEBT_CEILING_NOT_ZERO
```

### ASSET_NOT_LISTED

```solidity
string ASSET_NOT_LISTED
```

### INVALID_OPTIMAL_USAGE_RATIO

```solidity
string INVALID_OPTIMAL_USAGE_RATIO
```

### INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
string INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO
```

### UNDERLYING_CANNOT_BE_RESCUED

```solidity
string UNDERLYING_CANNOT_BE_RESCUED
```

### ADDRESSES_PROVIDER_ALREADY_ADDED

```solidity
string ADDRESSES_PROVIDER_ALREADY_ADDED
```

### POOL_ADDRESSES_DO_NOT_MATCH

```solidity
string POOL_ADDRESSES_DO_NOT_MATCH
```

### STABLE_BORROWING_ENABLED

```solidity
string STABLE_BORROWING_ENABLED
```

### SILOED_BORROWING_VIOLATION

```solidity
string SILOED_BORROWING_VIOLATION
```

### RESERVE_DEBT_NOT_ZERO

```solidity
string RESERVE_DEBT_NOT_ZERO
```

### FLASHLOAN_DISABLED

```solidity
string FLASHLOAN_DISABLED
```

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

## PercentageMath

Provides functions to perform percentage calculations

_Percentages are defined by default with 2 decimals of precision (100.00). The precision is indicated by PERCENTAGE_FACTOR
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### PERCENTAGE_FACTOR

```solidity
uint256 PERCENTAGE_FACTOR
```

### HALF_PERCENTAGE_FACTOR

```solidity
uint256 HALF_PERCENTAGE_FACTOR
```

### percentMul

```solidity
function percentMul(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage multiplication

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentmul percentage |

### percentDiv

```solidity
function percentDiv(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage division

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentdiv percentage |

## ConfiguratorInputTypes

### InitReserveInput

```solidity
struct InitReserveInput {
  address aTokenImpl;
  address variableDebtTokenImpl;
  uint8 underlyingAssetDecimals;
  address interestRateStrategyAddress;
  address underlyingAsset;
  address treasury;
  address incentivesController;
  string aTokenName;
  string aTokenSymbol;
  string variableDebtTokenName;
  string variableDebtTokenSymbol;
  bytes params;
}
```

### UpdateATokenInput

```solidity
struct UpdateATokenInput {
  address asset;
  address treasury;
  address incentivesController;
  string name;
  string symbol;
  address implementation;
  bytes params;
}
```

### UpdateDebtTokenInput

```solidity
struct UpdateDebtTokenInput {
  address asset;
  address incentivesController;
  string name;
  string symbol;
  address implementation;
  bytes params;
}
```

## DataTypes

### ReserveData

```solidity
struct ReserveData {
  struct DataTypes.ReserveConfigurationMap configuration;
  uint128 liquidityIndex;
  uint128 currentLiquidityRate;
  uint128 variableBorrowIndex;
  uint128 currentVariableBorrowRate;
  uint40 lastUpdateTimestamp;
  uint16 id;
  address aTokenAddress;
  address variableDebtTokenAddress;
  address interestRateStrategyAddress;
  uint128 accruedToTreasury;
}
```

### ReserveConfigurationMap

```solidity
struct ReserveConfigurationMap {
  uint256 data;
}
```

### UserConfigurationMap

```solidity
struct UserConfigurationMap {
  uint256 data;
}
```

### InterestRateMode

```solidity
enum InterestRateMode {
  NONE,
  VARIABLE
}
```

### ReserveCache

```solidity
struct ReserveCache {
  uint256 currScaledVariableDebt;
  uint256 nextScaledVariableDebt;
  uint256 currLiquidityIndex;
  uint256 nextLiquidityIndex;
  uint256 currVariableBorrowIndex;
  uint256 nextVariableBorrowIndex;
  uint256 currLiquidityRate;
  uint256 currVariableBorrowRate;
  uint256 reserveFactor;
  struct DataTypes.ReserveConfigurationMap reserveConfiguration;
  address aTokenAddress;
  address variableDebtTokenAddress;
  uint40 reserveLastUpdateTimestamp;
}
```

### ExecuteLiquidationCallParams

```solidity
struct ExecuteLiquidationCallParams {
  uint256 reservesCount;
  uint256 debtToCover;
  address collateralAsset;
  address debtAsset;
  bytes32 position;
  address oracle;
}
```

### ExecuteSupplyParams

```solidity
struct ExecuteSupplyParams {
  address asset;
  uint256 amount;
  bytes32 onBehalfOfPosition;
  uint16 referralCode;
}
```

### ExecuteBorrowParams

```solidity
struct ExecuteBorrowParams {
  address asset;
  address user;
  bytes32 onBehalfOfPosition;
  uint256 amount;
  uint16 referralCode;
  bool releaseUnderlying;
  uint256 reservesCount;
  address oracle;
}
```

### ExecuteRepayParams

```solidity
struct ExecuteRepayParams {
  address asset;
  uint256 amount;
  bytes32 onBehalfOfPosition;
}
```

### ExecuteWithdrawParams

```solidity
struct ExecuteWithdrawParams {
  address asset;
  uint256 amount;
  bytes32 position;
  uint256 reservesCount;
  address oracle;
}
```

### FlashloanSimpleParams

```solidity
struct FlashloanSimpleParams {
  address receiverAddress;
  address asset;
  uint256 amount;
  bytes params;
  uint16 referralCode;
  uint256 flashLoanPremiumToProtocol;
  uint256 flashLoanPremiumTotal;
}
```

### FlashLoanRepaymentParams

```solidity
struct FlashLoanRepaymentParams {
  uint256 amount;
  uint256 totalPremium;
  uint256 flashLoanPremiumToProtocol;
  address asset;
  address receiverAddress;
  uint16 referralCode;
}
```

### CalculateUserAccountDataParams

```solidity
struct CalculateUserAccountDataParams {
  struct DataTypes.UserConfigurationMap userConfig;
  uint256 reservesCount;
  bytes32 position;
  address oracle;
}
```

### ValidateBorrowParams

```solidity
struct ValidateBorrowParams {
  struct DataTypes.ReserveCache reserveCache;
  struct DataTypes.UserConfigurationMap userConfig;
  address asset;
  bytes32 position;
  uint256 amount;
  uint256 reservesCount;
  address oracle;
}
```

### ValidateLiquidationCallParams

```solidity
struct ValidateLiquidationCallParams {
  struct DataTypes.ReserveCache debtReserveCache;
  uint256 totalDebt;
  uint256 healthFactor;
}
```

### CalculateInterestRatesParams

```solidity
struct CalculateInterestRatesParams {
  uint256 liquidityAdded;
  uint256 liquidityTaken;
  uint256 totalVariableDebt;
  uint256 reserveFactor;
  address reserve;
  address aToken;
}
```

### InitReserveParams

```solidity
struct InitReserveParams {
  address asset;
  address aTokenAddress;
  address variableDebtAddress;
  address interestRateStrategyAddress;
  uint16 reservesCount;
  uint16 maxNumberReserves;
}
```

## PoolConfigurator

_Implements the configuration methods for the Aave protocol_

### initReserves

```solidity
function initReserves(address pool, struct ConfiguratorInputTypes.InitReserveInput[] input) external
```

### setReserveBorrowing

```solidity
function setReserveBorrowing(address pool, address asset, bool enabled) external
```

### configureReserveAsCollateral

```solidity
function configureReserveAsCollateral(address pool, address asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus) external
```

### setReserveFreeze

```solidity
function setReserveFreeze(address pool, address asset, bool freeze) external
```

### setReserveFactor

```solidity
function setReserveFactor(address pool, address asset, uint256 newReserveFactor) external
```

### setBorrowCap

```solidity
function setBorrowCap(address pool, address asset, uint256 newBorrowCap) external
```

### setSupplyCap

```solidity
function setSupplyCap(address pool, address asset, uint256 newSupplyCap) external
```

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address pool, address asset, address newRateStrategyAddress) external
```

## PoolManager

### POOL_ADMIN_ROLE

```solidity
bytes32 POOL_ADMIN_ROLE
```

### EMERGENCY_ADMIN_ROLE

```solidity
bytes32 EMERGENCY_ADMIN_ROLE
```

### RISK_ADMIN_ROLE

```solidity
bytes32 RISK_ADMIN_ROLE
```

### constructor

```solidity
constructor(address _governance) public
```

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) external
```

### addPoolAdmin

```solidity
function addPoolAdmin(address pool, address admin) external
```

### removePoolAdmin

```solidity
function removePoolAdmin(address pool, address admin) external
```

### isPoolAdmin

```solidity
function isPoolAdmin(address pool, address admin) external view returns (bool)
```

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address pool, address admin) external
```

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address pool, address admin) external
```

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address pool, address admin) external view returns (bool)
```

### addRiskAdmin

```solidity
function addRiskAdmin(address pool, address admin) external
```

### removeRiskAdmin

```solidity
function removeRiskAdmin(address pool, address admin) external
```

### isRiskAdmin

```solidity
function isRiskAdmin(address pool, address admin) external view returns (bool)
```

### onlyPoolAdmin

```solidity
modifier onlyPoolAdmin(address pool)
```

_Only pool admin can call functions marked by this modifier._

### onlyEmergencyAdmin

```solidity
modifier onlyEmergencyAdmin(address pool)
```

### onlyEmergencyOrPoolAdmin

```solidity
modifier onlyEmergencyOrPoolAdmin(address pool)
```

### onlyRiskOrPoolAdmins

```solidity
modifier onlyRiskOrPoolAdmins(address pool)
```

## TimelockedActions

_Contract module which acts as a timelocked controller. When set as the
owner of an `Ownable` smart contract, it enforces a timelock on all
`onlyOwner` maintenance operations. This gives time for users of the
controlled contract to exit before a potentially dangerous maintenance
operation is applied.

By default, this contract is self administered, meaning administration tasks
have to go through the timelock process. The proposer (resp executor) role
is in charge of proposing (resp executing) operations. A common use case is
to position this {TimelockController} as the owner of a smart contract, with
a multisig or a DAO as the sole proposer._

### _DONE_TIMESTAMP

```solidity
uint256 _DONE_TIMESTAMP
```

### PROPOSER_ROLE

```solidity
bytes32 PROPOSER_ROLE
```

### CANCELLER_ROLE

```solidity
bytes32 CANCELLER_ROLE
```

### constructor

```solidity
constructor(uint256 minDelay, address admin) public
```

_Initializes the contract with the following parameters:

- `minDelay`: initial minimum delay in seconds for operations
- `proposers`: accounts to be granted proposer and canceller roles
- `executors`: accounts to be granted executor role
- `admin`: optional account to be granted admin role; disable with zero address

IMPORTANT: The optional admin can aid with initial configuration of roles after deployment
without being subject to delay, but this role should be subsequently renounced in favor of
administration through timelocked proposals. Previous versions of this contract would assign
this admin to the deployer automatically and should be renounced as well._

### onlyRoleOrOpenRole

```solidity
modifier onlyRoleOrOpenRole(bytes32 role)
```

_Modifier to make a function callable only by a certain role. In
addition to checking the sender's role, `address(0)` 's role is also
considered. Granting a role to `address(0)` is equivalent to enabling
this role for everyone._

### receive

```solidity
receive() external payable
```

_Contract might receive/hold ETH as part of the maintenance process._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### isOperation

```solidity
function isOperation(bytes32 id) public view returns (bool)
```

_Returns whether an id corresponds to a registered operation. This
includes both Waiting, Ready, and Done operations._

### isOperationPending

```solidity
function isOperationPending(bytes32 id) public view returns (bool)
```

_Returns whether an operation is pending or not. Note that a "pending" operation may also be "ready"._

### isOperationReady

```solidity
function isOperationReady(bytes32 id) public view returns (bool)
```

_Returns whether an operation is ready for execution. Note that a "ready" operation is also "pending"._

### isOperationDone

```solidity
function isOperationDone(bytes32 id) public view returns (bool)
```

_Returns whether an operation is done or not._

### getTimestamp

```solidity
function getTimestamp(bytes32 id) public view virtual returns (uint256)
```

_Returns the timestamp at which an operation becomes ready (0 for
unset operations, 1 for done operations)._

### getOperationState

```solidity
function getOperationState(bytes32 id) public view virtual returns (enum ITimelock.OperationState)
```

_Returns operation state._

### getMinDelay

```solidity
function getMinDelay() public view virtual returns (uint256)
```

_Returns the minimum delay in seconds for an operation to become valid.

This value can be changed by executing an operation that calls `updateDelay`._

### hashOperation

```solidity
function hashOperation(address target, uint256 value, bytes data, bytes32 predecessor, bytes32 salt) public pure virtual returns (bytes32)
```

_Returns the identifier of an operation containing a single
transaction._

### hashOperationBatch

```solidity
function hashOperationBatch(address[] targets, uint256[] values, bytes[] payloads, bytes32 predecessor, bytes32 salt) public pure virtual returns (bytes32)
```

_Returns the identifier of an operation containing a batch of
transactions._

### schedule

```solidity
function schedule(address target, uint256 value, bytes data, bytes32 predecessor, bytes32 salt, uint256 delay) internal virtual
```

_Schedule an operation containing a single transaction.

Emits {CallSalt} if salt is nonzero, and {CallScheduled}.

Requirements:

- the caller must have the 'proposer' role._

### cancel

```solidity
function cancel(bytes32 id) public virtual
```

_Cancel an operation.

Requirements:

- the caller must have the 'canceller' role._

### execute

```solidity
function execute(address target, uint256 value, bytes payload, bytes32 predecessor, bytes32 salt) public payable virtual
```

_Execute an (ready) operation containing a single transaction.

Emits a {CallExecuted} event.

Requirements:

- the caller must have the 'executor' role._

### _execute

```solidity
function _execute(address target, uint256 value, bytes data) internal virtual
```

_Execute an operation's call._

### _encodeStateBitmap

```solidity
function _encodeStateBitmap(enum ITimelock.OperationState operationState) internal pure returns (bytes32)
```

_Encodes a `OperationState` into a `bytes32` representation where each bit enabled corresponds to
the underlying position in the `OperationState` enum. For example:

0x000...1000
  ^^^^^^----- ...
        ^---- Done
         ^--- Ready
          ^-- Waiting
           ^- Unset_

### getRoleFromPool

```solidity
function getRoleFromPool(address pool, bytes32 role) public pure returns (bytes32)
```

## MockIncentivesController

### handleAction

```solidity
function handleAction(address, uint256, uint256) external
```

## MockPeripheryContractV1

### initialize

```solidity
function initialize(address manager, uint256 value) external
```

### getManager

```solidity
function getManager() external view returns (address)
```

### setManager

```solidity
function setManager(address newManager) external
```

## MockPeripheryContractV2

### initialize

```solidity
function initialize(address addressesProvider) external
```

### getManager

```solidity
function getManager() external view returns (address)
```

### setManager

```solidity
function setManager(address newManager) external
```

### getAddressesProvider

```solidity
function getAddressesProvider() external view returns (address)
```

## MockPool

## MockReserveConfiguration

### configuration

```solidity
struct DataTypes.ReserveConfigurationMap configuration
```

### setLtv

```solidity
function setLtv(uint256 ltv) external
```

### getLtv

```solidity
function getLtv() external view returns (uint256)
```

### setLiquidationBonus

```solidity
function setLiquidationBonus(uint256 bonus) external
```

### getLiquidationBonus

```solidity
function getLiquidationBonus() external view returns (uint256)
```

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(uint256 threshold) external
```

### getLiquidationThreshold

```solidity
function getLiquidationThreshold() external view returns (uint256)
```

### setDecimals

```solidity
function setDecimals(uint256 decimals) external
```

### getDecimals

```solidity
function getDecimals() external view returns (uint256)
```

### setFrozen

```solidity
function setFrozen(bool frozen) external
```

### getFrozen

```solidity
function getFrozen() external view returns (bool)
```

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(bool enabled) external
```

### getBorrowingEnabled

```solidity
function getBorrowingEnabled() external view returns (bool)
```

### setReserveFactor

```solidity
function setReserveFactor(uint256 reserveFactor) external
```

### getReserveFactor

```solidity
function getReserveFactor() external view returns (uint256)
```

### setBorrowCap

```solidity
function setBorrowCap(uint256 borrowCap) external
```

### getBorrowCap

```solidity
function getBorrowCap() external view returns (uint256)
```

### setSupplyCap

```solidity
function setSupplyCap(uint256 supplyCap) external
```

### getSupplyCap

```solidity
function getSupplyCap() external view returns (uint256)
```

### getFlags

```solidity
function getFlags() external view returns (bool, bool, bool, bool, bool)
```

### getParams

```solidity
function getParams() external view returns (uint256, uint256, uint256, uint256, uint256)
```

### getCaps

```solidity
function getCaps() external view returns (uint256, uint256)
```

## MockReserveInterestRateStrategy

### OPTIMAL_USAGE_RATIO

```solidity
uint256 OPTIMAL_USAGE_RATIO
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### _baseVariableBorrowRate

```solidity
uint256 _baseVariableBorrowRate
```

### _variableRateSlope1

```solidity
uint256 _variableRateSlope1
```

### _variableRateSlope2

```solidity
uint256 _variableRateSlope2
```

### _stableRateSlope1

```solidity
uint256 _stableRateSlope1
```

### _stableRateSlope2

```solidity
uint256 _stableRateSlope2
```

### MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO
```

### MAX_EXCESS_USAGE_RATIO

```solidity
uint256 MAX_EXCESS_USAGE_RATIO
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO
```

### _liquidityRate

```solidity
uint256 _liquidityRate
```

### _stableBorrowRate

```solidity
uint256 _stableBorrowRate
```

### _variableBorrowRate

```solidity
uint256 _variableBorrowRate
```

### constructor

```solidity
constructor(uint256 optimalUsageRatio, uint256 baseVariableBorrowRate, uint256 variableRateSlope1, uint256 variableRateSlope2) internal
```

### setLiquidityRate

```solidity
function setLiquidityRate(uint256 liquidityRate) public
```

### setStableBorrowRate

```solidity
function setStableBorrowRate(uint256 stableBorrowRate) public
```

### setVariableBorrowRate

```solidity
function setVariableBorrowRate(uint256 variableBorrowRate) public
```

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams) external view returns (uint256 liquidityRate, uint256 variableBorrowRate)
```

### getVariableRateSlope1

```solidity
function getVariableRateSlope1() external view returns (uint256)
```

Returns the variable rate slope below optimal usage ratio

_It's the variable rate when usage ratio > 0 and <= OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getVariableRateSlope2

```solidity
function getVariableRateSlope2() external view returns (uint256)
```

Returns the variable rate slope above optimal usage ratio

_It's the variable rate when usage ratio > OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getStableRateSlope1

```solidity
function getStableRateSlope1() external view returns (uint256)
```

### getStableRateSlope2

```solidity
function getStableRateSlope2() external view returns (uint256)
```

### getBaseVariableBorrowRate

```solidity
function getBaseVariableBorrowRate() external view returns (uint256)
```

Returns the base variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The base variable borrow rate, expressed in ray |

### getMaxVariableBorrowRate

```solidity
function getMaxVariableBorrowRate() external view returns (uint256)
```

Returns the maximum variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum variable borrow rate, expressed in ray |

## WadRayMathWrapper

### wad

```solidity
function wad() public pure returns (uint256)
```

### ray

```solidity
function ray() public pure returns (uint256)
```

### halfRay

```solidity
function halfRay() public pure returns (uint256)
```

### halfWad

```solidity
function halfWad() public pure returns (uint256)
```

### wadMul

```solidity
function wadMul(uint256 a, uint256 b) public pure returns (uint256)
```

### wadDiv

```solidity
function wadDiv(uint256 a, uint256 b) public pure returns (uint256)
```

### rayMul

```solidity
function rayMul(uint256 a, uint256 b) public pure returns (uint256)
```

### rayDiv

```solidity
function rayDiv(uint256 a, uint256 b) public pure returns (uint256)
```

### rayToWad

```solidity
function rayToWad(uint256 a) public pure returns (uint256)
```

### wadToRay

```solidity
function wadToRay(uint256 a) public pure returns (uint256)
```

## WETH9Mocked

## IAToken

Defines the basic interface for an AToken.

### BalanceTransfer

```solidity
event BalanceTransfer(address from, address to, uint256 value, uint256 index)
```

_Emitted during the transfer action_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The user whose tokens are being transferred |
| to | address | The recipient |
| value | uint256 | The scaled amount being transferred |
| index | uint256 | The next liquidity index of the reserve |

### mint

```solidity
function mint(address caller, address onBehalfOf, uint256 amount, uint256 index) external returns (bool)
```

Mints `amount` aTokens to `user`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted aTokens |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` if the the previous balance of the user was 0 |

### burn

```solidity
function burn(address from, address receiverOfUnderlying, uint256 amount, uint256 index) external
```

Burns aTokens from `user` and sends the equivalent amount of underlying to `receiverOfUnderlying`

_In some instances, the mint event could be emitted from a burn transaction
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the aTokens will be burned |
| receiverOfUnderlying | address | The address that will receive the underlying |
| amount | uint256 | The amount being burned |
| index | uint256 | The next liquidity index of the reserve |

### mintToTreasury

```solidity
function mintToTreasury(uint256 amount, uint256 index) external
```

Mints aTokens to the reserve treasury

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

### transferOnLiquidation

```solidity
function transferOnLiquidation(address from, address to, uint256 value) external
```

Transfers aTokens in the event of a borrow being liquidated, in case the liquidators reclaims the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address getting liquidated, current owner of the aTokens |
| to | address | The recipient |
| value | uint256 | The amount of tokens getting transferred |

### transferUnderlyingTo

```solidity
function transferUnderlyingTo(address target, uint256 amount) external
```

Transfers the underlying asset to `target`.

_Used by the Pool to transfer assets in borrow(), withdraw() and flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The recipient of the underlying |
| amount | uint256 | The amount getting transferred |

### handleRepayment

```solidity
function handleRepayment(address user, address onBehalfOf, uint256 amount) external
```

Handles the underlying received by the aToken after the transfer has been completed.

_The default implementation is empty as with standard ERC20 tokens, nothing needs to be done after the
transfer is concluded. However in the future there may be aTokens that allow for example to stake the underlying
to receive LM rewards. In that case, `handleRepayment()` would perform the staking of the underlying asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user executing the repayment |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed |
| amount | uint256 | The amount getting repaid |

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this aToken (E.g. WETH for aWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

### RESERVE_TREASURY_ADDRESS

```solidity
function RESERVE_TREASURY_ADDRESS() external view returns (address)
```

Returns the address of the Aave treasury, receiving the fees on this aToken.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Address of the Aave treasury |

### DOMAIN_SEPARATOR

```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32)
```

Get the domain separator for the token

_Return cached value if chainId matches cache, otherwise recomputes separator_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator of the token at current chain |

### nonces

```solidity
function nonces(address owner) external view returns (uint256)
```

Returns the nonce for owner.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The address of the owner |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The nonce of the owner |

### rescueTokens

```solidity
function rescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

## IAggregatorInterface

### latestAnswer

```solidity
function latestAnswer() external view returns (int256)
```

### latestTimestamp

```solidity
function latestTimestamp() external view returns (uint256)
```

### latestRound

```solidity
function latestRound() external view returns (uint256)
```

### getAnswer

```solidity
function getAnswer(uint256 roundId) external view returns (int256)
```

### getTimestamp

```solidity
function getTimestamp(uint256 roundId) external view returns (uint256)
```

### AnswerUpdated

```solidity
event AnswerUpdated(int256 current, uint256 roundId, uint256 updatedAt)
```

### NewRound

```solidity
event NewRound(uint256 roundId, address startedBy, uint256 startedAt)
```

## IDefaultInterestRateStrategy

Defines the basic interface of the DefaultReserveInterestRateStrategy

### OPTIMAL_USAGE_RATIO

```solidity
function OPTIMAL_USAGE_RATIO() external view returns (uint256)
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The optimal usage ratio, expressed in ray. |

### MAX_EXCESS_USAGE_RATIO

```solidity
function MAX_EXCESS_USAGE_RATIO() external view returns (uint256)
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The max excess usage ratio, expressed in ray. |

### getVariableRateSlope1

```solidity
function getVariableRateSlope1() external view returns (uint256)
```

Returns the variable rate slope below optimal usage ratio

_It's the variable rate when usage ratio > 0 and <= OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getVariableRateSlope2

```solidity
function getVariableRateSlope2() external view returns (uint256)
```

Returns the variable rate slope above optimal usage ratio

_It's the variable rate when usage ratio > OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getBaseVariableBorrowRate

```solidity
function getBaseVariableBorrowRate() external view returns (uint256)
```

Returns the base variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The base variable borrow rate, expressed in ray |

### getMaxVariableBorrowRate

```solidity
function getMaxVariableBorrowRate() external view returns (uint256)
```

Returns the maximum variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum variable borrow rate, expressed in ray |

## IERC20Detailed

### name

```solidity
function name() external view returns (string)
```

### symbol

```solidity
function symbol() external view returns (string)
```

### decimals

```solidity
function decimals() external view returns (uint8)
```

## IFlashLoanSimpleReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed asset

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the flash-borrowed asset |
| amount | uint256 | The amount of the flash-borrowed asset |
| premium | uint256 | The fee of the flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

## IReserveInterestRateStrategy

Interface for the calculation of the interest rates

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams params) external view returns (uint256, uint256)
```

Calculates the interest rates depending on the reserve's state and configurations

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address |  |
| extraData | bytes |  |
| params | struct DataTypes.CalculateInterestRatesParams | The parameters needed to calculate interest rates |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | liquidityRate The liquidity rate expressed in rays |
| [1] | uint256 | variableBorrowRate The variable borrow rate expressed in rays |

## IScaledBalanceToken

Defines the basic interface for a scaled-balance token.

### Mint

```solidity
event Mint(address caller, address onBehalfOf, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the mint action_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted tokens |
| value | uint256 | The scaled-up amount being minted (based on user entered amount and balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'onBehalfOf' |
| index | uint256 | The next liquidity index of the reserve |

### Burn

```solidity
event Burn(address from, address target, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the burn action
If the burn function does not involve a transfer of the underlying asset, the target defaults to zero address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the tokens will be burned |
| target | address | The address that will receive the underlying, if any |
| value | uint256 | The scaled-up amount being burned (user entered amount - balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'from' |
| index | uint256 | The next liquidity index of the reserve |

### scaledBalanceOf

```solidity
function scaledBalanceOf(address user) external view returns (uint256)
```

Returns the scaled balance of the user.

_The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
at the moment of the update_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user whose balance is calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |

### getScaledUserBalanceAndSupply

```solidity
function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256)
```

Returns the scaled balance of the user and the scaled total supply.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |
| [1] | uint256 | The scaled total supply |

### scaledTotalSupply

```solidity
function scaledTotalSupply() external view returns (uint256)
```

Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total supply |

### getPreviousIndex

```solidity
function getPreviousIndex(address user) external view returns (uint256)
```

Returns last index interest was accrued to the user's balance

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The last index interest was accrued to the user's balance, expressed in ray |

## IVariableDebtToken

Defines the basic interface for a variable debt token.

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 index) external returns (bool, uint256)
```

Mints debt token to the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt being minted |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the previous balance of the user is 0, false otherwise |
| [1] | uint256 | The scaled total debt of the reserve |

### burn

```solidity
function burn(address from, uint256 amount, uint256 index) external returns (uint256)
```

Burns user variable debt

_In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount getting burned |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total debt of the reserve |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this debtToken (E.g. WETH for variableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

## ProtocolDataProvider

### ETH

```solidity
address ETH
```

### getAllReservesTokens

```solidity
function getAllReservesTokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing reserves in the pool.

_Handling MKR and ETH in a different way since they do not have standard `symbol` functions._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of reserves, pairs of symbols and addresses |

### getAllATokens

```solidity
function getAllATokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing ATokens in the pool.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of ATokens, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address pool, address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool isActive, bool isFrozen)
```

Returns the configuration data of the reserve

_Not returning borrow and supply caps for compatibility, nor pause flag_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| decimals | uint256 | The number of decimals of the reserve |
| ltv | uint256 | The ltv of the reserve |
| liquidationThreshold | uint256 | The liquidationThreshold of the reserve |
| liquidationBonus | uint256 | The liquidationBonus of the reserve |
| reserveFactor | uint256 | The reserveFactor of the reserve |
| usageAsCollateralEnabled | bool | True if the usage as collateral is enabled, false otherwise |
| borrowingEnabled | bool | True if borrowing is enabled, false otherwise |
| isActive | bool | True if it is active, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveCaps

```solidity
function getReserveCaps(address pool, address asset) external view returns (uint256 borrowCap, uint256 supplyCap)
```

Returns the caps parameters of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrowCap | uint256 | The borrow cap of the reserve |
| supplyCap | uint256 | The supply cap of the reserve |

### getPaused

```solidity
function getPaused(address pool, address asset) external view returns (bool isPaused)
```

Returns if the pool is paused

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| isPaused | bool | True if the pool is paused, false otherwise |

### getATokenTotalSupply

```solidity
function getATokenTotalSupply(address pool, address asset) external view returns (uint256)
```

Returns the total supply of aTokens for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply of the aToken |

### getTotalDebt

```solidity
function getTotalDebt(address pool, address asset) external view returns (uint256)
```

Returns the total debt for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total debt for asset |

### getUserReserveData

```solidity
function getUserReserveData(address pool, address asset, address user) external view returns (uint256 currentATokenBalance, uint256 currentVariableDebt, uint256 scaledVariableDebt, uint256 liquidityRate, bool usageAsCollateralEnabled)
```

Returns the user data in a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| currentATokenBalance | uint256 | The current AToken balance of the user |
| currentVariableDebt | uint256 | The current variable debt of the user |
| scaledVariableDebt | uint256 | The scaled variable debt of the user |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| usageAsCollateralEnabled | bool | True if the user is using the asset as collateral, false         otherwise |

### getReserveTokensAddresses

```solidity
function getReserveTokensAddresses(address pool, address asset) external view returns (address aTokenAddress, address variableDebtTokenAddress)
```

Returns the token addresses of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| aTokenAddress | address | The AToken address of the reserve |
| variableDebtTokenAddress | address | The VariableDebtToken address of the reserve |

### getInterestRateStrategyAddress

```solidity
function getInterestRateStrategyAddress(address pool, address asset) external view returns (address irStrategyAddress)
```

Returns the address of the Interest Rate strategy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| irStrategyAddress | address | The address of the Interest Rate strategy |

## FlashLoanSimpleReceiverBase

Base contract to develop a flashloan-receiver contract.

### POOL

```solidity
contract IPool POOL
```

## TokenConfiguration

### getPositionId

```solidity
function getPositionId(address user, uint256 index) internal pure returns (bytes32)
```

## UserConfiguration

Implements the bitmap logic to handle the user configuration

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### COLLATERAL_MASK

```solidity
uint256 COLLATERAL_MASK
```

### setBorrowing

```solidity
function setBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool borrowing) internal
```

Sets if the user is borrowing the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| borrowing | bool | True if the user is borrowing the reserve, false otherwise |

### setUsingAsCollateral

```solidity
function setUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool usingAsCollateral) internal
```

Sets if the user is using as collateral the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| usingAsCollateral | bool | True if the user is using the reserve as collateral, false otherwise |

### isUsingAsCollateralOrBorrowing

```solidity
function isUsingAsCollateralOrBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Returns if a user has been using the reserve for borrowing or as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing or as collateral, false otherwise |

### isBorrowing

```solidity
function isBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve for borrowing

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing, false otherwise |

### isUsingAsCollateral

```solidity
function isUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve as collateral, false otherwise |

### isUsingAsCollateralOne

```solidity
function isUsingAsCollateralOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying only one reserve as collateral

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isUsingAsCollateralAny

```solidity
function isUsingAsCollateralAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying any reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral any reserve, false otherwise |

### isBorrowingOne

```solidity
function isBorrowingOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing only one asset

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isBorrowingAny

```solidity
function isBorrowingAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing from any reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been borrowing any reserve, false otherwise |

### isEmpty

```solidity
function isEmpty(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has not been using any reserve for borrowing or supply

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has not been borrowing or supplying any reserve, false otherwise |

### _getFirstAssetIdByMask

```solidity
function _getFirstAssetIdByMask(struct DataTypes.UserConfigurationMap self, uint256 mask) internal pure returns (uint256)
```

Returns the address of the first asset flagged in the bitmap given the corresponding bitmask

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| mask | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The index of the first asset flagged in the bitmap once the corresponding mask is applied |

## Helpers

### getUserCurrentDebt

```solidity
function getUserCurrentDebt(bytes32 position, struct DataTypes.ReserveCache reserveCache) internal view returns (uint256, uint256)
```

Fetches the user current stable and variable debt balances

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| position | bytes32 | The user address |
| reserveCache | struct DataTypes.ReserveCache | The reserve cache data object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable debt balance |
| [1] | uint256 | The variable debt balance |

## BorrowLogic

Implements the base logic for all the actions related to borrowing

### Borrow

```solidity
event Borrow(address reserve, address user, bytes32 position, uint256 amount, uint256 borrowRate, uint16 referralCode)
```

### Repay

```solidity
event Repay(address reserve, bytes32 position, address repayer, uint256 amount)
```

### executeBorrow

```solidity
function executeBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteBorrowParams params) public
```

Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
Aave protocol proportionally to their collateralization power.

_Emits the `Borrow()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteBorrowParams | The additional parameters needed to execute the borrow function |

### executeRepay

```solidity
function executeRepay(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteRepayParams params) external returns (uint256)
```

Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
equivalent amount of debt for the user by burning the corresponding debt token.

_Emits the `Repay()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteRepayParams | The additional parameters needed to execute the repay function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount being repaid |

## FlashLoanLogic

Implements the logic for the flash loans

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, uint256 premium, uint16 referralCode)
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
  uint256 flashloanPremiumToProtocol;
}
```

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

## GenericLogic

Implements protocol-level logic to calculate and validate the state of a user

### CalculateUserAccountDataVars

```solidity
struct CalculateUserAccountDataVars {
  uint256 assetPrice;
  uint256 assetUnit;
  uint256 userBalanceInBaseCurrency;
  uint256 decimals;
  uint256 ltv;
  uint256 liquidationThreshold;
  uint256 i;
  uint256 healthFactor;
  uint256 totalCollateralInBaseCurrency;
  uint256 totalDebtInBaseCurrency;
  uint256 avgLtv;
  uint256 avgLiquidationThreshold;
  uint256 eModeAssetPrice;
  uint256 eModeLtv;
  uint256 eModeLiqThreshold;
  uint256 eModeAssetCategory;
  address currentReserveAddress;
  bool hasZeroLtvCollateral;
  bool isInEModeCategory;
}
```

### calculateUserAccountData

```solidity
function calculateUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.CalculateUserAccountDataParams params) internal view returns (uint256, uint256, uint256, uint256, uint256, bool)
```

Calculates the user data across the reserves.

_It includes the total liquidity/collateral/borrow balances in the base currency used by the price feed,
the average Loan To Value, the average Liquidation Ratio, and the Health factor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional parameters needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total collateral of the user in the base currency used by the price feed |
| [1] | uint256 | The total debt of the user in the base currency used by the price feed |
| [2] | uint256 | The average ltv of the user |
| [3] | uint256 | The average liquidation threshold of the user |
| [4] | uint256 | The health factor of the user |
| [5] | bool | True if the ltv is zero, false otherwise |

### calculateAvailableBorrows

```solidity
function calculateAvailableBorrows(uint256 totalCollateralInBaseCurrency, uint256 totalDebtInBaseCurrency, uint256 ltv) internal pure returns (uint256)
```

Calculates the maximum amount that can be borrowed depending on the available collateral, the total debt
and the average Loan To Value

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralInBaseCurrency | uint256 | The total collateral in the base currency used by the price feed |
| totalDebtInBaseCurrency | uint256 | The total borrow balance in the base currency used by the price feed |
| ltv | uint256 | The average loan to value |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The amount available to borrow in the base currency of the used by the price feed |

## LiquidationLogic

Implements actions involving management of collateral in the protocol, the main one being the liquidations

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, bytes32 position)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, bytes32 position)
```

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, bytes32 user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator)
```

### DEFAULT_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 DEFAULT_LIQUIDATION_CLOSE_FACTOR
```

_Default percentage of borrower's debt to be repaid in a liquidation.
Percentage applied when the users health factor is above `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 0.5e4 results in 50.00%_

### MAX_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 MAX_LIQUIDATION_CLOSE_FACTOR
```

_Maximum percentage of borrower's debt to be repaid in a liquidation
Percentage applied when the users health factor is below `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 1e4 results in 100.00%_

### CLOSE_FACTOR_HF_THRESHOLD

```solidity
uint256 CLOSE_FACTOR_HF_THRESHOLD
```

_This constant represents below which health factor value it is possible to liquidate
an amount of debt corresponding to `MAX_LIQUIDATION_CLOSE_FACTOR`.
A value of 0.95e18 results in 0.95_

### LiquidationCallLocalVars

```solidity
struct LiquidationCallLocalVars {
  uint256 userCollateralBalance;
  uint256 userVariableDebt;
  uint256 userTotalDebt;
  uint256 actualDebtToLiquidate;
  uint256 actualCollateralToLiquidate;
  uint256 liquidationBonus;
  uint256 healthFactor;
  uint256 liquidationProtocolFeeAmount;
  address collateralPriceSource;
  address debtPriceSource;
  contract IAToken collateralAToken;
  struct DataTypes.ReserveCache debtReserveCache;
}
```

### executeLiquidationCall

```solidity
function executeLiquidationCall(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(address => mapping(bytes32 => uint256)) _balances, mapping(bytes32 => struct DataTypes.UserConfigurationMap) usersConfig, struct DataTypes.ExecuteLiquidationCallParams params) external
```

Function to liquidate a position if its Health Factor drops below 1. The caller (liquidator)
covers `debtToCover` amount of debt of the user getting liquidated, and receives
a proportional amount of the `collateralAsset` plus a bonus to cover market risk

_Emits the `LiquidationCall()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| _balances | mapping(address &#x3D;&gt; mapping(bytes32 &#x3D;&gt; uint256)) |  |
| usersConfig | mapping(bytes32 &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |

### _burnCollateralATokens

```solidity
function _burnCollateralATokens(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the collateral aTokens and transfers the underlying to the liquidator.

_The function also updates the state and the interest rate of the collateral reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | The executeLiquidationCall() function local vars |

### _burnDebtTokens

```solidity
function _burnDebtTokens(struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the debt tokens of the user up to the amount being repaid by the liquidator.

_The function alters the `debtReserveCache` state in `vars` to update the debt related data._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | the executeLiquidationCall() function local vars |

### _calculateDebt

```solidity
function _calculateDebt(struct DataTypes.ReserveCache debtReserveCache, struct DataTypes.ExecuteLiquidationCallParams params, uint256 healthFactor) internal view returns (uint256, uint256, uint256)
```

Calculates the total debt of the user and the actual amount to liquidate depending on the health factor
and corresponding close factor.

_If the Health Factor is below CLOSE_FACTOR_HF_THRESHOLD, the close factor is increased to MAX_LIQUIDATION_CLOSE_FACTOR_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| debtReserveCache | struct DataTypes.ReserveCache | The reserve cache data object of the debt reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| healthFactor | uint256 | The health factor of the position |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable debt of the user |
| [1] | uint256 | The total debt of the user |
| [2] | uint256 | The actual debt to liquidate as a function of the closeFactor |

### _getConfigurationData

```solidity
function _getConfigurationData(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params) internal view returns (contract IAToken, address, address, uint256)
```

Returns the configuration data for the debt and the collateral reserves.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IAToken | The collateral aToken |
| [1] | address | The address to use as price source for the collateral |
| [2] | address | The address to use as price source for the debt |
| [3] | uint256 | The liquidation bonus to apply to the collateral |

### AvailableCollateralToLiquidateLocalVars

```solidity
struct AvailableCollateralToLiquidateLocalVars {
  uint256 collateralPrice;
  uint256 debtAssetPrice;
  uint256 maxCollateralToLiquidate;
  uint256 baseCollateral;
  uint256 bonusCollateral;
  uint256 debtAssetDecimals;
  uint256 collateralDecimals;
  uint256 collateralAssetUnit;
  uint256 debtAssetUnit;
  uint256 collateralAmount;
  uint256 debtAmountNeeded;
  uint256 liquidationProtocolFeePercentage;
  uint256 liquidationProtocolFee;
}
```

### _calculateAvailableCollateralToLiquidate

```solidity
function _calculateAvailableCollateralToLiquidate(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ReserveCache debtReserveCache, address collateralAsset, address debtAsset, uint256 debtToCover, uint256 userCollateralBalance, uint256 liquidationBonus, contract IPool oracle) internal view returns (uint256, uint256, uint256)
```

Calculates how much of a specific collateral can be liquidated, given
a certain amount of debt asset.

_This function needs to be called after all the checks to validate the liquidation have been performed,
  otherwise it might fail._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| debtReserveCache | struct DataTypes.ReserveCache | The cached data of the debt reserve |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| userCollateralBalance | uint256 | The collateral balance for the specific `collateralAsset` of the user being liquidated |
| liquidationBonus | uint256 | The collateral bonus percentage to receive as result of the liquidation |
| oracle | contract IPool |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum amount that is possible to liquidate given all the liquidation constraints (user balance, close factor) |
| [1] | uint256 | The amount to repay with the liquidation |
| [2] | uint256 | The fee taken from the liquidation bonus amount to be paid to the protocol |

## PoolLogic

Implements the logic for Pool specific functions

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

### executeInitReserve

```solidity
function executeInitReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.InitReserveParams params) external returns (bool)
```

Initialize an asset reserve and add the reserve to the list of reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.InitReserveParams | Additional parameters needed for initiation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true if appended, false if inserted at existing empty spot |

### executeMintToTreasury

```solidity
function executeMintToTreasury(mapping(address => struct DataTypes.ReserveData) reservesData, address[] assets) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### executeGetUserAccountData

```solidity
function executeGetUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.CalculateUserAccountDataParams params) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional params needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

## ReserveLogic

Implements the logic to update the reserves state

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

### getNormalizedIncome

```solidity
function getNormalizedIncome(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized income for the reserve.

_A value of 1e27 means there is no income. As time passes, the income is accrued
A value of 2*1e27 means for each unit of asset one unit of income has been accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized income, expressed in ray |

### getNormalizedDebt

```solidity
function getNormalizedDebt(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized variable debt for the reserve.

_A value of 1e27 means there is no debt. As time passes, the debt is accrued
A value of 2*1e27 means that for each unit of debt, one unit worth of interest has been accumulated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized variable debt, expressed in ray |

### updateState

```solidity
function updateState(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the liquidity cumulative index and the variable borrow index.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### cumulateToLiquidityIndex

```solidity
function cumulateToLiquidityIndex(struct DataTypes.ReserveData reserve, uint256 totalLiquidity, uint256 amount) internal returns (uint256)
```

Accumulates a predefined amount of asset to the reserve as a fixed, instantaneous income. Used for example
to accumulate the flashloan fee to the reserve, and spread it between all the suppliers.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| totalLiquidity | uint256 | The total liquidity available in the reserve |
| amount | uint256 | The amount to accumulate |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The next liquidity index of the reserve |

### init

```solidity
function init(struct DataTypes.ReserveData reserve, address interestRateStrategyAddress) internal
```

Initializes a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### UpdateInterestRatesLocalVars

```solidity
struct UpdateInterestRatesLocalVars {
  uint256 nextLiquidityRate;
  uint256 nextVariableRate;
  uint256 totalVariableDebt;
}
```

### updateInterestRates

```solidity
function updateInterestRates(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, address reserveAddress, uint256 liquidityAdded, uint256 liquidityTaken) internal
```

Updates the current variable borrow rate and the current liquidity rate.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |
| reserveAddress | address | The address of the reserve to be updated |
| liquidityAdded | uint256 | The amount of liquidity added to the protocol (supply or repay) in the previous action |
| liquidityTaken | uint256 | The amount of liquidity taken from the protocol (redeem or borrow) |

### AccrueToTreasuryLocalVars

```solidity
struct AccrueToTreasuryLocalVars {
  uint256 prevTotalVariableDebt;
  uint256 currTotalVariableDebt;
  uint256 totalDebtAccrued;
  uint256 amountToMint;
}
```

### _accrueToTreasury

```solidity
function _accrueToTreasury(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Mints part of the repaid interest to the reserve treasury as a function of the reserve factor for the
specific asset.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### _updateIndexes

```solidity
function _updateIndexes(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the reserve indexes and the timestamp of the update.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The cache layer holding the cached protocol data |

### cache

```solidity
function cache(struct DataTypes.ReserveData reserve) internal view returns (struct DataTypes.ReserveCache)
```

Creates a cache object to avoid repeated storage reads and external contract calls when updating state and
interest rates.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object for which the cache will be filled |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveCache | The cache object |

## SupplyLogic

Implements the base logic for supply/withdraw

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, bytes32 position)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, bytes32 position)
```

### Withdraw

```solidity
event Withdraw(address reserve, bytes32 pos, address to, uint256 amount)
```

### Supply

```solidity
event Supply(address reserve, address user, bytes32 pos, uint256 amount, uint16 referralCode)
```

### executeSupply

```solidity
function executeSupply(mapping(address => struct DataTypes.ReserveData) reservesData, struct DataTypes.ExecuteSupplyParams params) external
```

Implements the supply feature. Through `supply()`, users supply assets to the Aave protocol.

_Emits the `Supply()` event.
In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
collateral._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| params | struct DataTypes.ExecuteSupplyParams | The additional parameters needed to execute the supply function |

### executeWithdraw

```solidity
function executeWithdraw(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteWithdrawParams params) external returns (uint256)
```

Implements the withdraw feature. Through `withdraw()`, users redeem their aTokens for the underlying asset
previously supplied in the Aave protocol.

_Emits the `Withdraw()` event.
If the user withdraws everything, `ReserveUsedAsCollateralDisabled()` is emitted._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteWithdrawParams | The additional parameters needed to execute the withdraw function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount withdrawn |

## ValidationLogic

Implements functions to validate the different actions of the protocol

### REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD

```solidity
uint256 REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD
```

### MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

### HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

_Minimum health factor to consider a user position healthy
A value of 1e18 results in 1_

### validateSupply

```solidity
function validateSupply(struct DataTypes.ReserveCache reserveCache, struct DataTypes.ReserveData reserve, uint256 amount) internal view
```

Validates a supply action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| reserve | struct DataTypes.ReserveData |  |
| amount | uint256 | The amount to be supplied |

### validateWithdraw

```solidity
function validateWithdraw(struct DataTypes.ReserveCache reserveCache, uint256 amount, uint256 userBalance) internal pure
```

Validates a withdraw action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amount | uint256 | The amount to be withdrawn |
| userBalance | uint256 | The balance of the user |

### ValidateBorrowLocalVars

```solidity
struct ValidateBorrowLocalVars {
  uint256 currentLtv;
  uint256 collateralNeededInBaseCurrency;
  uint256 userCollateralInBaseCurrency;
  uint256 userDebtInBaseCurrency;
  uint256 availableLiquidity;
  uint256 healthFactor;
  uint256 totalDebt;
  uint256 totalSupplyVariableDebt;
  uint256 reserveDecimals;
  uint256 borrowCap;
  uint256 amountInBaseCurrency;
  uint256 assetUnit;
  bool isActive;
  bool isFrozen;
  bool isPaused;
  bool borrowingEnabled;
}
```

### validateBorrow

```solidity
function validateBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.ValidateBorrowParams params) internal view
```

Validates a borrow action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.ValidateBorrowParams | Additional params needed for the validation |

### validateRepay

```solidity
function validateRepay(struct DataTypes.ReserveCache reserveCache, uint256 amountSent, bytes32 onBehalfOfPosition, uint256 variableDebt) internal view
```

Validates a repay action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amountSent | uint256 | The amount sent for the repayment. Can be an actual value or uint(-1) |
| onBehalfOfPosition | bytes32 | The address of the user msg.sender is repaying for |
| variableDebt | uint256 | The borrow balance of the user |

### validateFlashloanSimple

```solidity
function validateFlashloanSimple(struct DataTypes.ReserveData reserve) internal view
```

Validates a flashloan action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the reserve |

### ValidateLiquidationCallLocalVars

```solidity
struct ValidateLiquidationCallLocalVars {
  bool collateralReserveActive;
  bool collateralReservePaused;
  bool principalReserveActive;
  bool principalReservePaused;
  bool isCollateralEnabled;
}
```

### validateLiquidationCall

```solidity
function validateLiquidationCall(struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveData collateralReserve, struct DataTypes.ValidateLiquidationCallParams params) internal view
```

Validates the liquidation action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping |
| collateralReserve | struct DataTypes.ReserveData | The reserve data of the collateral |
| params | struct DataTypes.ValidateLiquidationCallParams | Additional parameters needed for the validation |

### validateHealthFactor

```solidity
function validateHealthFactor(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, bytes32 position, uint256 reservesCount, address oracle) internal view returns (uint256, bool)
```

Validates the health factor of a user.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| position | bytes32 | The user to validate health factor of |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

### validateHFAndLtv

```solidity
function validateHFAndLtv(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, address asset, bytes32 fromPosition, uint256 reservesCount, address oracle) internal view
```

Validates the health factor of a user and the ltv of the asset being withdrawn.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| asset | address | The asset for which the ltv will be validated |
| fromPosition | bytes32 | The user from which the aTokens are being transferred |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

## MathUtils

Provides functions to perform linear and compounded interest calculations

### SECONDS_PER_YEAR

```solidity
uint256 SECONDS_PER_YEAR
```

_Ignoring leap years_

### calculateLinearInterest

```solidity
function calculateLinearInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Function to calculate the interest accumulated using a linear interest rate formula_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate linearly accumulated during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp, uint256 currentTimestamp) internal pure returns (uint256)
```

_Function to calculate the interest using a compounded interest rate formula
To avoid expensive exponentiation, the calculation is performed using a binomial approximation:

 (1+x)^n = 1+n*x+[n/2*(n-1)]*x^2+[n/6*(n-1)*(n-2)*x^3...

The approximation slightly underpays liquidity providers and undercharges borrowers, with the advantage of great
gas cost reductions. The whitepaper contains reference to the approximation and a table showing the margin of
error per different time periods_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |
| currentTimestamp | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Calculates the compounded interest between the timestamp of the last update and the current block timestamp_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate (in ray) |
| lastUpdateTimestamp | uint40 | The timestamp from which the interest accumulation needs to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded between lastUpdateTimestamp and current block timestamp, in ray |

## WadRayMath

Provides functions to perform calculations with Wad and Ray units

_Provides mul and div function for wads (decimal numbers with 18 digits of precision) and rays (decimal numbers
with 27 digits of precision)
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### WAD

```solidity
uint256 WAD
```

### HALF_WAD

```solidity
uint256 HALF_WAD
```

### RAY

```solidity
uint256 RAY
```

### HALF_RAY

```solidity
uint256 HALF_RAY
```

### WAD_RAY_RATIO

```solidity
uint256 WAD_RAY_RATIO
```

### wadMul

```solidity
function wadMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Multiplies two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a*b, in wad |

### wadDiv

```solidity
function wadDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Divides two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a/b, in wad |

### rayMul

```solidity
function rayMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Multiplies two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raymul b |

### rayDiv

```solidity
function rayDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Divides two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raydiv b |

### rayToWad

```solidity
function rayToWad(uint256 a) internal pure returns (uint256 b)
```

_Casts ray down to wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted to wad, rounded half up to the nearest wad |

### wadToRay

```solidity
function wadToRay(uint256 a) internal pure returns (uint256 b)
```

_Converts wad up to ray
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted in ray |

## Pool

### _reserves

```solidity
mapping(address => struct DataTypes.ReserveData) _reserves
```

### _usersConfig

```solidity
mapping(bytes32 => struct DataTypes.UserConfigurationMap) _usersConfig
```

### _balances

```solidity
mapping(address => mapping(bytes32 => uint256)) _balances
```

### _debts

```solidity
mapping(address => mapping(bytes32 => uint256)) _debts
```

### _totalSupplies

```solidity
mapping(address => uint256) _totalSupplies
```

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

### _flashLoanPremiumTotal

```solidity
uint128 _flashLoanPremiumTotal
```

### _reservesCount

```solidity
uint16 _reservesCount
```

### _assetsSources

```solidity
mapping(address => contract IAggregatorInterface) _assetsSources
```

### configurator

```solidity
address configurator
```

### initialize

```solidity
function initialize(address _configurator, address[] assets, address[] rateStrategyAddresses, address[] sources, struct DataTypes.ReserveConfigurationMap[] configurations) public virtual
```

Initializes the Pool.

_Function is invoked by the proxy contract when the Pool contract is added to the
PoolAddressesProvider of the market.
Caching the address of the PoolAddressesProvider in order to reduce gas consumption on subsequent operations_

### supply

```solidity
function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode, uint256 index) public virtual
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| index | uint256 |  |

### withdraw

```solidity
function withdraw(address asset, uint256 amount, address to, uint256 index) public virtual returns (uint256)
```

Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to withdraw |
| amount | uint256 | The underlying amount to be withdrawn   - Send the value type(uint256).max in order to withdraw the whole aToken balance |
| to | address | The address that will receive the underlying, same as msg.sender if the user   wants to receive it on his own wallet, or a different address if the beneficiary is a   different wallet |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount withdrawn |

### borrow

```solidity
function borrow(address asset, uint256 amount, uint16 referralCode, address onBehalfOf, uint256 index) public virtual
```

Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
already supplied enough collateral, or he was given enough allowance by a credit delegator on the
corresponding debt token (StableDebtToken or VariableDebtToken)
- E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
  and 100 stable/variable debt tokens, depending on the `interestRateMode`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to borrow |
| amount | uint256 | The amount to be borrowed |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| onBehalfOf | address | The address of the user who will receive the debt. Should be the address of the borrower itself calling the function if he wants to borrow against his own collateral, or the address of the credit delegator if he has been given credit delegation allowance |
| index | uint256 |  |

### repay

```solidity
function repay(address asset, uint256 amount, address onBehalfOf, uint256 index) public virtual returns (uint256)
```

Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
- E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### liquidate

```solidity
function liquidate(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 index) public virtual
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| index | uint256 |  |

### flashLoan

```solidity
function flashLoan(address receiverAddress, address asset, uint256 amount, bytes params, uint16 referralCode) public virtual
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface |
| asset | address | The address of the asset being flash-borrowed |
| amount | uint256 | The amount of the asset being flash-borrowed |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### mintToTreasury

```solidity
function mintToTreasury(address[] assets) external virtual
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### getReserveData

```solidity
function getReserveData(address asset) external view virtual returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### getUserAccountData

```solidity
function getUserAccountData(address user, uint256 index) external view virtual returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

### getConfiguration

```solidity
function getConfiguration(address asset) external view virtual returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user, uint256 index) external view virtual returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| index | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address asset) external view virtual returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address asset) external view virtual returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReservesList

```solidity
function getReservesList() external view virtual returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

_It does not include dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view virtual returns (uint256)
```

Returns the number of initialized reserves

_It includes dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

### _setReserveConfiguration

```solidity
function _setReserveConfiguration(address asset, address rateStrategyAddress, address source, struct DataTypes.ReserveConfigurationMap configuration) internal
```

### setReserveConfiguration

```solidity
function setReserveConfiguration(address asset, address rateStrategyAddress, address source, struct DataTypes.ReserveConfigurationMap configuration) external virtual
```

### getAssetPrice

```solidity
function getAssetPrice(address asset) public view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

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

## MockReserveConfiguration

### configuration

```solidity
struct DataTypes.ReserveConfigurationMap configuration
```

### setLtv

```solidity
function setLtv(uint256 ltv) external
```

### getLtv

```solidity
function getLtv() external view returns (uint256)
```

### setLiquidationBonus

```solidity
function setLiquidationBonus(uint256 bonus) external
```

### getLiquidationBonus

```solidity
function getLiquidationBonus() external view returns (uint256)
```

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(uint256 threshold) external
```

### getLiquidationThreshold

```solidity
function getLiquidationThreshold() external view returns (uint256)
```

### setDecimals

```solidity
function setDecimals(uint256 decimals) external
```

### getDecimals

```solidity
function getDecimals() external view returns (uint256)
```

### setFrozen

```solidity
function setFrozen(bool frozen) external
```

### getFrozen

```solidity
function getFrozen() external view returns (bool)
```

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(bool enabled) external
```

### getBorrowingEnabled

```solidity
function getBorrowingEnabled() external view returns (bool)
```

### setStableRateBorrowingEnabled

```solidity
function setStableRateBorrowingEnabled(bool enabled) external
```

### getStableRateBorrowingEnabled

```solidity
function getStableRateBorrowingEnabled() external view returns (bool)
```

### setReserveFactor

```solidity
function setReserveFactor(uint256 reserveFactor) external
```

### getReserveFactor

```solidity
function getReserveFactor() external view returns (uint256)
```

### setBorrowCap

```solidity
function setBorrowCap(uint256 borrowCap) external
```

### getBorrowCap

```solidity
function getBorrowCap() external view returns (uint256)
```

### setFlashLoanEnabled

```solidity
function setFlashLoanEnabled(bool enabled) external
```

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled() external view returns (bool)
```

### setSupplyCap

```solidity
function setSupplyCap(uint256 supplyCap) external
```

### getSupplyCap

```solidity
function getSupplyCap() external view returns (uint256)
```

### setLiquidationProtocolFee

```solidity
function setLiquidationProtocolFee(uint256 liquidationProtocolFee) external
```

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee() external view returns (uint256)
```

### getFlags

```solidity
function getFlags() external view returns (bool, bool, bool, bool, bool)
```

### getParams

```solidity
function getParams() external view returns (uint256, uint256, uint256, uint256, uint256)
```

### getCaps

```solidity
function getCaps() external view returns (uint256, uint256)
```

## FlashloanAttacker

### _pool

```solidity
contract IPool _pool
```

### supplyAsset

```solidity
function supplyAsset(address asset, uint256 amount) public
```

### _innerBorrow

```solidity
function _innerBorrow(address asset) internal
```

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address, bytes) public returns (bool)
```

## MockReserveInterestRateStrategy

### OPTIMAL_USAGE_RATIO

```solidity
uint256 OPTIMAL_USAGE_RATIO
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### _baseVariableBorrowRate

```solidity
uint256 _baseVariableBorrowRate
```

### _variableRateSlope1

```solidity
uint256 _variableRateSlope1
```

### _variableRateSlope2

```solidity
uint256 _variableRateSlope2
```

### _stableRateSlope1

```solidity
uint256 _stableRateSlope1
```

### _stableRateSlope2

```solidity
uint256 _stableRateSlope2
```

### MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO
```

### MAX_EXCESS_USAGE_RATIO

```solidity
uint256 MAX_EXCESS_USAGE_RATIO
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
uint256 OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO
```

### _liquidityRate

```solidity
uint256 _liquidityRate
```

### _stableBorrowRate

```solidity
uint256 _stableBorrowRate
```

### _variableBorrowRate

```solidity
uint256 _variableBorrowRate
```

### constructor

```solidity
constructor(uint256 optimalUsageRatio, uint256 baseVariableBorrowRate, uint256 variableRateSlope1, uint256 variableRateSlope2) internal
```

### setLiquidityRate

```solidity
function setLiquidityRate(uint256 liquidityRate) public
```

### setStableBorrowRate

```solidity
function setStableBorrowRate(uint256 stableBorrowRate) public
```

### setVariableBorrowRate

```solidity
function setVariableBorrowRate(uint256 variableBorrowRate) public
```

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams) external view returns (uint256 liquidityRate, uint256 variableBorrowRate)
```

### getVariableRateSlope1

```solidity
function getVariableRateSlope1() external view returns (uint256)
```

Returns the variable rate slope below optimal usage ratio

_It's the variable rate when usage ratio > 0 and <= OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getVariableRateSlope2

```solidity
function getVariableRateSlope2() external view returns (uint256)
```

Returns the variable rate slope above optimal usage ratio

_It's the variable rate when usage ratio > OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getStableRateSlope1

```solidity
function getStableRateSlope1() external view returns (uint256)
```

### getStableRateSlope2

```solidity
function getStableRateSlope2() external view returns (uint256)
```

### getBaseVariableBorrowRate

```solidity
function getBaseVariableBorrowRate() external view returns (uint256)
```

Returns the base variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The base variable borrow rate, expressed in ray |

### getMaxVariableBorrowRate

```solidity
function getMaxVariableBorrowRate() external view returns (uint256)
```

Returns the maximum variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum variable borrow rate, expressed in ray |

## MintableERC20

_ERC20 minting logic_

### EIP712_REVISION

```solidity
bytes EIP712_REVISION
```

### EIP712_DOMAIN

```solidity
bytes32 EIP712_DOMAIN
```

### PERMIT_TYPEHASH

```solidity
bytes32 PERMIT_TYPEHASH
```

### _nonces

```solidity
mapping(address => uint256) _nonces
```

### DOMAIN_SEPARATOR

```solidity
bytes32 DOMAIN_SEPARATOR
```

### constructor

```solidity
constructor(string name, string symbol) public
```

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

### mint

```solidity
function mint(uint256 value) public returns (bool)
```

_Function to mint tokens_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### mint

```solidity
function mint(address account, uint256 value) public returns (bool)
```

_Function to mint tokens to address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The account to mint tokens. |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### nonces

```solidity
function nonces(address owner) public view virtual returns (uint256)
```

## DefaultReserveInterestRateStrategy

Implements the calculation of the interest rates depending on the reserve state

_The model of interest rate is based on 2 slopes, one before the `OPTIMAL_USAGE_RATIO`
point of usage and another from that one to 100%.
- An instance of this same contract, can't be used across different Aave markets, due to the caching
  of the PoolAddressesProvider_

### OPTIMAL_USAGE_RATIO

```solidity
uint256 OPTIMAL_USAGE_RATIO
```

Returns the usage ratio at which the pool aims to obtain most competitive borrow rates.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### MAX_EXCESS_USAGE_RATIO

```solidity
uint256 MAX_EXCESS_USAGE_RATIO
```

Returns the excess usage ratio above the optimal.

_It's always equal to 1-optimal usage ratio (added as constant for gas optimizations)_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### _baseVariableBorrowRate

```solidity
uint256 _baseVariableBorrowRate
```

### _variableRateSlope1

```solidity
uint256 _variableRateSlope1
```

### _variableRateSlope2

```solidity
uint256 _variableRateSlope2
```

### constructor

```solidity
constructor(uint256 optimalUsageRatio, uint256 baseVariableBorrowRate, uint256 variableRateSlope1, uint256 variableRateSlope2) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| optimalUsageRatio | uint256 | The optimal usage ratio |
| baseVariableBorrowRate | uint256 | The base variable borrow rate |
| variableRateSlope1 | uint256 | The variable rate slope below optimal usage ratio |
| variableRateSlope2 | uint256 | The variable rate slope above optimal usage ratio |

### getVariableRateSlope1

```solidity
function getVariableRateSlope1() external view returns (uint256)
```

Returns the variable rate slope below optimal usage ratio

_It's the variable rate when usage ratio > 0 and <= OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getVariableRateSlope2

```solidity
function getVariableRateSlope2() external view returns (uint256)
```

Returns the variable rate slope above optimal usage ratio

_It's the variable rate when usage ratio > OPTIMAL_USAGE_RATIO_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable rate slope, expressed in ray |

### getBaseVariableBorrowRate

```solidity
function getBaseVariableBorrowRate() external view returns (uint256)
```

Returns the base variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The base variable borrow rate, expressed in ray |

### getMaxVariableBorrowRate

```solidity
function getMaxVariableBorrowRate() external view returns (uint256)
```

Returns the maximum variable borrow rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum variable borrow rate, expressed in ray |

### CalcInterestRatesLocalVars

```solidity
struct CalcInterestRatesLocalVars {
  uint256 availableLiquidity;
  uint256 totalDebt;
  uint256 currentVariableBorrowRate;
  uint256 currentLiquidityRate;
  uint256 borrowUsageRatio;
  uint256 supplyUsageRatio;
  uint256 availableLiquidityPlusDebt;
}
```

### calculateInterestRates

```solidity
function calculateInterestRates(address user, bytes extraData, struct DataTypes.CalculateInterestRatesParams params) public view returns (uint256, uint256)
```

Calculates the interest rates depending on the reserve's state and configurations

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address |  |
| extraData | bytes |  |
| params | struct DataTypes.CalculateInterestRatesParams | The parameters needed to calculate interest rates |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | liquidityRate The liquidity rate expressed in rays |
| [1] | uint256 | variableBorrowRate The variable borrow rate expressed in rays |

### _getOverallBorrowRate

```solidity
function _getOverallBorrowRate(uint256 totalVariableDebt, uint256 currentVariableBorrowRate) internal pure returns (uint256)
```

_Calculates the overall borrow rate as the weighted average between the total variable debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalVariableDebt | uint256 | The total borrowed from the reserve at a variable rate |
| currentVariableBorrowRate | uint256 | The current variable borrow rate of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The weighted averaged borrow rate |

## PoolStorage

Contract used as storage of the Pool contract.

_It defines the storage layout of the Pool contract._

### _reserves

```solidity
mapping(address => struct DataTypes.ReserveData) _reserves
```

### _usersConfig

```solidity
mapping(bytes32 => struct DataTypes.UserConfigurationMap) _usersConfig
```

### _balances

```solidity
mapping(address => mapping(bytes32 => uint256)) _balances
```

### _debts

```solidity
mapping(address => mapping(bytes32 => uint256)) _debts
```

### _totalSupplies

```solidity
mapping(address => uint256) _totalSupplies
```

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

### _flashLoanPremiumTotal

```solidity
uint128 _flashLoanPremiumTotal
```

### _reservesCount

```solidity
uint16 _reservesCount
```

### _assetsSources

```solidity
mapping(address => contract IAggregatorInterface) _assetsSources
```

### configurator

```solidity
address configurator
```

## IStableDebtToken

Defines the interface for the stable debt token

_It does not inherit from IERC20 to save in code size_

### Mint

```solidity
event Mint(address user, address onBehalfOf, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 newRate, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is minted_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user who triggered the minting |
| onBehalfOf | address | The recipient of stable debt tokens |
| amount | uint256 | The amount minted (user entered amount + balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of the user 'onBehalfOf' |
| newRate | uint256 | The rate of the debt after the minting |
| avgStableRate | uint256 | The next average stable rate after the minting |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### Burn

```solidity
event Burn(address from, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is burned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount being burned (user entered amount - balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of 'from' |
| avgStableRate | uint256 | The next average stable rate after the burning |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 rate) external returns (bool, uint256, uint256)
```

Mints debt token to the `onBehalfOf` address.

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt tokens to mint |
| rate | uint256 | The rate of the debt being minted |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if it is the first borrow, false otherwise |
| [1] | uint256 | The total stable debt |
| [2] | uint256 | The average stable borrow rate |

### burn

```solidity
function burn(address from, uint256 amount) external returns (uint256, uint256)
```

Burns debt of `user`

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt
In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest the user earned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount of debt tokens getting burned |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total stable debt |
| [1] | uint256 | The average stable borrow rate |

### getAverageStableRate

```solidity
function getAverageStableRate() external view returns (uint256)
```

Returns the average rate of all the stable rate loans.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The average stable rate |

### getUserStableRate

```solidity
function getUserStableRate(address user) external view returns (uint256)
```

Returns the stable rate of the user debt

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable rate of the user |

### getUserLastUpdated

```solidity
function getUserLastUpdated(address user) external view returns (uint40)
```

Returns the timestamp of the last update of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getSupplyData

```solidity
function getSupplyData() external view returns (uint256, uint256, uint256, uint40)
```

Returns the principal, the total supply, the average stable rate and the timestamp for the last update

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The principal |
| [1] | uint256 | The total supply |
| [2] | uint256 | The average stable rate |
| [3] | uint40 | The timestamp of the last update |

### getTotalSupplyLastUpdated

```solidity
function getTotalSupplyLastUpdated() external view returns (uint40)
```

Returns the timestamp of the last update of the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getTotalSupplyAndAvgRate

```solidity
function getTotalSupplyAndAvgRate() external view returns (uint256, uint256)
```

Returns the total supply and the average stable rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply |
| [1] | uint256 | The average rate |

### principalBalanceOf

```solidity
function principalBalanceOf(address user) external view returns (uint256)
```

Returns the principal debt balance of the user

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt balance of the user since the last burn/mint action |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this stableDebtToken (E.g. WETH for stableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

## AaveProtocolDataProvider

Peripheral contract to collect and pre-process information from the Pool.

### ETH

```solidity
address ETH
```

### getAllReservesTokens

```solidity
function getAllReservesTokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing reserves in the pool.

_Handling MKR and ETH in a different way since they do not have standard `symbol` functions._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of reserves, pairs of symbols and addresses |

### getAllATokens

```solidity
function getAllATokens(address pool) external view returns (struct IPoolDataProvider.TokenData[])
```

Returns the list of the existing ATokens in the pool.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct IPoolDataProvider.TokenData[] | The list of ATokens, pairs of symbols and addresses |

### getReserveConfigurationData

```solidity
function getReserveConfigurationData(address pool, address asset) external view returns (uint256 decimals, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus, uint256 reserveFactor, bool usageAsCollateralEnabled, bool borrowingEnabled, bool isActive, bool isFrozen)
```

Returns the configuration data of the reserve

_Not returning borrow and supply caps for compatibility, nor pause flag_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| decimals | uint256 | The number of decimals of the reserve |
| ltv | uint256 | The ltv of the reserve |
| liquidationThreshold | uint256 | The liquidationThreshold of the reserve |
| liquidationBonus | uint256 | The liquidationBonus of the reserve |
| reserveFactor | uint256 | The reserveFactor of the reserve |
| usageAsCollateralEnabled | bool | True if the usage as collateral is enabled, false otherwise |
| borrowingEnabled | bool | True if borrowing is enabled, false otherwise |
| isActive | bool | True if it is active, false otherwise |
| isFrozen | bool | True if it is frozen, false otherwise |

### getReserveCaps

```solidity
function getReserveCaps(address pool, address asset) external view returns (uint256 borrowCap, uint256 supplyCap)
```

Returns the caps parameters of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrowCap | uint256 | The borrow cap of the reserve |
| supplyCap | uint256 | The supply cap of the reserve |

### getPaused

```solidity
function getPaused(address pool, address asset) external view returns (bool isPaused)
```

Returns if the pool is paused

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| isPaused | bool | True if the pool is paused, false otherwise |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(address pool, address asset) external view returns (uint256)
```

Returns the protocol fee on the liquidation bonus

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The protocol fee on liquidation |

### getATokenTotalSupply

```solidity
function getATokenTotalSupply(address pool, address asset) external view returns (uint256)
```

Returns the total supply of aTokens for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply of the aToken |

### getTotalDebt

```solidity
function getTotalDebt(address pool, address asset) external view returns (uint256)
```

Returns the total debt for a given asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total debt for asset |

### getUserReserveData

```solidity
function getUserReserveData(address pool, address asset, address user) external view returns (uint256 currentATokenBalance, uint256 currentVariableDebt, uint256 scaledVariableDebt, uint256 liquidityRate, bool usageAsCollateralEnabled)
```

Returns the user data in a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| currentATokenBalance | uint256 | The current AToken balance of the user |
| currentVariableDebt | uint256 | The current variable debt of the user |
| scaledVariableDebt | uint256 | The scaled variable debt of the user |
| liquidityRate | uint256 | The liquidity rate of the reserve |
| usageAsCollateralEnabled | bool | True if the user is using the asset as collateral, false         otherwise |

### getReserveTokensAddresses

```solidity
function getReserveTokensAddresses(address pool, address asset) external view returns (address aTokenAddress, address variableDebtTokenAddress)
```

Returns the token addresses of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| aTokenAddress | address | The AToken address of the reserve |
| variableDebtTokenAddress | address | The VariableDebtToken address of the reserve |

### getInterestRateStrategyAddress

```solidity
function getInterestRateStrategyAddress(address pool, address asset) external view returns (address irStrategyAddress)
```

Returns the address of the Interest Rate strategy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| irStrategyAddress | address | The address of the Interest Rate strategy |

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(address pool, address asset) external view returns (bool)
```

Returns whether the reserve has FlashLoans enabled or disabled

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if FlashLoans are enabled, false otherwise |

## MockPool

## ITimelock

_Contract module which acts as a timelocked controller. When set as the
owner of an `Ownable` smart contract, it enforces a timelock on all
`onlyOwner` maintenance operations. This gives time for users of the
controlled contract to exit before a potentially dangerous maintenance
operation is applied.

By default, this contract is self administered, meaning administration tasks
have to go through the timelock process. The proposer (resp executor) role
is in charge of proposing (resp executing) operations. A common use case is
to position this {TimelockController} as the owner of a smart contract, with
a multisig or a DAO as the sole proposer._

### OperationState

```solidity
enum OperationState {
  Unset,
  Waiting,
  Ready,
  Done
}
```

### TimelockInvalidOperationLength

```solidity
error TimelockInvalidOperationLength(uint256 targets, uint256 payloads, uint256 values)
```

_Mismatch between the parameters length for an operation call._

### TimelockInsufficientDelay

```solidity
error TimelockInsufficientDelay(uint256 delay, uint256 minDelay)
```

_The schedule operation doesn't meet the minimum delay._

### TimelockUnexpectedOperationState

```solidity
error TimelockUnexpectedOperationState(bytes32 operationId, bytes32 expectedStates)
```

_The current state of an operation is not as required.
The `expectedStates` is a bitmap with the bits enabled for each OperationState enum position
counting from right to left.

See {_encodeStateBitmap}._

### TimelockUnexecutedPredecessor

```solidity
error TimelockUnexecutedPredecessor(bytes32 predecessorId)
```

_The predecessor to an operation not yet done._

### TimelockUnauthorizedCaller

```solidity
error TimelockUnauthorizedCaller(address caller)
```

_The caller account is not authorized._

### CallScheduled

```solidity
event CallScheduled(bytes32 id, uint256 index, address target, uint256 value, bytes data, bytes32 predecessor, uint256 delay)
```

_Emitted when a call is scheduled as part of operation `id`._

### CallExecuted

```solidity
event CallExecuted(bytes32 id, uint256 index, address target, uint256 value, bytes data)
```

_Emitted when a call is performed as part of operation `id`._

### CallSalt

```solidity
event CallSalt(bytes32 id, bytes32 salt)
```

_Emitted when new proposal is scheduled with non-zero salt._

### Cancelled

```solidity
event Cancelled(bytes32 id)
```

_Emitted when operation `id` is cancelled._

### MinDelayChange

```solidity
event MinDelayChange(uint256 oldDuration, uint256 newDuration)
```

_Emitted when the minimum delay for future operations is modified._

## IPoolAddressesProvider

Defines the basic interface for a Pool Addresses Provider.

### MarketIdSet

```solidity
event MarketIdSet(string oldMarketId, string newMarketId)
```

_Emitted when the market identifier is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldMarketId | string | The old id of the market |
| newMarketId | string | The new id of the market |

### PoolUpdated

```solidity
event PoolUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the Pool |
| newAddress | address | The new address of the Pool |

### PoolConfiguratorUpdated

```solidity
event PoolConfiguratorUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool configurator is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolConfigurator |
| newAddress | address | The new address of the PoolConfigurator |

### PriceOracleUpdated

```solidity
event PriceOracleUpdated(address oldAddress, address newAddress)
```

_Emitted when the price oracle is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PriceOracle |
| newAddress | address | The new address of the PriceOracle |

### ACLManagerUpdated

```solidity
event ACLManagerUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL manager is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLManager |
| newAddress | address | The new address of the ACLManager |

### ACLAdminUpdated

```solidity
event ACLAdminUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL admin is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLAdmin |
| newAddress | address | The new address of the ACLAdmin |

### PoolDataProviderUpdated

```solidity
event PoolDataProviderUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool data provider is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolDataProvider |
| newAddress | address | The new address of the PoolDataProvider |

### ProxyCreated

```solidity
event ProxyCreated(bytes32 id, address proxyAddress, address implementationAddress)
```

_Emitted when a new proxy is created._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the proxy |
| proxyAddress | address | The address of the created proxy contract |
| implementationAddress | address | The address of the implementation contract |

### AddressSet

```solidity
event AddressSet(bytes32 id, address oldAddress, address newAddress)
```

_Emitted when a new non-proxied contract address is registered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| oldAddress | address | The address of the old contract |
| newAddress | address | The address of the new contract |

### AddressSetAsProxy

```solidity
event AddressSetAsProxy(bytes32 id, address proxyAddress, address oldImplementationAddress, address newImplementationAddress)
```

_Emitted when the implementation of the proxy registered with id is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| proxyAddress | address | The address of the proxy contract |
| oldImplementationAddress | address | The address of the old implementation contract |
| newImplementationAddress | address | The address of the new implementation contract |

### getMarketId

```solidity
function getMarketId() external view returns (string)
```

Returns the id of the Aave market to which this contract points to.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The market id |

### setMarketId

```solidity
function setMarketId(string newMarketId) external
```

Associates an id with a specific PoolAddressesProvider.

_This can be used to create an onchain registry of PoolAddressesProviders to
identify and validate multiple Aave markets._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The market id |

### getAddress

```solidity
function getAddress(bytes32 id) external view returns (address)
```

Returns an address by its identifier.

_The returned address might be an EOA or a contract, potentially proxied
It returns ZERO if there is no registered address with the given id_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the registered for the specified id |

### setAddressAsProxy

```solidity
function setAddressAsProxy(bytes32 id, address newImplementationAddress) external
```

General function to update the implementation of a proxy registered with
certain `id`. If there is no proxy registered, it will instantiate one and
set as implementation the `newImplementationAddress`.

_IMPORTANT Use this function carefully, only for ids that don't have an explicit
setter function, in order to avoid unexpected consequences_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newImplementationAddress | address | The address of the new implementation |

### setAddress

```solidity
function setAddress(bytes32 id, address newAddress) external
```

Sets an address for an id replacing the address saved in the addresses map.

_IMPORTANT Use this function carefully, as it will do a hard replacement_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newAddress | address | The address to set |

### getPool

```solidity
function getPool() external view returns (address)
```

Returns the address of the Pool proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Pool proxy address |

### setPoolImpl

```solidity
function setPoolImpl(address newPoolImpl) external
```

Updates the implementation of the Pool, or creates a proxy
setting the new `pool` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolImpl | address | The new Pool implementation |

### getPoolConfigurator

```solidity
function getPoolConfigurator() external view returns (address)
```

Returns the address of the PoolConfigurator proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The PoolConfigurator proxy address |

### setPoolConfiguratorImpl

```solidity
function setPoolConfiguratorImpl(address newPoolConfiguratorImpl) external
```

Updates the implementation of the PoolConfigurator, or creates a proxy
setting the new `PoolConfigurator` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolConfiguratorImpl | address | The new PoolConfigurator implementation |

### getPriceOracle

```solidity
function getPriceOracle() external view returns (address)
```

Returns the address of the price oracle.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracle |

### setPriceOracle

```solidity
function setPriceOracle(address newPriceOracle) external
```

Updates the address of the price oracle.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracle | address | The address of the new PriceOracle |

### getACLManager

```solidity
function getACLManager() external view returns (address)
```

Returns the address of the ACL manager.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACLManager |

### setACLManager

```solidity
function setACLManager(address newAclManager) external
```

Updates the address of the ACL manager.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclManager | address | The address of the new ACLManager |

### getACLAdmin

```solidity
function getACLAdmin() external view returns (address)
```

Returns the address of the ACL admin.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACL admin |

### setACLAdmin

```solidity
function setACLAdmin(address newAclAdmin) external
```

Updates the address of the ACL admin.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclAdmin | address | The address of the new ACL admin |

### getPoolDataProvider

```solidity
function getPoolDataProvider() external view returns (address)
```

Returns the address of the data provider.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the DataProvider |

### setPoolDataProvider

```solidity
function setPoolDataProvider(address newDataProvider) external
```

Updates the address of the data provider.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newDataProvider | address | The address of the new DataProvider |

## IPoolAddressesProviderRegistry

Defines the basic interface for an Aave Pool Addresses Provider Registry.

### AddressesProviderRegistered

```solidity
event AddressesProviderRegistered(address addressesProvider, uint256 id)
```

_Emitted when a new AddressesProvider is registered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the registered PoolAddressesProvider |
| id | uint256 | The id of the registered PoolAddressesProvider |

### AddressesProviderUnregistered

```solidity
event AddressesProviderUnregistered(address addressesProvider, uint256 id)
```

_Emitted when an AddressesProvider is unregistered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the unregistered PoolAddressesProvider |
| id | uint256 | The id of the unregistered PoolAddressesProvider |

### getAddressesProvidersList

```solidity
function getAddressesProvidersList() external view returns (address[])
```

Returns the list of registered addresses providers

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The list of addresses providers |

### getAddressesProviderIdByAddress

```solidity
function getAddressesProviderIdByAddress(address addressesProvider) external view returns (uint256)
```

Returns the id of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the PoolAddressesProvider |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The id of the PoolAddressesProvider or 0 if is not registered |

### getAddressesProviderAddressById

```solidity
function getAddressesProviderAddressById(uint256 id) external view returns (address)
```

Returns the address of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint256 | The id of the market |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PoolAddressesProvider with the given id or zero address if it is not registered |

### registerAddressesProvider

```solidity
function registerAddressesProvider(address provider, uint256 id) external
```

Registers an addresses provider

_The PoolAddressesProvider must not already be registered in the registry
The id must not be used by an already registered PoolAddressesProvider_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the new PoolAddressesProvider |
| id | uint256 | The id for the new PoolAddressesProvider, referring to the market it belongs to |

### unregisterAddressesProvider

```solidity
function unregisterAddressesProvider(address provider) external
```

Removes an addresses provider from the list of registered addresses providers

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The PoolAddressesProvider address |

## PoolAddressesProviderRegistry

Main registry of PoolAddressesProvider of Aave markets.

_Used for indexing purposes of Aave protocol's markets. The id assigned to a PoolAddressesProvider refers to the
market it is connected with, for example with `1` for the Aave main market and `2` for the next created._

### constructor

```solidity
constructor(address owner) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner address of this contract. |

### getAddressesProvidersList

```solidity
function getAddressesProvidersList() external view returns (address[])
```

Returns the list of registered addresses providers

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The list of addresses providers |

### registerAddressesProvider

```solidity
function registerAddressesProvider(address provider, uint256 id) external
```

Registers an addresses provider

_The PoolAddressesProvider must not already be registered in the registry
The id must not be used by an already registered PoolAddressesProvider_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the new PoolAddressesProvider |
| id | uint256 | The id for the new PoolAddressesProvider, referring to the market it belongs to |

### unregisterAddressesProvider

```solidity
function unregisterAddressesProvider(address provider) external
```

Removes an addresses provider from the list of registered addresses providers

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The PoolAddressesProvider address |

### getAddressesProviderIdByAddress

```solidity
function getAddressesProviderIdByAddress(address addressesProvider) external view returns (uint256)
```

Returns the id of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| addressesProvider | address | The address of the PoolAddressesProvider |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The id of the PoolAddressesProvider or 0 if is not registered |

### getAddressesProviderAddressById

```solidity
function getAddressesProviderAddressById(uint256 id) external view returns (address)
```

Returns the address of a registered PoolAddressesProvider

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint256 | The id of the market |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PoolAddressesProvider with the given id or zero address if it is not registered |

### _addToAddressesProvidersList

```solidity
function _addToAddressesProvidersList(address provider) internal
```

Adds the addresses provider address to the list.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the PoolAddressesProvider |

### _removeFromAddressesProvidersList

```solidity
function _removeFromAddressesProvidersList(address provider) internal
```

Removes the addresses provider address from the list.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | address | The address of the PoolAddressesProvider |

## IDelegationToken

Implements an interface for tokens with delegation COMP/UNI compatible

### delegate

```solidity
function delegate(address delegatee) external
```

Delegate voting power to a delegatee

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| delegatee | address | The address of the delegatee |

## IPriceOracleGetter

Interface for the Aave price oracle.

### BASE_CURRENCY

```solidity
function BASE_CURRENCY() external view returns (address)
```

Returns the base currency address

_Address 0x0 is reserved for USD as base currency._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Returns the base currency address. |

### BASE_CURRENCY_UNIT

```solidity
function BASE_CURRENCY_UNIT() external view returns (uint256)
```

Returns the base currency unit

_1 ether for ETH, 1e8 for USD._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | Returns the base currency unit. |

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

## IWETH

### deposit

```solidity
function deposit() external payable
```

### withdraw

```solidity
function withdraw(uint256) external
```

### approve

```solidity
function approve(address guy, uint256 wad) external returns (bool)
```

### transferFrom

```solidity
function transferFrom(address src, address dst, uint256 wad) external returns (bool)
```

## MintableDelegationERC20

_ERC20 minting logic with delegation_

### delegatee

```solidity
address delegatee
```

### constructor

```solidity
constructor(string name, string symbol) public
```

### mint

```solidity
function mint(uint256 value) public returns (bool)
```

_Function to mint tokens_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### delegate

```solidity
function delegate(address delegateeAddress) external
```

## WETH9Mocked

## PoolAddressesProvider

Main registry of addresses part of or connected to the protocol, including permissioned roles

_Acts as factory of proxies and admin of those, so with right to change its implementations
Owned by the Aave Governance_

### constructor

```solidity
constructor(string marketId, address owner) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| marketId | string | The identifier of the market. |
| owner | address | The owner address of this contract. |

### getMarketId

```solidity
function getMarketId() external view returns (string)
```

Returns the id of the Aave market to which this contract points to.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The market id |

### setMarketId

```solidity
function setMarketId(string newMarketId) external
```

Associates an id with a specific PoolAddressesProvider.

_This can be used to create an onchain registry of PoolAddressesProviders to
identify and validate multiple Aave markets._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The market id |

### getAddress

```solidity
function getAddress(bytes32 id) public view returns (address)
```

Returns an address by its identifier.

_The returned address might be an EOA or a contract, potentially proxied
It returns ZERO if there is no registered address with the given id_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the registered for the specified id |

### setAddress

```solidity
function setAddress(bytes32 id, address newAddress) external
```

Sets an address for an id replacing the address saved in the addresses map.

_IMPORTANT Use this function carefully, as it will do a hard replacement_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newAddress | address | The address to set |

### setAddressAsProxy

```solidity
function setAddressAsProxy(bytes32 id, address newImplementationAddress) external
```

General function to update the implementation of a proxy registered with
certain `id`. If there is no proxy registered, it will instantiate one and
set as implementation the `newImplementationAddress`.

_IMPORTANT Use this function carefully, only for ids that don't have an explicit
setter function, in order to avoid unexpected consequences_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newImplementationAddress | address | The address of the new implementation |

### getPool

```solidity
function getPool() external view returns (address)
```

Returns the address of the Pool proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Pool proxy address |

### setPoolImpl

```solidity
function setPoolImpl(address newPoolImpl) external
```

Updates the implementation of the Pool, or creates a proxy
setting the new `pool` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolImpl | address | The new Pool implementation |

### getPoolConfigurator

```solidity
function getPoolConfigurator() external view returns (address)
```

Returns the address of the PoolConfigurator proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The PoolConfigurator proxy address |

### setPoolConfiguratorImpl

```solidity
function setPoolConfiguratorImpl(address newPoolConfiguratorImpl) external
```

Updates the implementation of the PoolConfigurator, or creates a proxy
setting the new `PoolConfigurator` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolConfiguratorImpl | address | The new PoolConfigurator implementation |

### getPriceOracle

```solidity
function getPriceOracle() external view returns (address)
```

Returns the address of the price oracle.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracle |

### setPriceOracle

```solidity
function setPriceOracle(address newPriceOracle) external
```

Updates the address of the price oracle.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracle | address | The address of the new PriceOracle |

### getACLManager

```solidity
function getACLManager() external view returns (address)
```

Returns the address of the ACL manager.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACLManager |

### setACLManager

```solidity
function setACLManager(address newAclManager) external
```

Updates the address of the ACL manager.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclManager | address | The address of the new ACLManager |

### getACLAdmin

```solidity
function getACLAdmin() external view returns (address)
```

Returns the address of the ACL admin.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACL admin |

### setACLAdmin

```solidity
function setACLAdmin(address newAclAdmin) external
```

Updates the address of the ACL admin.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclAdmin | address | The address of the new ACL admin |

### getPoolDataProvider

```solidity
function getPoolDataProvider() external view returns (address)
```

Returns the address of the data provider.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the DataProvider |

### setPoolDataProvider

```solidity
function setPoolDataProvider(address newDataProvider) external
```

Updates the address of the data provider.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newDataProvider | address | The address of the new DataProvider |

### _updateImpl

```solidity
function _updateImpl(bytes32 id, address newAddress) internal
```

Internal function to update the implementation of a specific proxied component of the protocol.

_If there is no proxy registered with the given identifier, it creates the proxy setting `newAddress`
  as implementation and calls the initialize() function on the proxy
If there is already a proxy registered, it just updates the implementation to `newAddress` and
  calls the initialize() function via upgradeToAndCall() in the proxy_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id of the proxy to be updated |
| newAddress | address | The address of the new implementation |

### _setMarketId

```solidity
function _setMarketId(string newMarketId) internal
```

Updates the identifier of the Aave market.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The new id of the market |

### _getProxyImplementation

```solidity
function _getProxyImplementation(bytes32 id) internal returns (address)
```

Returns the the implementation contract of the proxy contract by its identifier.

_It returns ZERO if there is no registered address with the given id
It reverts if the registered address with the given id is not `InitializableImmutableAdminUpgradeabilityProxy`_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation contract |

## GPv2SafeERC20

_Gas-efficient version of Openzeppelin's SafeERC20 contract._

### safeTransfer

```solidity
function safeTransfer(contract IERC20 token, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transfer` that reverts
also when the token returns `false`._

### safeTransferFrom

```solidity
function safeTransferFrom(contract IERC20 token, address from, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transferFrom` that
reverts also when the token returns `false`._

## AccessControl

_Contract module that allows children to implement role-based access
control mechanisms. This is a lightweight version that doesn't allow enumerating role
members except through off-chain means by accessing the contract event logs. Some
applications may benefit from on-chain enumerability, for those cases see
{AccessControlEnumerable}.

Roles are referred to by their `bytes32` identifier. These should be exposed
in the external API and be unique. The best way to achieve this is by
using `public constant` hash digests:

```
bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
```

Roles can be used to represent a set of permissions. To restrict access to a
function call, use {hasRole}:

```
function foo() public {
    require(hasRole(MY_ROLE, msg.sender));
    ...
}
```

Roles can be granted and revoked dynamically via the {grantRole} and
{revokeRole} functions. Each role has an associated admin role, and only
accounts that have a role's admin role can call {grantRole} and {revokeRole}.

By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
that only accounts with this role will be able to grant or revoke other
roles. More complex role relationships can be created by using
{_setRoleAdmin}.

WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
grant and revoke this role. Extra precautions should be taken to secure
accounts that have been granted it._

### RoleData

```solidity
struct RoleData {
  mapping(address => bool) members;
  bytes32 adminRole;
}
```

### DEFAULT_ADMIN_ROLE

```solidity
bytes32 DEFAULT_ADMIN_ROLE
```

### onlyRole

```solidity
modifier onlyRole(bytes32 role)
```

_Modifier that checks that an account has a specific role. Reverts
with a standardized message including the required role.

The format of the revert reason is given by the following regular expression:

 /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/

_Available since v4.1.__

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### hasRole

```solidity
function hasRole(bytes32 role, address account) public view returns (bool)
```

_Returns `true` if `account` has been granted `role`._

### _checkRole

```solidity
function _checkRole(bytes32 role, address account) internal view
```

_Revert with a standard message if `account` is missing `role`.

The format of the revert reason is given by the following regular expression:

 /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/_

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) public view returns (bytes32)
```

_Returns the admin role that controls `role`. See {grantRole} and
{revokeRole}.

To change a role's admin, use {_setRoleAdmin}._

### grantRole

```solidity
function grantRole(bytes32 role, address account) public virtual
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event.

Requirements:

- the caller must have ``role``'s admin role._

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) public virtual
```

_Revokes `role` from `account`.

If `account` had been granted `role`, emits a {RoleRevoked} event.

Requirements:

- the caller must have ``role``'s admin role._

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) public virtual
```

_Revokes `role` from the calling account.

Roles are often managed via {grantRole} and {revokeRole}: this function's
purpose is to provide a mechanism for accounts to lose their privileges
if they are compromised (such as when a trusted device is misplaced).

If the calling account had been granted `role`, emits a {RoleRevoked}
event.

Requirements:

- the caller must be `account`._

### _setupRole

```solidity
function _setupRole(bytes32 role, address account) internal virtual
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event. Note that unlike {grantRole}, this function doesn't perform any
checks on the calling account.

[WARNING]
====
This function should only be called from the constructor when setting
up the initial roles for the system.

Using this function in any other way is effectively circumventing the admin
system imposed by {AccessControl}.
====_

### _setRoleAdmin

```solidity
function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual
```

_Sets `adminRole` as ``role``'s admin role.

Emits a {RoleAdminChanged} event._

## Address

_Collection of functions related to the address type_

### isContract

```solidity
function isContract(address account) internal view returns (bool)
```

_Returns true if `account` is a contract.

[IMPORTANT]
====
It is unsafe to assume that an address for which this function returns
false is an externally-owned account (EOA) and not a contract.

Among others, `isContract` will return false for the following
types of addresses:

 - an externally-owned account
 - a contract in construction
 - an address where a contract will be created
 - an address where a contract lived, but was destroyed
====_

### sendValue

```solidity
function sendValue(address payable recipient, uint256 amount) internal
```

_Replacement for Solidity's `transfer`: sends `amount` wei to
`recipient`, forwarding all available gas and reverting on errors.

https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
of certain opcodes, possibly making contracts go over the 2300 gas limit
imposed by `transfer`, making them unable to receive funds via
`transfer`. {sendValue} removes this limitation.

https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].

IMPORTANT: because control is transferred to `recipient`, care must be
taken to not create reentrancy vulnerabilities. Consider using
{ReentrancyGuard} or the
https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern]._

### functionCall

```solidity
function functionCall(address target, bytes data) internal returns (bytes)
```

_Performs a Solidity function call using a low level `call`. A
plain `call` is an unsafe replacement for a function call: use this
function instead.

If `target` reverts with a revert reason, it is bubbled up by this
function (like regular Solidity function calls).

Returns the raw returned data. To convert to the expected return value,
use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].

Requirements:

- `target` must be a contract.
- calling `target` with `data` must not revert.

_Available since v3.1.__

### functionCall

```solidity
function functionCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
`errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but also transferring `value` wei to `target`.

Requirements:

- the calling contract must have an ETH balance of at least `value`.
- the called Solidity function must be `payable`.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
with `errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data, string errorMessage) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### verifyCallResult

```solidity
function verifyCallResult(bool success, bytes returndata, string errorMessage) internal pure returns (bytes)
```

_Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
revert reason using the provided one.

_Available since v4.3.__

## Context

### _msgSender

```solidity
function _msgSender() internal view virtual returns (address payable)
```

### _msgData

```solidity
function _msgData() internal view virtual returns (bytes)
```

## ERC165

_Implementation of the {IERC165} interface.

Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
for the additional interface id that will be supported. For example:

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
}
```

Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC20

_Implementation of the {IERC20} interface.

This implementation is agnostic to the way tokens are created. This means
that a supply mechanism has to be added in a derived contract using {_mint}.
For a generic mechanism see {ERC20PresetMinterPauser}.

TIP: For a detailed writeup see our guide
https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
to implement supply mechanisms].

We have followed general OpenZeppelin guidelines: functions revert instead
of returning `false` on failure. This behavior is nonetheless conventional
and does not conflict with the expectations of ERC20 applications.

Additionally, an {Approval} event is emitted on calls to {transferFrom}.
This allows applications to reconstruct the allowance for all accounts just
by listening to said events. Other implementations of the EIP may not emit
these events, as it isn't required by the specification.

Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
functions have been added to mitigate the well-known issues around setting
allowances. See {IERC20-approve}._

### constructor

```solidity
constructor(string name, string symbol) public
```

_Sets the values for {name} and {symbol}, initializes {decimals} with
a default value of 18.

To select a different value for {decimals}, use {_setupDecimals}.

All three of these values are immutable: they can only be set once during
construction._

### name

```solidity
function name() public view returns (string)
```

_Returns the name of the token._

### symbol

```solidity
function symbol() public view returns (string)
```

_Returns the symbol of the token, usually a shorter version of the
name._

### decimals

```solidity
function decimals() public view returns (uint8)
```

_Returns the number of decimals used to get its user representation.
For example, if `decimals` equals `2`, a balance of `505` tokens should
be displayed to a user as `5,05` (`505 / 10 ** 2`).

Tokens usually opt for a value of 18, imitating the relationship between
Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
called.

NOTE: This information is only used for _display_ purposes: it in
no way affects any of the arithmetic of the contract, including
{IERC20-balanceOf} and {IERC20-transfer}._

### totalSupply

```solidity
function totalSupply() public view returns (uint256)
```

_See {IERC20-totalSupply}._

### balanceOf

```solidity
function balanceOf(address account) public view returns (uint256)
```

_See {IERC20-balanceOf}._

### transfer

```solidity
function transfer(address recipient, uint256 amount) public virtual returns (bool)
```

_See {IERC20-transfer}.

Requirements:

- `recipient` cannot be the zero address.
- the caller must have a balance of at least `amount`._

### allowance

```solidity
function allowance(address owner, address spender) public view virtual returns (uint256)
```

_See {IERC20-allowance}._

### approve

```solidity
function approve(address spender, uint256 amount) public virtual returns (bool)
```

_See {IERC20-approve}.

Requirements:

- `spender` cannot be the zero address._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) public virtual returns (bool)
```

_See {IERC20-transferFrom}.

Emits an {Approval} event indicating the updated allowance. This is not
required by the EIP. See the note at the beginning of {ERC20};

Requirements:
- `sender` and `recipient` cannot be the zero address.
- `sender` must have a balance of at least `amount`.
- the caller must have allowance for ``sender``'s tokens of at least
`amount`._

### increaseAllowance

```solidity
function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool)
```

_Atomically increases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {IERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address._

### decreaseAllowance

```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool)
```

_Atomically decreases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {IERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address.
- `spender` must have allowance for the caller of at least
`subtractedValue`._

### _transfer

```solidity
function _transfer(address sender, address recipient, uint256 amount) internal virtual
```

_Moves tokens `amount` from `sender` to `recipient`.

This is internal function is equivalent to {transfer}, and can be used to
e.g. implement automatic token fees, slashing mechanisms, etc.

Emits a {Transfer} event.

Requirements:

- `sender` cannot be the zero address.
- `recipient` cannot be the zero address.
- `sender` must have a balance of at least `amount`._

### _mint

```solidity
function _mint(address account, uint256 amount) internal virtual
```

_Creates `amount` tokens and assigns them to `account`, increasing
the total supply.

Emits a {Transfer} event with `from` set to the zero address.

Requirements

- `to` cannot be the zero address._

### _burn

```solidity
function _burn(address account, uint256 amount) internal virtual
```

_Destroys `amount` tokens from `account`, reducing the
total supply.

Emits a {Transfer} event with `to` set to the zero address.

Requirements

- `account` cannot be the zero address.
- `account` must have at least `amount` tokens._

### _approve

```solidity
function _approve(address owner, address spender, uint256 amount) internal virtual
```

_Sets `amount` as the allowance of `spender` over the `owner`s tokens.

This is internal function is equivalent to `approve`, and can be used to
e.g. set automatic allowances for certain subsystems, etc.

Emits an {Approval} event.

Requirements:

- `owner` cannot be the zero address.
- `spender` cannot be the zero address._

### _setupDecimals

```solidity
function _setupDecimals(uint8 decimals_) internal
```

_Sets {decimals} to a value other than the default one of 18.

WARNING: This function should only be called from the constructor. Most
applications that interact with token contracts will not expect
{decimals} to ever change, and may work incorrectly if it does._

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual
```

_Hook that is called before any transfer of tokens. This includes
minting and burning.

Calling conditions:

- when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
will be to transferred to `to`.
- when `from` is zero, `amount` tokens will be minted for `to`.
- when `to` is zero, `amount` of ``from``'s tokens will be burned.
- `from` and `to` are never both zero.

To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]._

## IAccessControl

_External interface of AccessControl declared to support ERC165 detection._

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 role, bytes32 previousAdminRole, bytes32 newAdminRole)
```

_Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`

`DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
{RoleAdminChanged} not being emitted signaling this.

_Available since v3.1.__

### RoleGranted

```solidity
event RoleGranted(bytes32 role, address account, address sender)
```

_Emitted when `account` is granted `role`.

`sender` is the account that originated the contract call, an admin role
bearer except when using {AccessControl-_setupRole}._

### RoleRevoked

```solidity
event RoleRevoked(bytes32 role, address account, address sender)
```

_Emitted when `account` is revoked `role`.

`sender` is the account that originated the contract call:
  - if using `revokeRole`, it is the admin role bearer
  - if using `renounceRole`, it is the role bearer (i.e. `account`)_

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```

_Returns `true` if `account` has been granted `role`._

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```

_Returns the admin role that controls `role`. See {grantRole} and
{revokeRole}.

To change a role's admin, use {AccessControl-_setRoleAdmin}._

### grantRole

```solidity
function grantRole(bytes32 role, address account) external
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event.

Requirements:

- the caller must have ``role``'s admin role._

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external
```

_Revokes `role` from `account`.

If `account` had been granted `role`, emits a {RoleRevoked} event.

Requirements:

- the caller must have ``role``'s admin role._

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external
```

_Revokes `role` from the calling account.

Roles are often managed via {grantRole} and {revokeRole}: this function's
purpose is to provide a mechanism for accounts to lose their privileges
if they are compromised (such as when a trusted device is misplaced).

If the calling account had been granted `role`, emits a {RoleRevoked}
event.

Requirements:

- the caller must be `account`._

## IERC165

_Interface of the ERC165 standard, as defined in the
https://eips.ethereum.org/EIPS/eip-165[EIP].

Implementers can declare support of contract interfaces, which can then be
queried by others ({ERC165Checker}).

For an implementation, see {ERC165}._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```

_Returns true if this contract implements the interface defined by
`interfaceId`. See the corresponding
https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
to learn more about how these ids are created.

This function call must use less than 30 000 gas._

## IERC20

_Interface of the ERC20 standard as defined in the EIP._

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

_Returns the amount of tokens in existence._

### balanceOf

```solidity
function balanceOf(address account) external view returns (uint256)
```

_Returns the amount of tokens owned by `account`._

### transfer

```solidity
function transfer(address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from the caller's account to `recipient`.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### allowance

```solidity
function allowance(address owner, address spender) external view returns (uint256)
```

_Returns the remaining number of tokens that `spender` will be
allowed to spend on behalf of `owner` through {transferFrom}. This is
zero by default.

This value changes when {approve} or {transferFrom} are called._

### approve

```solidity
function approve(address spender, uint256 amount) external returns (bool)
```

_Sets `amount` as the allowance of `spender` over the caller's tokens.

Returns a boolean value indicating whether the operation succeeded.

IMPORTANT: Beware that changing an allowance with this method brings the risk
that someone may use both the old and the new allowance by unfortunate
transaction ordering. One possible solution to mitigate this race
condition is to first reduce the spender's allowance to 0 and set the
desired value afterwards:
https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

Emits an {Approval} event._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from `sender` to `recipient` using the
allowance mechanism. `amount` is then deducted from the caller's
allowance.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

_Emitted when `value` tokens are moved from one account (`from`) to
another (`to`).

Note that `value` may be zero._

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

_Emitted when the allowance of a `spender` for an `owner` is set by
a call to {approve}. `value` is the new allowance._

## IERC20Detailed

### name

```solidity
function name() external view returns (string)
```

### symbol

```solidity
function symbol() external view returns (string)
```

### decimals

```solidity
function decimals() external view returns (uint8)
```

## Ownable

_Contract module which provides a basic access control mechanism, where
there is an account (an owner) that can be granted exclusive access to
specific functions.

By default, the owner account will be the one that deploys the contract. This
can later be changed with {transferOwnership}.

This module is used through inheritance. It will make available the modifier
`onlyOwner`, which can be applied to your functions to restrict their use to
the owner._

### OwnershipTransferred

```solidity
event OwnershipTransferred(address previousOwner, address newOwner)
```

### constructor

```solidity
constructor() public
```

_Initializes the contract setting the deployer as the initial owner._

### owner

```solidity
function owner() public view returns (address)
```

_Returns the address of the current owner._

### onlyOwner

```solidity
modifier onlyOwner()
```

_Throws if called by any account other than the owner._

### renounceOwnership

```solidity
function renounceOwnership() public virtual
```

_Leaves the contract without owner. It will not be possible to call
`onlyOwner` functions anymore. Can only be called by the current owner.

NOTE: Renouncing ownership will leave the contract without an owner,
thereby removing any functionality that is only available to the owner._

### transferOwnership

```solidity
function transferOwnership(address newOwner) public virtual
```

_Transfers ownership of the contract to a new account (`newOwner`).
Can only be called by the current owner._

## SafeCast

_Wrappers over Solidity's uintXX/intXX casting operators with added overflow
checks.

Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
easily result in undesired exploitation or bugs, since developers usually
assume that overflows raise errors. `SafeCast` restores this intuition by
reverting the transaction when such an operation overflows.

Using this library instead of the unchecked operations eliminates an entire
class of bugs, so it's recommended to use it always.

Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
all math on `uint256` and `int256` and then downcasting._

### toUint224

```solidity
function toUint224(uint256 value) internal pure returns (uint224)
```

_Returns the downcasted uint224 from uint256, reverting on
overflow (when the input is greater than largest uint224).

Counterpart to Solidity's `uint224` operator.

Requirements:

- input must fit into 224 bits_

### toUint128

```solidity
function toUint128(uint256 value) internal pure returns (uint128)
```

_Returns the downcasted uint128 from uint256, reverting on
overflow (when the input is greater than largest uint128).

Counterpart to Solidity's `uint128` operator.

Requirements:

- input must fit into 128 bits_

### toUint96

```solidity
function toUint96(uint256 value) internal pure returns (uint96)
```

_Returns the downcasted uint96 from uint256, reverting on
overflow (when the input is greater than largest uint96).

Counterpart to Solidity's `uint96` operator.

Requirements:

- input must fit into 96 bits_

### toUint64

```solidity
function toUint64(uint256 value) internal pure returns (uint64)
```

_Returns the downcasted uint64 from uint256, reverting on
overflow (when the input is greater than largest uint64).

Counterpart to Solidity's `uint64` operator.

Requirements:

- input must fit into 64 bits_

### toUint32

```solidity
function toUint32(uint256 value) internal pure returns (uint32)
```

_Returns the downcasted uint32 from uint256, reverting on
overflow (when the input is greater than largest uint32).

Counterpart to Solidity's `uint32` operator.

Requirements:

- input must fit into 32 bits_

### toUint16

```solidity
function toUint16(uint256 value) internal pure returns (uint16)
```

_Returns the downcasted uint16 from uint256, reverting on
overflow (when the input is greater than largest uint16).

Counterpart to Solidity's `uint16` operator.

Requirements:

- input must fit into 16 bits_

### toUint8

```solidity
function toUint8(uint256 value) internal pure returns (uint8)
```

_Returns the downcasted uint8 from uint256, reverting on
overflow (when the input is greater than largest uint8).

Counterpart to Solidity's `uint8` operator.

Requirements:

- input must fit into 8 bits._

### toUint256

```solidity
function toUint256(int256 value) internal pure returns (uint256)
```

_Converts a signed int256 into an unsigned uint256.

Requirements:

- input must be greater than or equal to 0._

### toInt128

```solidity
function toInt128(int256 value) internal pure returns (int128)
```

_Returns the downcasted int128 from int256, reverting on
overflow (when the input is less than smallest int128 or
greater than largest int128).

Counterpart to Solidity's `int128` operator.

Requirements:

- input must fit into 128 bits

_Available since v3.1.__

### toInt64

```solidity
function toInt64(int256 value) internal pure returns (int64)
```

_Returns the downcasted int64 from int256, reverting on
overflow (when the input is less than smallest int64 or
greater than largest int64).

Counterpart to Solidity's `int64` operator.

Requirements:

- input must fit into 64 bits

_Available since v3.1.__

### toInt32

```solidity
function toInt32(int256 value) internal pure returns (int32)
```

_Returns the downcasted int32 from int256, reverting on
overflow (when the input is less than smallest int32 or
greater than largest int32).

Counterpart to Solidity's `int32` operator.

Requirements:

- input must fit into 32 bits

_Available since v3.1.__

### toInt16

```solidity
function toInt16(int256 value) internal pure returns (int16)
```

_Returns the downcasted int16 from int256, reverting on
overflow (when the input is less than smallest int16 or
greater than largest int16).

Counterpart to Solidity's `int16` operator.

Requirements:

- input must fit into 16 bits

_Available since v3.1.__

### toInt8

```solidity
function toInt8(int256 value) internal pure returns (int8)
```

_Returns the downcasted int8 from int256, reverting on
overflow (when the input is less than smallest int8 or
greater than largest int8).

Counterpart to Solidity's `int8` operator.

Requirements:

- input must fit into 8 bits.

_Available since v3.1.__

### toInt256

```solidity
function toInt256(uint256 value) internal pure returns (int256)
```

_Converts an unsigned uint256 into a signed int256.

Requirements:

- input must be less than or equal to maxInt256._

## SafeERC20

_Wrappers around ERC20 operations that throw on failure (when the token
contract returns false). Tokens that return no value (and instead revert or
throw on failure) are also supported, non-reverting calls are assumed to be
successful.
To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
which allows you to call the safe operations as `token.safeTransfer(...)`, etc._

### safeTransfer

```solidity
function safeTransfer(contract IERC20 token, address to, uint256 value) internal
```

### safeTransferFrom

```solidity
function safeTransferFrom(contract IERC20 token, address from, address to, uint256 value) internal
```

### safeApprove

```solidity
function safeApprove(contract IERC20 token, address spender, uint256 value) internal
```

_Deprecated. This function has issues similar to the ones found in
{IERC20-approve}, and its usage is discouraged.

Whenever possible, use {safeIncreaseAllowance} and
{safeDecreaseAllowance} instead._

### safeIncreaseAllowance

```solidity
function safeIncreaseAllowance(contract IERC20 token, address spender, uint256 value) internal
```

### safeDecreaseAllowance

```solidity
function safeDecreaseAllowance(contract IERC20 token, address spender, uint256 value) internal
```

## SafeMath

Contains methods for doing math operations that revert on overflow or underflow for minimal gas cost

### add

```solidity
function add(uint256 x, uint256 y) internal pure returns (uint256 z)
```

Returns x + y, reverts if sum overflows uint256

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| x | uint256 | The augend |
| y | uint256 | The addend |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| z | uint256 | The sum of x and y |

### sub

```solidity
function sub(uint256 x, uint256 y) internal pure returns (uint256 z)
```

Returns x - y, reverts if underflows

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| x | uint256 | The minuend |
| y | uint256 | The subtrahend |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| z | uint256 | The difference of x and y |

### sub

```solidity
function sub(uint256 x, uint256 y, string message) internal pure returns (uint256 z)
```

Returns x - y, reverts if underflows

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| x | uint256 | The minuend |
| y | uint256 | The subtrahend |
| message | string | The error msg |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| z | uint256 | The difference of x and y |

### mul

```solidity
function mul(uint256 x, uint256 y) internal pure returns (uint256 z)
```

Returns x * y, reverts if overflows

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| x | uint256 | The multiplicand |
| y | uint256 | The multiplier |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| z | uint256 | The product of x and y |

### div

```solidity
function div(uint256 x, uint256 y) internal pure returns (uint256 z)
```

Returns x / y, reverts if overflows - no specific check, solidity reverts on division by 0

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| x | uint256 | The numerator |
| y | uint256 | The denominator |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| z | uint256 | The product of x and y |

## Strings

_String operations._

### toString

```solidity
function toString(uint256 value) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` decimal representation._

### toHexString

```solidity
function toHexString(uint256 value) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` hexadecimal representation._

### toHexString

```solidity
function toHexString(uint256 value, uint256 length) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length._

## AdminUpgradeabilityProxy

_Extends from BaseAdminUpgradeabilityProxy with a constructor for
initializing the implementation, admin, and init data._

### constructor

```solidity
constructor(address _logic, address _admin, bytes _data) public payable
```

Contract constructor.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _logic | address | address of the initial implementation. |
| _admin | address | Address of the proxy administrator. |
| _data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

### _willFallback

```solidity
function _willFallback() internal
```

_Only fall back when the sender is not the admin._

## BaseAdminUpgradeabilityProxy

_This contract combines an upgradeability proxy with an authorization
mechanism for administrative tasks.
All external functions in this contract must be guarded by the
`ifAdmin` modifier. See ethereum/solidity#3864 for a Solidity
feature proposal that would enable this to be done automatically._

### AdminChanged

```solidity
event AdminChanged(address previousAdmin, address newAdmin)
```

_Emitted when the administration has been transferred._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| previousAdmin | address | Address of the previous admin. |
| newAdmin | address | Address of the new admin. |

### ADMIN_SLOT

```solidity
bytes32 ADMIN_SLOT
```

_Storage slot with the admin of the contract.
This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1, and is
validated in the constructor._

### ifAdmin

```solidity
modifier ifAdmin()
```

_Modifier to check whether the `msg.sender` is the admin.
If it is, it will run the function. Otherwise, it will delegate the call
to the implementation._

### admin

```solidity
function admin() external returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the proxy admin. |

### implementation

```solidity
function implementation() external returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation. |

### changeAdmin

```solidity
function changeAdmin(address newAdmin) external
```

_Changes the admin of the proxy.
Only the current admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAdmin | address | Address to transfer proxy administration to. |

### upgradeTo

```solidity
function upgradeTo(address newImplementation) external
```

_Upgrade the backing implementation of the proxy.
Only the admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

### upgradeToAndCall

```solidity
function upgradeToAndCall(address newImplementation, bytes data) external payable
```

_Upgrade the backing implementation of the proxy and call a function
on the new implementation.
This is useful to initialize the proxied contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |
| data | bytes | Data to send as msg.data in the low level call. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. |

### _admin

```solidity
function _admin() internal view returns (address adm)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| adm | address | The admin slot. |

### _setAdmin

```solidity
function _setAdmin(address newAdmin) internal
```

_Sets the address of the proxy admin._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAdmin | address | Address of the new proxy admin. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

_Only fall back when the sender is not the admin._

## BaseUpgradeabilityProxy

_This contract implements a proxy that allows to change the
implementation address to which it will delegate.
Such a change is called an implementation upgrade._

### Upgraded

```solidity
event Upgraded(address implementation)
```

_Emitted when the implementation is upgraded._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | Address of the new implementation. |

### IMPLEMENTATION_SLOT

```solidity
bytes32 IMPLEMENTATION_SLOT
```

_Storage slot with the address of the current implementation.
This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1, and is
validated in the constructor._

### _implementation

```solidity
function _implementation() internal view returns (address impl)
```

_Returns the current implementation._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| impl | address | Address of the current implementation |

### _upgradeTo

```solidity
function _upgradeTo(address newImplementation) internal
```

_Upgrades the proxy to a new implementation._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

### _setImplementation

```solidity
function _setImplementation(address newImplementation) internal
```

_Sets the implementation address of the proxy._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | Address of the new implementation. |

## Initializable

_Helper contract to support initializer functions. To use it, replace
the constructor with a function that has the `initializer` modifier.
WARNING: Unlike constructors, initializer functions must be manually
invoked. This applies both to deploying an Initializable contract, as well
as extending an Initializable contract via inheritance.
WARNING: When used with inheritance, manual care must be taken to not invoke
a parent initializer twice, or ensure that all initializers are idempotent,
because this is not dealt with automatically as with constructors._

### initializer

```solidity
modifier initializer()
```

_Modifier to use in the initializer function of a contract._

## InitializableAdminUpgradeabilityProxy

_Extends from BaseAdminUpgradeabilityProxy with an initializer for
initializing the implementation, admin, and init data._

### initialize

```solidity
function initialize(address logic, address admin, bytes data) public payable
```

Contract initializer.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| logic | address | address of the initial implementation. |
| admin | address | Address of the proxy administrator. |
| data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

### _willFallback

```solidity
function _willFallback() internal
```

_Only fall back when the sender is not the admin._

## InitializableUpgradeabilityProxy

_Extends BaseUpgradeabilityProxy with an initializer for initializing
implementation and init data._

### initialize

```solidity
function initialize(address _logic, bytes _data) public payable
```

_Contract initializer._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _logic | address | Address of the initial implementation. |
| _data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

## Proxy

_Implements delegation of calls to other contracts, with proper
forwarding of return values and bubbling of failures.
It defines a fallback function that delegates all calls to the address
returned by the abstract _implementation() internal function._

### fallback

```solidity
fallback() external payable
```

_Fallback function.
Will run if no other function in the contract matches the call data.
Implemented entirely in `_fallback`._

### _implementation

```solidity
function _implementation() internal view virtual returns (address)
```

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Address of the implementation. |

### _delegate

```solidity
function _delegate(address implementation) internal
```

_Delegates execution to an implementation contract.
This is a low level function that doesn't return to its internal call site.
It will return to the external caller whatever the implementation returns._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | Address to delegate. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

_Function that is run as the first thing in the fallback function.
Can be redefined in derived contracts to add functionality.
Redefinitions must call super._willFallback()._

### _fallback

```solidity
function _fallback() internal
```

_fallback implementation.
Extracted to enable manual triggering._

## UpgradeabilityProxy

_Extends BaseUpgradeabilityProxy with a constructor for initializing
implementation and init data._

### constructor

```solidity
constructor(address _logic, bytes _data) public payable
```

_Contract constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _logic | address | Address of the initial implementation. |
| _data | bytes | Data to send as msg.data to the implementation to initialize the proxied contract. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. This parameter is optional, if no data is given the initialization call to proxied contract will be skipped. |

## WETH9

### name

```solidity
string name
```

### symbol

```solidity
string symbol
```

### decimals

```solidity
uint8 decimals
```

### Approval

```solidity
event Approval(address src, address guy, uint256 wad)
```

### Transfer

```solidity
event Transfer(address src, address dst, uint256 wad)
```

### Deposit

```solidity
event Deposit(address dst, uint256 wad)
```

### Withdrawal

```solidity
event Withdrawal(address src, uint256 wad)
```

### balanceOf

```solidity
mapping(address => uint256) balanceOf
```

### allowance

```solidity
mapping(address => mapping(address => uint256)) allowance
```

### receive

```solidity
receive() external payable
```

### deposit

```solidity
function deposit() public payable
```

### withdraw

```solidity
function withdraw(uint256 wad) public
```

### totalSupply

```solidity
function totalSupply() public view returns (uint256)
```

### approve

```solidity
function approve(address guy, uint256 wad) public returns (bool)
```

### transfer

```solidity
function transfer(address dst, uint256 wad) public returns (bool)
```

### transferFrom

```solidity
function transferFrom(address src, address dst, uint256 wad) public returns (bool)
```

## FlashLoanReceiverBase

Base contract to develop a flashloan-receiver contract.

### ADDRESSES_PROVIDER

```solidity
contract IPoolAddressesProvider ADDRESSES_PROVIDER
```

### POOL

```solidity
contract IPool POOL
```

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) internal
```

## FlashLoanSimpleReceiverBase

Base contract to develop a flashloan-receiver contract.

### ADDRESSES_PROVIDER

```solidity
contract IPoolAddressesProvider ADDRESSES_PROVIDER
```

### POOL

```solidity
contract IPool POOL
```

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) internal
```

## IFlashLoanReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed assets

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The addresses of the flash-borrowed assets |
| amounts | uint256[] | The amounts of the flash-borrowed assets |
| premiums | uint256[] | The fee of each flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

## IFlashLoanSimpleReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed asset

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the flash-borrowed asset |
| amount | uint256 | The amount of the flash-borrowed asset |
| premium | uint256 | The fee of the flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

## IAaveOracle

Defines the basic interface for the Aave Oracle

### BaseCurrencySet

```solidity
event BaseCurrencySet(address baseCurrency, uint256 baseCurrencyUnit)
```

_Emitted after the base currency is set_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| baseCurrency | address | The base currency of used for price quotes |
| baseCurrencyUnit | uint256 | The unit of the base currency |

### AssetSourceUpdated

```solidity
event AssetSourceUpdated(address asset, address source)
```

_Emitted after the price source of an asset is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |
| source | address | The price source of the asset |

### FallbackOracleUpdated

```solidity
event FallbackOracleUpdated(address fallbackOracle)
```

_Emitted after the address of fallback oracle is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fallbackOracle | address | The address of the fallback oracle |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### setAssetSources

```solidity
function setAssetSources(address pool, address[] assets, address[] sources) external
```

Sets or replaces price sources of assets

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| assets | address[] | The addresses of the assets |
| sources | address[] | The addresses of the price sources |

### setFallbackOracle

```solidity
function setFallbackOracle(address pool, address fallbackOracle) external
```

Sets the fallback oracle

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| fallbackOracle | address | The address of the fallback oracle |

### getAssetsPrices

```solidity
function getAssetsPrices(address pool, address[] assets) external view returns (uint256[])
```

Returns a list of prices from a list of assets addresses

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| assets | address[] | The list of assets addresses |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256[] | The prices of the given assets |

### getSourceOfAsset

```solidity
function getSourceOfAsset(address pool, address asset) external view returns (address)
```

Returns the address of the source for an asset address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address |  |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the source |

### getFallbackOracle

```solidity
function getFallbackOracle(address pool) external view returns (address)
```

Returns the address of the fallback oracle

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the fallback oracle |

## ICreditDelegationToken

Defines the basic interface for a token supporting credit delegation.

### BorrowAllowanceDelegated

```solidity
event BorrowAllowanceDelegated(address fromUser, address toUser, address asset, uint256 amount)
```

_Emitted on `approveDelegation` and `borrowAllowance_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromUser | address | The address of the delegator |
| toUser | address | The address of the delegatee |
| asset | address | The address of the delegated asset |
| amount | uint256 | The amount being delegated |

### approveDelegation

```solidity
function approveDelegation(address delegatee, uint256 amount) external
```

Delegates borrowing power to a user on the specific debt token.
Delegation will still respect the liquidation constraints (even if delegated, a
delegatee cannot force a delegator HF to go below 1)

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| delegatee | address | The address receiving the delegated borrowing power |
| amount | uint256 | The maximum amount being delegated. |

### borrowAllowance

```solidity
function borrowAllowance(address fromUser, address toUser) external view returns (uint256)
```

Returns the borrow allowance of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromUser | address | The user to giving allowance |
| toUser | address | The user to give allowance to |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The current allowance of `toUser` |

## IPriceOracle

Defines the basic interface for a Price oracle.

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

### setAssetPrice

```solidity
function setAssetPrice(address asset, uint256 price) external
```

Set the price of the asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |
| price | uint256 | The price of the asset |

## ISequencerOracle

Defines the basic interface for a Sequencer oracle.

### latestRoundData

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
```

Returns the health status of the sequencer.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| roundId | uint80 | The round ID from the aggregator for which the data was retrieved combined with a phase to ensure that round IDs get larger as time moves forward. |
| answer | int256 | The answer for the latest round: 0 if the sequencer is up, 1 if it is down. |
| startedAt | uint256 | The timestamp when the round was started. |
| updatedAt | uint256 | The timestamp of the block in which the answer was updated on L1. |
| answeredInRound | uint80 | The round ID of the round in which the answer was computed. |

## IWETH

### deposit

```solidity
function deposit() external payable
```

### withdraw

```solidity
function withdraw(uint256) external
```

### approve

```solidity
function approve(address guy, uint256 wad) external returns (bool)
```

### transferFrom

```solidity
function transferFrom(address src, address dst, uint256 wad) external returns (bool)
```

## MockFlashLoanReceiver

### ExecutedWithFail

```solidity
event ExecutedWithFail(address[] _assets, uint256[] _amounts, uint256[] _premiums)
```

### ExecutedWithSuccess

```solidity
event ExecutedWithSuccess(address[] _assets, uint256[] _amounts, uint256[] _premiums)
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
constructor(contract IPoolAddressesProvider provider) public
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
function executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address, bytes) public returns (bool)
```

## MockIncentivesController

### handleAction

```solidity
function handleAction(address, uint256, uint256) external
```

## MockPeripheryContractV1

### initialize

```solidity
function initialize(address manager, uint256 value) external
```

### getManager

```solidity
function getManager() external view returns (address)
```

### setManager

```solidity
function setManager(address newManager) external
```

## MockPeripheryContractV2

### initialize

```solidity
function initialize(address addressesProvider) external
```

### getManager

```solidity
function getManager() external view returns (address)
```

### setManager

```solidity
function setManager(address newManager) external
```

### getAddressesProvider

```solidity
function getAddressesProvider() external view returns (address)
```

## SelfdestructTransfer

## MockAggregator

### AnswerUpdated

```solidity
event AnswerUpdated(int256 current, uint256 roundId, uint256 updatedAt)
```

### constructor

```solidity
constructor(int256 initialAnswer) public
```

### latestAnswer

```solidity
function latestAnswer() external view returns (int256)
```

### getTokenType

```solidity
function getTokenType() external pure returns (uint256)
```

### decimals

```solidity
function decimals() external pure returns (uint8)
```

## PriceOracle

### prices

```solidity
mapping(address => uint256) prices
```

### ethPriceUsd

```solidity
uint256 ethPriceUsd
```

### AssetPriceUpdated

```solidity
event AssetPriceUpdated(address asset, uint256 price, uint256 timestamp)
```

### EthPriceUpdated

```solidity
event EthPriceUpdated(uint256 price, uint256 timestamp)
```

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

### setAssetPrice

```solidity
function setAssetPrice(address asset, uint256 price) external
```

Set the price of the asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |
| price | uint256 | The price of the asset |

### getEthUsdPrice

```solidity
function getEthUsdPrice() external view returns (uint256)
```

### setEthUsdPrice

```solidity
function setEthUsdPrice(uint256 price) external
```

## SequencerOracle

### _isDown

```solidity
bool _isDown
```

### _timestampGotUp

```solidity
uint256 _timestampGotUp
```

### constructor

```solidity
constructor(address owner) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner address of this contract |

### setAnswer

```solidity
function setAnswer(bool isDown, uint256 timestamp) external
```

Updates the health status of the sequencer.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| isDown | bool | True if the sequencer is down, false otherwise |
| timestamp | uint256 | The timestamp of last time the sequencer got up |

### latestRoundData

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
```

Returns the health status of the sequencer.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| roundId | uint80 | The round ID from the aggregator for which the data was retrieved combined with a phase to ensure that round IDs get larger as time moves forward. |
| answer | int256 | The answer for the latest round: 0 if the sequencer is up, 1 if it is down. |
| startedAt | uint256 | The timestamp when the round was started. |
| updatedAt | uint256 | The timestamp of the block in which the answer was updated on L1. |
| answeredInRound | uint80 | The round ID of the round in which the answer was computed. |

## WadRayMathWrapper

### wad

```solidity
function wad() public pure returns (uint256)
```

### ray

```solidity
function ray() public pure returns (uint256)
```

### halfRay

```solidity
function halfRay() public pure returns (uint256)
```

### halfWad

```solidity
function halfWad() public pure returns (uint256)
```

### wadMul

```solidity
function wadMul(uint256 a, uint256 b) public pure returns (uint256)
```

### wadDiv

```solidity
function wadDiv(uint256 a, uint256 b) public pure returns (uint256)
```

### rayMul

```solidity
function rayMul(uint256 a, uint256 b) public pure returns (uint256)
```

### rayDiv

```solidity
function rayDiv(uint256 a, uint256 b) public pure returns (uint256)
```

### rayToWad

```solidity
function rayToWad(uint256 a) public pure returns (uint256)
```

### wadToRay

```solidity
function wadToRay(uint256 a) public pure returns (uint256)
```

## BaseImmutableAdminUpgradeabilityProxy

This contract combines an upgradeability proxy with an authorization
mechanism for administrative tasks.

_The admin role is stored in an immutable, which helps saving transactions costs
All external functions in this contract must be guarded by the
`ifAdmin` modifier. See ethereum/solidity#3864 for a Solidity
feature proposal that would enable this to be done automatically._

### _admin

```solidity
address _admin
```

### constructor

```solidity
constructor(address admin) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin |

### ifAdmin

```solidity
modifier ifAdmin()
```

### admin

```solidity
function admin() external returns (address)
```

Return the admin address

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the proxy admin. |

### implementation

```solidity
function implementation() external returns (address)
```

Return the implementation address

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the implementation. |

### upgradeTo

```solidity
function upgradeTo(address newImplementation) external
```

Upgrade the backing implementation of the proxy.

_Only the admin can call this function._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | The address of the new implementation. |

### upgradeToAndCall

```solidity
function upgradeToAndCall(address newImplementation, bytes data) external payable
```

Upgrade the backing implementation of the proxy and call a function
on the new implementation.

_This is useful to initialize the proxied contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newImplementation | address | The address of the new implementation. |
| data | bytes | Data to send as msg.data in the low level call. It should include the signature and the parameters of the function to be called, as described in https://solidity.readthedocs.io/en/v0.4.24/abi-spec.html#function-selector-and-argument-encoding. |

### _willFallback

```solidity
function _willFallback() internal virtual
```

Only fall back when the sender is not the admin.

## InitializableImmutableAdminUpgradeabilityProxy

_Extends BaseAdminUpgradeabilityProxy with an initializer function_

### constructor

```solidity
constructor(address admin) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin |

### _willFallback

```solidity
function _willFallback() internal
```

Only fall back when the sender is not the admin.

## VersionedInitializable

Helper contract to implement initializer functions. To use it, replace
the constructor with a function that has the `initializer` modifier.

_WARNING: Unlike constructors, initializer functions must be manually
invoked. This applies both to deploying an Initializable contract, as well
as extending an Initializable contract via inheritance.
WARNING: When used with inheritance, manual care must be taken to not invoke
a parent initializer twice, or ensure that all initializers are idempotent,
because this is not dealt with automatically as with constructors._

### initializer

```solidity
modifier initializer()
```

_Modifier to use in the initializer function of a contract._

### getRevision

```solidity
function getRevision() internal pure virtual returns (uint256)
```

Returns the revision number of the contract

_Needs to be defined in the inherited class as a constant._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The revision number |

## GPv2SafeERC20

_Gas-efficient version of Openzeppelin's SafeERC20 contract._

### safeTransfer

```solidity
function safeTransfer(contract IERC20 token, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transfer` that reverts
also when the token returns `false`._

### safeTransferFrom

```solidity
function safeTransferFrom(contract IERC20 token, address from, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transferFrom` that
reverts also when the token returns `false`._

## Address

_Collection of functions related to the address type_

### isContract

```solidity
function isContract(address account) internal view returns (bool)
```

_Returns true if `account` is a contract.

[IMPORTANT]
====
It is unsafe to assume that an address for which this function returns
false is an externally-owned account (EOA) and not a contract.

Among others, `isContract` will return false for the following
types of addresses:

 - an externally-owned account
 - a contract in construction
 - an address where a contract will be created
 - an address where a contract lived, but was destroyed
====_

### sendValue

```solidity
function sendValue(address payable recipient, uint256 amount) internal
```

_Replacement for Solidity's `transfer`: sends `amount` wei to
`recipient`, forwarding all available gas and reverting on errors.

https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
of certain opcodes, possibly making contracts go over the 2300 gas limit
imposed by `transfer`, making them unable to receive funds via
`transfer`. {sendValue} removes this limitation.

https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].

IMPORTANT: because control is transferred to `recipient`, care must be
taken to not create reentrancy vulnerabilities. Consider using
{ReentrancyGuard} or the
https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern]._

### functionCall

```solidity
function functionCall(address target, bytes data) internal returns (bytes)
```

_Performs a Solidity function call using a low level `call`. A
plain `call` is an unsafe replacement for a function call: use this
function instead.

If `target` reverts with a revert reason, it is bubbled up by this
function (like regular Solidity function calls).

Returns the raw returned data. To convert to the expected return value,
use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].

Requirements:

- `target` must be a contract.
- calling `target` with `data` must not revert.

_Available since v3.1.__

### functionCall

```solidity
function functionCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
`errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but also transferring `value` wei to `target`.

Requirements:

- the calling contract must have an ETH balance of at least `value`.
- the called Solidity function must be `payable`.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
with `errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data, string errorMessage) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### verifyCallResult

```solidity
function verifyCallResult(bool success, bytes returndata, string errorMessage) internal pure returns (bytes)
```

_Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
revert reason using the provided one.

_Available since v4.3.__

## Context

### _msgSender

```solidity
function _msgSender() internal view virtual returns (address payable)
```

### _msgData

```solidity
function _msgData() internal view virtual returns (bytes)
```

## IAccessControl

_External interface of AccessControl declared to support ERC165 detection._

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 role, bytes32 previousAdminRole, bytes32 newAdminRole)
```

_Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`

`DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
{RoleAdminChanged} not being emitted signaling this.

_Available since v3.1.__

### RoleGranted

```solidity
event RoleGranted(bytes32 role, address account, address sender)
```

_Emitted when `account` is granted `role`.

`sender` is the account that originated the contract call, an admin role
bearer except when using {AccessControl-_setupRole}._

### RoleRevoked

```solidity
event RoleRevoked(bytes32 role, address account, address sender)
```

_Emitted when `account` is revoked `role`.

`sender` is the account that originated the contract call:
  - if using `revokeRole`, it is the admin role bearer
  - if using `renounceRole`, it is the role bearer (i.e. `account`)_

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```

_Returns `true` if `account` has been granted `role`._

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```

_Returns the admin role that controls `role`. See {grantRole} and
{revokeRole}.

To change a role's admin, use {AccessControl-_setRoleAdmin}._

### grantRole

```solidity
function grantRole(bytes32 role, address account) external
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event.

Requirements:

- the caller must have ``role``'s admin role._

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external
```

_Revokes `role` from `account`.

If `account` had been granted `role`, emits a {RoleRevoked} event.

Requirements:

- the caller must have ``role``'s admin role._

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external
```

_Revokes `role` from the calling account.

Roles are often managed via {grantRole} and {revokeRole}: this function's
purpose is to provide a mechanism for accounts to lose their privileges
if they are compromised (such as when a trusted device is misplaced).

If the calling account had been granted `role`, emits a {RoleRevoked}
event.

Requirements:

- the caller must be `account`._

## IERC20

_Interface of the ERC20 standard as defined in the EIP._

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

_Returns the amount of tokens in existence._

### balanceOf

```solidity
function balanceOf(address account) external view returns (uint256)
```

_Returns the amount of tokens owned by `account`._

### transfer

```solidity
function transfer(address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from the caller's account to `recipient`.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### allowance

```solidity
function allowance(address owner, address spender) external view returns (uint256)
```

_Returns the remaining number of tokens that `spender` will be
allowed to spend on behalf of `owner` through {transferFrom}. This is
zero by default.

This value changes when {approve} or {transferFrom} are called._

### approve

```solidity
function approve(address spender, uint256 amount) external returns (bool)
```

_Sets `amount` as the allowance of `spender` over the caller's tokens.

Returns a boolean value indicating whether the operation succeeded.

IMPORTANT: Beware that changing an allowance with this method brings the risk
that someone may use both the old and the new allowance by unfortunate
transaction ordering. One possible solution to mitigate this race
condition is to first reduce the spender's allowance to 0 and set the
desired value afterwards:
https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

Emits an {Approval} event._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from `sender` to `recipient` using the
allowance mechanism. `amount` is then deducted from the caller's
allowance.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

_Emitted when `value` tokens are moved from one account (`from`) to
another (`to`).

Note that `value` may be zero._

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

_Emitted when the allowance of a `spender` for an `owner` is set by
a call to {approve}. `value` is the new allowance._

## IERC20Detailed

### name

```solidity
function name() external view returns (string)
```

### symbol

```solidity
function symbol() external view returns (string)
```

### decimals

```solidity
function decimals() external view returns (uint8)
```

## SafeCast

_Wrappers over Solidity's uintXX/intXX casting operators with added overflow
checks.

Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
easily result in undesired exploitation or bugs, since developers usually
assume that overflows raise errors. `SafeCast` restores this intuition by
reverting the transaction when such an operation overflows.

Using this library instead of the unchecked operations eliminates an entire
class of bugs, so it's recommended to use it always.

Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
all math on `uint256` and `int256` and then downcasting._

### toUint224

```solidity
function toUint224(uint256 value) internal pure returns (uint224)
```

_Returns the downcasted uint224 from uint256, reverting on
overflow (when the input is greater than largest uint224).

Counterpart to Solidity's `uint224` operator.

Requirements:

- input must fit into 224 bits_

### toUint128

```solidity
function toUint128(uint256 value) internal pure returns (uint128)
```

_Returns the downcasted uint128 from uint256, reverting on
overflow (when the input is greater than largest uint128).

Counterpart to Solidity's `uint128` operator.

Requirements:

- input must fit into 128 bits_

### toUint96

```solidity
function toUint96(uint256 value) internal pure returns (uint96)
```

_Returns the downcasted uint96 from uint256, reverting on
overflow (when the input is greater than largest uint96).

Counterpart to Solidity's `uint96` operator.

Requirements:

- input must fit into 96 bits_

### toUint64

```solidity
function toUint64(uint256 value) internal pure returns (uint64)
```

_Returns the downcasted uint64 from uint256, reverting on
overflow (when the input is greater than largest uint64).

Counterpart to Solidity's `uint64` operator.

Requirements:

- input must fit into 64 bits_

### toUint32

```solidity
function toUint32(uint256 value) internal pure returns (uint32)
```

_Returns the downcasted uint32 from uint256, reverting on
overflow (when the input is greater than largest uint32).

Counterpart to Solidity's `uint32` operator.

Requirements:

- input must fit into 32 bits_

### toUint16

```solidity
function toUint16(uint256 value) internal pure returns (uint16)
```

_Returns the downcasted uint16 from uint256, reverting on
overflow (when the input is greater than largest uint16).

Counterpart to Solidity's `uint16` operator.

Requirements:

- input must fit into 16 bits_

### toUint8

```solidity
function toUint8(uint256 value) internal pure returns (uint8)
```

_Returns the downcasted uint8 from uint256, reverting on
overflow (when the input is greater than largest uint8).

Counterpart to Solidity's `uint8` operator.

Requirements:

- input must fit into 8 bits._

### toUint256

```solidity
function toUint256(int256 value) internal pure returns (uint256)
```

_Converts a signed int256 into an unsigned uint256.

Requirements:

- input must be greater than or equal to 0._

### toInt128

```solidity
function toInt128(int256 value) internal pure returns (int128)
```

_Returns the downcasted int128 from int256, reverting on
overflow (when the input is less than smallest int128 or
greater than largest int128).

Counterpart to Solidity's `int128` operator.

Requirements:

- input must fit into 128 bits

_Available since v3.1.__

### toInt64

```solidity
function toInt64(int256 value) internal pure returns (int64)
```

_Returns the downcasted int64 from int256, reverting on
overflow (when the input is less than smallest int64 or
greater than largest int64).

Counterpart to Solidity's `int64` operator.

Requirements:

- input must fit into 64 bits

_Available since v3.1.__

### toInt32

```solidity
function toInt32(int256 value) internal pure returns (int32)
```

_Returns the downcasted int32 from int256, reverting on
overflow (when the input is less than smallest int32 or
greater than largest int32).

Counterpart to Solidity's `int32` operator.

Requirements:

- input must fit into 32 bits

_Available since v3.1.__

### toInt16

```solidity
function toInt16(int256 value) internal pure returns (int16)
```

_Returns the downcasted int16 from int256, reverting on
overflow (when the input is less than smallest int16 or
greater than largest int16).

Counterpart to Solidity's `int16` operator.

Requirements:

- input must fit into 16 bits

_Available since v3.1.__

### toInt8

```solidity
function toInt8(int256 value) internal pure returns (int8)
```

_Returns the downcasted int8 from int256, reverting on
overflow (when the input is less than smallest int8 or
greater than largest int8).

Counterpart to Solidity's `int8` operator.

Requirements:

- input must fit into 8 bits.

_Available since v3.1.__

### toInt256

```solidity
function toInt256(uint256 value) internal pure returns (int256)
```

_Converts an unsigned uint256 into a signed int256.

Requirements:

- input must be less than or equal to maxInt256._

## IFlashLoanReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed assets

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The addresses of the flash-borrowed assets |
| amounts | uint256[] | The amounts of the flash-borrowed assets |
| premiums | uint256[] | The fee of each flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

## IFlashLoanSimpleReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed asset

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the flash-borrowed asset |
| amount | uint256 | The amount of the flash-borrowed asset |
| premium | uint256 | The fee of the flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

## IACLManager

Defines the basic interface for the ACL Manager

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the contract address of the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider |

### POOL_ADMIN_ROLE

```solidity
function POOL_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the PoolAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the PoolAdmin role |

### EMERGENCY_ADMIN_ROLE

```solidity
function EMERGENCY_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the EmergencyAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the EmergencyAdmin role |

### RISK_ADMIN_ROLE

```solidity
function RISK_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the RiskAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the RiskAdmin role |

### FLASH_BORROWER_ROLE

```solidity
function FLASH_BORROWER_ROLE() external view returns (bytes32)
```

Returns the identifier of the FlashBorrower role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the FlashBorrower role |

### BRIDGE_ROLE

```solidity
function BRIDGE_ROLE() external view returns (bytes32)
```

Returns the identifier of the Bridge role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the Bridge role |

### ASSET_LISTING_ADMIN_ROLE

```solidity
function ASSET_LISTING_ADMIN_ROLE() external view returns (bytes32)
```

Returns the identifier of the AssetListingAdmin role

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The id of the AssetListingAdmin role |

### setRoleAdmin

```solidity
function setRoleAdmin(bytes32 role, bytes32 adminRole) external
```

Set the role as admin of a specific role.

_By default the admin role for all roles is `DEFAULT_ADMIN_ROLE`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| role | bytes32 | The role to be managed by the admin role |
| adminRole | bytes32 | The admin role |

### addPoolAdmin

```solidity
function addPoolAdmin(address admin) external
```

Adds a new admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removePoolAdmin

```solidity
function removePoolAdmin(address admin) external
```

Removes an admin as PoolAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isPoolAdmin

```solidity
function isPoolAdmin(address admin) external view returns (bool)
```

Returns true if the address is PoolAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is PoolAdmin, false otherwise |

### addEmergencyAdmin

```solidity
function addEmergencyAdmin(address admin) external
```

Adds a new admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeEmergencyAdmin

```solidity
function removeEmergencyAdmin(address admin) external
```

Removes an admin as EmergencyAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isEmergencyAdmin

```solidity
function isEmergencyAdmin(address admin) external view returns (bool)
```

Returns true if the address is EmergencyAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is EmergencyAdmin, false otherwise |

### addRiskAdmin

```solidity
function addRiskAdmin(address admin) external
```

Adds a new admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeRiskAdmin

```solidity
function removeRiskAdmin(address admin) external
```

Removes an admin as RiskAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isRiskAdmin

```solidity
function isRiskAdmin(address admin) external view returns (bool)
```

Returns true if the address is RiskAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is RiskAdmin, false otherwise |

### addFlashBorrower

```solidity
function addFlashBorrower(address borrower) external
```

Adds a new address as FlashBorrower

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address of the new FlashBorrower |

### removeFlashBorrower

```solidity
function removeFlashBorrower(address borrower) external
```

Removes an address as FlashBorrower

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address of the FlashBorrower to remove |

### isFlashBorrower

```solidity
function isFlashBorrower(address borrower) external view returns (bool)
```

Returns true if the address is FlashBorrower, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| borrower | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is FlashBorrower, false otherwise |

### addBridge

```solidity
function addBridge(address bridge) external
```

Adds a new address as Bridge

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address of the new Bridge |

### removeBridge

```solidity
function removeBridge(address bridge) external
```

Removes an address as Bridge

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address of the bridge to remove |

### isBridge

```solidity
function isBridge(address bridge) external view returns (bool)
```

Returns true if the address is Bridge, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridge | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is Bridge, false otherwise |

### addAssetListingAdmin

```solidity
function addAssetListingAdmin(address admin) external
```

Adds a new admin as AssetListingAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the new admin |

### removeAssetListingAdmin

```solidity
function removeAssetListingAdmin(address admin) external
```

Removes an admin as AssetListingAdmin

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address of the admin to remove |

### isAssetListingAdmin

```solidity
function isAssetListingAdmin(address admin) external view returns (bool)
```

Returns true if the address is AssetListingAdmin, false otherwise

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| admin | address | The address to check |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the given address is AssetListingAdmin, false otherwise |

## IAToken

Defines the basic interface for an AToken.

### BalanceTransfer

```solidity
event BalanceTransfer(address from, address to, uint256 value, uint256 index)
```

_Emitted during the transfer action_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The user whose tokens are being transferred |
| to | address | The recipient |
| value | uint256 | The scaled amount being transferred |
| index | uint256 | The next liquidity index of the reserve |

### mint

```solidity
function mint(address caller, address onBehalfOf, uint256 amount, uint256 index) external returns (bool)
```

Mints `amount` aTokens to `user`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted aTokens |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` if the the previous balance of the user was 0 |

### burn

```solidity
function burn(address from, address receiverOfUnderlying, uint256 amount, uint256 index) external
```

Burns aTokens from `user` and sends the equivalent amount of underlying to `receiverOfUnderlying`

_In some instances, the mint event could be emitted from a burn transaction
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the aTokens will be burned |
| receiverOfUnderlying | address | The address that will receive the underlying |
| amount | uint256 | The amount being burned |
| index | uint256 | The next liquidity index of the reserve |

### mintToTreasury

```solidity
function mintToTreasury(uint256 amount, uint256 index) external
```

Mints aTokens to the reserve treasury

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

### transferOnLiquidation

```solidity
function transferOnLiquidation(address from, address to, uint256 value) external
```

Transfers aTokens in the event of a borrow being liquidated, in case the liquidators reclaims the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address getting liquidated, current owner of the aTokens |
| to | address | The recipient |
| value | uint256 | The amount of tokens getting transferred |

### transferUnderlyingTo

```solidity
function transferUnderlyingTo(address target, uint256 amount) external
```

Transfers the underlying asset to `target`.

_Used by the Pool to transfer assets in borrow(), withdraw() and flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The recipient of the underlying |
| amount | uint256 | The amount getting transferred |

### handleRepayment

```solidity
function handleRepayment(address user, address onBehalfOf, uint256 amount) external
```

Handles the underlying received by the aToken after the transfer has been completed.

_The default implementation is empty as with standard ERC20 tokens, nothing needs to be done after the
transfer is concluded. However in the future there may be aTokens that allow for example to stake the underlying
to receive LM rewards. In that case, `handleRepayment()` would perform the staking of the underlying asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user executing the repayment |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed |
| amount | uint256 | The amount getting repaid |

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this aToken (E.g. WETH for aWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

### RESERVE_TREASURY_ADDRESS

```solidity
function RESERVE_TREASURY_ADDRESS() external view returns (address)
```

Returns the address of the Aave treasury, receiving the fees on this aToken.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Address of the Aave treasury |

### DOMAIN_SEPARATOR

```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32)
```

Get the domain separator for the token

_Return cached value if chainId matches cache, otherwise recomputes separator_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator of the token at current chain |

### nonces

```solidity
function nonces(address owner) external view returns (uint256)
```

Returns the nonce for owner.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The address of the owner |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The nonce of the owner |

### rescueTokens

```solidity
function rescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

## IAaveIncentivesController

Defines the basic interface for an Aave Incentives Controller.

_It only contains one single function, needed as a hook on aToken and debtToken transfers._

### handleAction

```solidity
function handleAction(address user, uint256 totalSupply, uint256 userBalance) external
```

_Called by the corresponding asset on transfer hook in order to update the rewards distribution.
The units of `totalSupply` and `userBalance` should be the same._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user whose asset balance has changed |
| totalSupply | uint256 | The total supply of the asset prior to user balance change |
| userBalance | uint256 | The previous user balance prior to balance change |

## YieldMode

```solidity
enum YieldMode {
  AUTOMATIC,
  VOID,
  CLAIMABLE
}
```

## GasMode

```solidity
enum GasMode {
  VOID,
  CLAIMABLE
}
```

## IBlast

### configureContract

```solidity
function configureContract(address contractAddress, enum YieldMode _yield, enum GasMode gasMode, address governor) external
```

### configure

```solidity
function configure(enum YieldMode _yield, enum GasMode gasMode, address governor) external
```

### configureClaimableYield

```solidity
function configureClaimableYield() external
```

### configureClaimableYieldOnBehalf

```solidity
function configureClaimableYieldOnBehalf(address contractAddress) external
```

### configureAutomaticYield

```solidity
function configureAutomaticYield() external
```

### configureAutomaticYieldOnBehalf

```solidity
function configureAutomaticYieldOnBehalf(address contractAddress) external
```

### configureVoidYield

```solidity
function configureVoidYield() external
```

### configureVoidYieldOnBehalf

```solidity
function configureVoidYieldOnBehalf(address contractAddress) external
```

### configureClaimableGas

```solidity
function configureClaimableGas() external
```

### configureClaimableGasOnBehalf

```solidity
function configureClaimableGasOnBehalf(address contractAddress) external
```

### configureVoidGas

```solidity
function configureVoidGas() external
```

### configureVoidGasOnBehalf

```solidity
function configureVoidGasOnBehalf(address contractAddress) external
```

### configureGovernor

```solidity
function configureGovernor(address _governor) external
```

### configureGovernorOnBehalf

```solidity
function configureGovernorOnBehalf(address _newGovernor, address contractAddress) external
```

### claimYield

```solidity
function claimYield(address contractAddress, address recipientOfYield, uint256 amount) external returns (uint256)
```

### claimAllYield

```solidity
function claimAllYield(address contractAddress, address recipientOfYield) external returns (uint256)
```

### claimAllGas

```solidity
function claimAllGas(address contractAddress, address recipientOfGas) external returns (uint256)
```

### claimGasAtMinClaimRate

```solidity
function claimGasAtMinClaimRate(address contractAddress, address recipientOfGas, uint256 minClaimRateBips) external returns (uint256)
```

### claimMaxGas

```solidity
function claimMaxGas(address contractAddress, address recipientOfGas) external returns (uint256)
```

### claimGas

```solidity
function claimGas(address contractAddress, address recipientOfGas, uint256 gasToClaim, uint256 gasSecondsToConsume) external returns (uint256)
```

### readClaimableYield

```solidity
function readClaimableYield(address contractAddress) external view returns (uint256)
```

### readYieldConfiguration

```solidity
function readYieldConfiguration(address contractAddress) external view returns (uint8)
```

### readGasParams

```solidity
function readGasParams(address contractAddress) external view returns (uint256 etherSeconds, uint256 etherBalance, uint256 lastUpdated, enum GasMode)
```

## IBlastRebasingERC20

### configure

```solidity
function configure(enum YieldMode) external returns (uint256)
```

### claim

```solidity
function claim(address recipient, uint256 amount) external returns (uint256)
```

### getClaimableAmount

```solidity
function getClaimableAmount(address account) external view returns (uint256)
```

## IBlastAToken

### claimYield

```solidity
function claimYield(address to) external returns (uint256)
```

## IERC20WithPermit

Interface for the permit function (EIP-2612)

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

## IInitializableAToken

Interface for the initialize function on AToken

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address treasury, address incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params)
```

_Emitted when an aToken is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| treasury | address | The address of the treasury |
| incentivesController | address | The address of the incentives controller for this aToken |
| aTokenDecimals | uint8 | The decimals of the underlying |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address treasury, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 aTokenDecimals, string aTokenName, string aTokenSymbol, bytes params) external
```

Initializes the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| treasury | address | The address of the Aave treasury, receiving the fees on this aToken |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| aTokenDecimals | uint8 | The decimals of the aToken, same as the underlying asset's |
| aTokenName | string | The name of the aToken |
| aTokenSymbol | string | The symbol of the aToken |
| params | bytes | A set of encoded parameters for additional initialization |

## IInitializableDebtToken

Interface for the initialize function common between debt tokens

### Initialized

```solidity
event Initialized(address underlyingAsset, address pool, address incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params)
```

_Emitted when a debt token is initialized_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| underlyingAsset | address | The address of the underlying asset |
| pool | address | The address of the associated pool |
| incentivesController | address | The address of the incentives controller for this aToken |
| debtTokenDecimals | uint8 | The decimals of the debt token |
| debtTokenName | string | The name of the debt token |
| debtTokenSymbol | string | The symbol of the debt token |
| params | bytes | A set of encoded parameters for additional initialization |

### initialize

```solidity
function initialize(contract IPool pool, address underlyingAsset, contract IAaveIncentivesController incentivesController, uint8 debtTokenDecimals, string debtTokenName, string debtTokenSymbol, bytes params) external
```

Initializes the debt token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The pool contract that is initializing this contract |
| underlyingAsset | address | The address of the underlying asset of this aToken (E.g. WETH for aWETH) |
| incentivesController | contract IAaveIncentivesController | The smart contract managing potential incentives distribution |
| debtTokenDecimals | uint8 | The decimals of the debtToken, same as the underlying asset's |
| debtTokenName | string | The name of the token |
| debtTokenSymbol | string | The symbol of the token |
| params | bytes | A set of encoded parameters for additional initialization |

## IPool

Defines the basic interface for an Aave Pool.

### MintUnbacked

```solidity
event MintUnbacked(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

_Emitted on mintUnbacked()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address initiating the supply |
| onBehalfOf | address | The beneficiary of the supplied assets, receiving the aTokens |
| amount | uint256 | The amount of supplied assets |
| referralCode | uint16 | The referral code used |

### BackUnbacked

```solidity
event BackUnbacked(address reserve, address backer, uint256 amount, uint256 fee)
```

_Emitted on backUnbacked()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| backer | address | The address paying for the backing |
| amount | uint256 | The amount added as backing |
| fee | uint256 | The amount paid in fees |

### Supply

```solidity
event Supply(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

_Emitted on supply()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address initiating the supply |
| onBehalfOf | address | The beneficiary of the supply, receiving the aTokens |
| amount | uint256 | The amount supplied |
| referralCode | uint16 | The referral code used |

### Withdraw

```solidity
event Withdraw(address reserve, address user, address to, uint256 amount)
```

_Emitted on withdraw()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being withdrawn |
| user | address | The address initiating the withdrawal, owner of aTokens |
| to | address | The address that will receive the underlying |
| amount | uint256 | The amount to be withdrawn |

### Borrow

```solidity
event Borrow(address reserve, address user, address onBehalfOf, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 borrowRate, uint16 referralCode)
```

_Emitted on borrow() and flashLoan() when debt needs to be opened_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset being borrowed |
| user | address | The address of the user initiating the borrow(), receiving the funds on borrow() or just initiator of the transaction on flashLoan() |
| onBehalfOf | address | The address that will be getting the debt |
| amount | uint256 | The amount borrowed out |
| interestRateMode | enum DataTypes.InterestRateMode | The rate mode: 1 for Stable, 2 for Variable |
| borrowRate | uint256 | The numeric rate at which the user has borrowed, expressed in ray |
| referralCode | uint16 | The referral code used |

### Repay

```solidity
event Repay(address reserve, address user, address repayer, uint256 amount, bool useATokens)
```

_Emitted on repay()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The beneficiary of the repayment, getting his debt reduced |
| repayer | address | The address of the user initiating the repay(), providing the funds |
| amount | uint256 | The amount repaid |
| useATokens | bool | True if the repayment is done using aTokens, `false` if done with underlying asset directly |

### SwapBorrowRateMode

```solidity
event SwapBorrowRateMode(address reserve, address user, enum DataTypes.InterestRateMode interestRateMode)
```

_Emitted on swapBorrowRateMode()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user swapping his rate mode |
| interestRateMode | enum DataTypes.InterestRateMode | The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable |

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

_Emitted on borrow(), repay() and liquidationCall() when using isolated assets_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| totalDebt | uint256 | The total isolation mode debt for the reserve |

### UserEModeSet

```solidity
event UserEModeSet(address user, uint8 categoryId)
```

_Emitted when the user selects a certain asset category for eMode_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |
| categoryId | uint8 | The category id |

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

_Emitted on setUserUseReserveAsCollateral()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user enabling the usage as collateral |

### RebalanceStableBorrowRate

```solidity
event RebalanceStableBorrowRate(address reserve, address user)
```

_Emitted on rebalanceStableBorrowRate()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| user | address | The address of the user for which the rebalance has been executed |

### FlashLoan

```solidity
event FlashLoan(address target, address initiator, address asset, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 premium, uint16 referralCode)
```

_Emitted on flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The address of the flash loan receiver contract |
| initiator | address | The address initiating the flash loan |
| asset | address | The address of the asset being flash borrowed |
| amount | uint256 | The amount flash borrowed |
| interestRateMode | enum DataTypes.InterestRateMode | The flashloan mode: 0 for regular flashloan, 1 for Stable debt, 2 for Variable debt |
| premium | uint256 | The fee flash borrowed |
| referralCode | uint16 | The referral code used |

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator, bool receiveAToken)
```

_Emitted when a borrower is liquidated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| liquidatedCollateralAmount | uint256 | The amount of collateral received by the liquidator |
| liquidator | address | The address of the liquidator |
| receiveAToken | bool | True if the liquidators wants to receive the collateral aTokens, `false` if he wants to receive the underlying collateral asset directly |

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 stableBorrowRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

_Emitted when the state of a reserve is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the underlying asset of the reserve |
| liquidityRate | uint256 | The next liquidity rate |
| stableBorrowRate | uint256 | The next stable borrow rate |
| variableBorrowRate | uint256 | The next variable borrow rate |
| liquidityIndex | uint256 | The next liquidity index |
| variableBorrowIndex | uint256 | The next variable borrow index |

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

_Emitted when the protocol treasury receives minted aTokens from the accrued interest._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | address | The address of the reserve |
| amountMinted | uint256 | The amount minted to the treasury |

### mintUnbacked

```solidity
function mintUnbacked(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external
```

Mints an `amount` of aTokens to the `onBehalfOf`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to mint |
| amount | uint256 | The amount to mint |
| onBehalfOf | address | The address that will receive the aTokens |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### backUnbacked

```solidity
function backUnbacked(address asset, uint256 amount, uint256 fee) external returns (uint256)
```

Back the current unbacked underlying with `amount` and pay `fee`.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to back |
| amount | uint256 | The amount to back |
| fee | uint256 | The amount paid in fees |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The backed amount |

### supply

```solidity
function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### supplyWithPermit

```solidity
function supplyWithPermit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode, uint256 deadline, uint8 permitV, bytes32 permitR, bytes32 permitS) external
```

Supply with transfer approval of asset to be supplied done via permit function
see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| deadline | uint256 | The deadline timestamp that the permit is valid |
| permitV | uint8 | The V parameter of ERC712 permit sig |
| permitR | bytes32 | The R parameter of ERC712 permit sig |
| permitS | bytes32 | The S parameter of ERC712 permit sig |

### withdraw

```solidity
function withdraw(address asset, uint256 amount, address to) external returns (uint256)
```

Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to withdraw |
| amount | uint256 | The underlying amount to be withdrawn   - Send the value type(uint256).max in order to withdraw the whole aToken balance |
| to | address | The address that will receive the underlying, same as msg.sender if the user   wants to receive it on his own wallet, or a different address if the beneficiary is a   different wallet |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount withdrawn |

### borrow

```solidity
function borrow(address asset, uint256 amount, uint256 interestRateMode, uint16 referralCode, address onBehalfOf) external
```

Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
already supplied enough collateral, or he was given enough allowance by a credit delegator on the
corresponding debt token (StableDebtToken or VariableDebtToken)
- E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
  and 100 stable/variable debt tokens, depending on the `interestRateMode`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to borrow |
| amount | uint256 | The amount to be borrowed |
| interestRateMode | uint256 | The interest rate mode at which the user wants to borrow: 1 for Stable, 2 for Variable |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| onBehalfOf | address | The address of the user who will receive the debt. Should be the address of the borrower itself calling the function if he wants to borrow against his own collateral, or the address of the credit delegator if he has been given credit delegation allowance |

### repay

```solidity
function repay(address asset, uint256 amount, uint256 interestRateMode, address onBehalfOf) external returns (uint256)
```

Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
- E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### repayWithPermit

```solidity
function repayWithPermit(address asset, uint256 amount, uint256 interestRateMode, address onBehalfOf, uint256 deadline, uint8 permitV, bytes32 permitR, bytes32 permitS) external returns (uint256)
```

Repay with transfer approval of asset to be repaid done via permit function
see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |
| onBehalfOf | address | Address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |
| deadline | uint256 | The deadline timestamp that the permit is valid |
| permitV | uint8 | The V parameter of ERC712 permit sig |
| permitR | bytes32 | The R parameter of ERC712 permit sig |
| permitS | bytes32 | The S parameter of ERC712 permit sig |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### repayWithATokens

```solidity
function repayWithATokens(address asset, uint256 amount, uint256 interestRateMode) external returns (uint256)
```

Repays a borrowed `amount` on a specific reserve using the reserve aTokens, burning the
equivalent debt tokens
- E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable/stable debt tokens

_Passing uint256.max as amount will clean up any residual aToken dust balance, if the user aToken
balance is not enough to cover the whole debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### swapBorrowRateMode

```solidity
function swapBorrowRateMode(address asset, uint256 interestRateMode) external
```

Allows a borrower to swap his debt between stable and variable mode, or vice versa

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset borrowed |
| interestRateMode | uint256 | The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable |

### rebalanceStableBorrowRate

```solidity
function rebalanceStableBorrowRate(address asset, address user) external
```

Rebalances the stable interest rate of a user to the current stable rate defined on the reserve.
- Users can be rebalanced if the following conditions are satisfied:
    1. Usage ratio is above 95%
    2. the current supply APY is below REBALANCE_UP_THRESHOLD * maxVariableBorrowRate, which means that too
       much has been borrowed at a stable rate and suppliers are not earning enough

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset borrowed |
| user | address | The address of the user to be rebalanced |

### setUserUseReserveAsCollateral

```solidity
function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) external
```

Allows suppliers to enable/disable a specific supplied asset as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset supplied |
| useAsCollateral | bool | True if the user wants to use the supply as collateral, false otherwise |

### liquidationCall

```solidity
function liquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, bool receiveAToken) external
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| receiveAToken | bool | True if the liquidators wants to receive the collateral aTokens, `false` if he wants to receive the underlying collateral asset directly |

### flashLoan

```solidity
function flashLoan(address receiverAddress, address[] assets, uint256[] amounts, uint256[] interestRateModes, address onBehalfOf, bytes params, uint16 referralCode) external
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanReceiver interface |
| assets | address[] | The addresses of the assets being flash-borrowed |
| amounts | uint256[] | The amounts of the assets being flash-borrowed |
| interestRateModes | uint256[] | Types of the debt to open if the flash loan is not returned:   0 -> Don't open any debt, just revert if funds can't be transferred from the receiver   1 -> Open debt at stable rate for the value of the amount flash-borrowed to the `onBehalfOf` address   2 -> Open debt at variable rate for the value of the amount flash-borrowed to the `onBehalfOf` address |
| onBehalfOf | address | The address  that will receive the debt in the case of using on `modes` 1 or 2 |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### flashLoanSimple

```solidity
function flashLoanSimple(address receiverAddress, address asset, uint256 amount, bytes params, uint16 referralCode) external
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface |
| asset | address | The address of the asset being flash-borrowed |
| amount | uint256 | The amount of the asset being flash-borrowed |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### getUserAccountData

```solidity
function getUserAccountData(address user) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

### initReserve

```solidity
function initReserve(address asset, address aTokenAddress, address stableDebtAddress, address variableDebtAddress, address interestRateStrategyAddress) external
```

Initializes a reserve, activating it, assigning an aToken and debt tokens and an
interest rate strategy

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| aTokenAddress | address | The address of the aToken that will be assigned to the reserve |
| stableDebtAddress | address | The address of the StableDebtToken that will be assigned to the reserve |
| variableDebtAddress | address | The address of the VariableDebtToken that will be assigned to the reserve |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### dropReserve

```solidity
function dropReserve(address asset) external
```

Drop a reserve

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address asset, address rateStrategyAddress) external
```

Updates the address of the interest rate strategy contract

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| rateStrategyAddress | address | The address of the interest rate strategy contract |

### setConfiguration

```solidity
function setConfiguration(address asset, struct DataTypes.ReserveConfigurationMap configuration) external
```

Sets the configuration bitmap of the reserve as a whole

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| configuration | struct DataTypes.ReserveConfigurationMap | The new configuration bitmap |

### getConfiguration

```solidity
function getConfiguration(address asset) external view returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user) external view returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address asset) external view returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address asset) external view returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReserveData

```solidity
function getReserveData(address asset) external view returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### finalizeTransfer

```solidity
function finalizeTransfer(address asset, address from, address to, uint256 amount, uint256 balanceFromBefore, uint256 balanceToBefore) external
```

Validates and finalizes an aToken transfer

_Only callable by the overlying aToken of the `asset`_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the aToken |
| from | address | The user from which the aTokens are transferred |
| to | address | The user receiving the aTokens |
| amount | uint256 | The amount being transferred/withdrawn |
| balanceFromBefore | uint256 | The aToken balance of the `from` user before the transfer |
| balanceToBefore | uint256 | The aToken balance of the `to` user before the transfer |

### getReservesList

```solidity
function getReservesList() external view returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

_It does not include dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view returns (uint256)
```

Returns the number of initialized reserves

_It includes dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the PoolAddressesProvider connected to this contract

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider |

### updateBridgeProtocolFee

```solidity
function updateBridgeProtocolFee(uint256 bridgeProtocolFee) external
```

Updates the protocol fee on the bridging

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| bridgeProtocolFee | uint256 | The part of the premium sent to the protocol treasury |

### updateFlashloanPremiums

```solidity
function updateFlashloanPremiums(uint128 flashLoanPremiumTotal, uint128 flashLoanPremiumToProtocol) external
```

Updates flash loan premiums. Flash loan premium consists of two parts:
- A part is sent to aToken holders as extra, one time accumulated interest
- A part is collected by the protocol treasury

_The total premium is calculated on the total borrowed amount
The premium to protocol is calculated on the total premium, being a percentage of `flashLoanPremiumTotal`
Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| flashLoanPremiumTotal | uint128 | The total premium, expressed in bps |
| flashLoanPremiumToProtocol | uint128 | The part of the premium sent to the protocol treasury, expressed in bps |

### configureEModeCategory

```solidity
function configureEModeCategory(uint8 id, struct DataTypes.EModeCategory config) external
```

Configures a new category for the eMode.

_In eMode, the protocol allows very high borrowing power to borrow assets of the same category.
The category 0 is reserved as it's the default for volatile assets_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint8 | The id of the category |
| config | struct DataTypes.EModeCategory | The configuration of the category |

### getEModeCategoryData

```solidity
function getEModeCategoryData(uint8 id) external view returns (struct DataTypes.EModeCategory)
```

Returns the data of an eMode category

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint8 | The id of the category |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.EModeCategory | The configuration data of the category |

### setUserEMode

```solidity
function setUserEMode(uint8 categoryId) external
```

Allows a user to use the protocol in eMode

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| categoryId | uint8 | The id of the category |

### getUserEMode

```solidity
function getUserEMode(address user) external view returns (uint256)
```

Returns the eMode the user is using

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode id |

### resetIsolationModeTotalDebt

```solidity
function resetIsolationModeTotalDebt(address asset) external
```

Resets the isolation mode total debt of the given asset to zero

_It requires the given asset has zero debt ceiling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to reset the isolationModeTotalDebt |

### MAX_STABLE_RATE_BORROW_SIZE_PERCENT

```solidity
function MAX_STABLE_RATE_BORROW_SIZE_PERCENT() external view returns (uint256)
```

Returns the percentage of available liquidity that can be borrowed at once at stable rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The percentage of available liquidity to borrow, expressed in bps |

### FLASHLOAN_PREMIUM_TOTAL

```solidity
function FLASHLOAN_PREMIUM_TOTAL() external view returns (uint128)
```

Returns the total fee on flash loans

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint128 | The total fee on flashloans |

### BRIDGE_PROTOCOL_FEE

```solidity
function BRIDGE_PROTOCOL_FEE() external view returns (uint256)
```

Returns the part of the bridge fees sent to protocol

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The bridge fee sent to the protocol treasury |

### FLASHLOAN_PREMIUM_TO_PROTOCOL

```solidity
function FLASHLOAN_PREMIUM_TO_PROTOCOL() external view returns (uint128)
```

Returns the part of the flashloan fees sent to protocol

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint128 | The flashloan fee sent to the protocol treasury |

### MAX_NUMBER_RESERVES

```solidity
function MAX_NUMBER_RESERVES() external view returns (uint16)
```

Returns the maximum number of reserves supported to be listed in this Pool

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint16 | The maximum number of reserves supported |

### mintToTreasury

```solidity
function mintToTreasury(address[] assets) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### rescueTokens

```solidity
function rescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

### deposit

```solidity
function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

_Deprecated: Use the `supply` function instead_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

## IPoolAddressesProvider

Defines the basic interface for a Pool Addresses Provider.

### MarketIdSet

```solidity
event MarketIdSet(string oldMarketId, string newMarketId)
```

_Emitted when the market identifier is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldMarketId | string | The old id of the market |
| newMarketId | string | The new id of the market |

### PoolUpdated

```solidity
event PoolUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the Pool |
| newAddress | address | The new address of the Pool |

### PoolConfiguratorUpdated

```solidity
event PoolConfiguratorUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool configurator is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolConfigurator |
| newAddress | address | The new address of the PoolConfigurator |

### PriceOracleUpdated

```solidity
event PriceOracleUpdated(address oldAddress, address newAddress)
```

_Emitted when the price oracle is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PriceOracle |
| newAddress | address | The new address of the PriceOracle |

### ACLManagerUpdated

```solidity
event ACLManagerUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL manager is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLManager |
| newAddress | address | The new address of the ACLManager |

### ACLAdminUpdated

```solidity
event ACLAdminUpdated(address oldAddress, address newAddress)
```

_Emitted when the ACL admin is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the ACLAdmin |
| newAddress | address | The new address of the ACLAdmin |

### PriceOracleSentinelUpdated

```solidity
event PriceOracleSentinelUpdated(address oldAddress, address newAddress)
```

_Emitted when the price oracle sentinel is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PriceOracleSentinel |
| newAddress | address | The new address of the PriceOracleSentinel |

### PoolDataProviderUpdated

```solidity
event PoolDataProviderUpdated(address oldAddress, address newAddress)
```

_Emitted when the pool data provider is updated._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| oldAddress | address | The old address of the PoolDataProvider |
| newAddress | address | The new address of the PoolDataProvider |

### ProxyCreated

```solidity
event ProxyCreated(bytes32 id, address proxyAddress, address implementationAddress)
```

_Emitted when a new proxy is created._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the proxy |
| proxyAddress | address | The address of the created proxy contract |
| implementationAddress | address | The address of the implementation contract |

### AddressSet

```solidity
event AddressSet(bytes32 id, address oldAddress, address newAddress)
```

_Emitted when a new non-proxied contract address is registered._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| oldAddress | address | The address of the old contract |
| newAddress | address | The address of the new contract |

### AddressSetAsProxy

```solidity
event AddressSetAsProxy(bytes32 id, address proxyAddress, address oldImplementationAddress, address newImplementationAddress)
```

_Emitted when the implementation of the proxy registered with id is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The identifier of the contract |
| proxyAddress | address | The address of the proxy contract |
| oldImplementationAddress | address | The address of the old implementation contract |
| newImplementationAddress | address | The address of the new implementation contract |

### getMarketId

```solidity
function getMarketId() external view returns (string)
```

Returns the id of the Aave market to which this contract points to.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The market id |

### setMarketId

```solidity
function setMarketId(string newMarketId) external
```

Associates an id with a specific PoolAddressesProvider.

_This can be used to create an onchain registry of PoolAddressesProviders to
identify and validate multiple Aave markets._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMarketId | string | The market id |

### getAddress

```solidity
function getAddress(bytes32 id) external view returns (address)
```

Returns an address by its identifier.

_The returned address might be an EOA or a contract, potentially proxied
It returns ZERO if there is no registered address with the given id_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the registered for the specified id |

### setAddressAsProxy

```solidity
function setAddressAsProxy(bytes32 id, address newImplementationAddress) external
```

General function to update the implementation of a proxy registered with
certain `id`. If there is no proxy registered, it will instantiate one and
set as implementation the `newImplementationAddress`.

_IMPORTANT Use this function carefully, only for ids that don't have an explicit
setter function, in order to avoid unexpected consequences_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newImplementationAddress | address | The address of the new implementation |

### setAddress

```solidity
function setAddress(bytes32 id, address newAddress) external
```

Sets an address for an id replacing the address saved in the addresses map.

_IMPORTANT Use this function carefully, as it will do a hard replacement_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | bytes32 | The id |
| newAddress | address | The address to set |

### getPool

```solidity
function getPool() external view returns (address)
```

Returns the address of the Pool proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The Pool proxy address |

### setPoolImpl

```solidity
function setPoolImpl(address newPoolImpl) external
```

Updates the implementation of the Pool, or creates a proxy
setting the new `pool` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolImpl | address | The new Pool implementation |

### getPoolConfigurator

```solidity
function getPoolConfigurator() external view returns (address)
```

Returns the address of the PoolConfigurator proxy.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The PoolConfigurator proxy address |

### setPoolConfiguratorImpl

```solidity
function setPoolConfiguratorImpl(address newPoolConfiguratorImpl) external
```

Updates the implementation of the PoolConfigurator, or creates a proxy
setting the new `PoolConfigurator` implementation when the function is called for the first time.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPoolConfiguratorImpl | address | The new PoolConfigurator implementation |

### getPriceOracle

```solidity
function getPriceOracle() external view returns (address)
```

Returns the address of the price oracle.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracle |

### setPriceOracle

```solidity
function setPriceOracle(address newPriceOracle) external
```

Updates the address of the price oracle.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracle | address | The address of the new PriceOracle |

### getACLManager

```solidity
function getACLManager() external view returns (address)
```

Returns the address of the ACL manager.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACLManager |

### setACLManager

```solidity
function setACLManager(address newAclManager) external
```

Updates the address of the ACL manager.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclManager | address | The address of the new ACLManager |

### getACLAdmin

```solidity
function getACLAdmin() external view returns (address)
```

Returns the address of the ACL admin.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the ACL admin |

### setACLAdmin

```solidity
function setACLAdmin(address newAclAdmin) external
```

Updates the address of the ACL admin.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newAclAdmin | address | The address of the new ACL admin |

### getPriceOracleSentinel

```solidity
function getPriceOracleSentinel() external view returns (address)
```

Returns the address of the price oracle sentinel.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the PriceOracleSentinel |

### setPriceOracleSentinel

```solidity
function setPriceOracleSentinel(address newPriceOracleSentinel) external
```

Updates the address of the price oracle sentinel.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newPriceOracleSentinel | address | The address of the new PriceOracleSentinel |

### getPoolDataProvider

```solidity
function getPoolDataProvider() external view returns (address)
```

Returns the address of the data provider.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the DataProvider |

### setPoolDataProvider

```solidity
function setPoolDataProvider(address newDataProvider) external
```

Updates the address of the data provider.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newDataProvider | address | The address of the new DataProvider |

## IPriceOracleGetter

Interface for the Aave price oracle.

### BASE_CURRENCY

```solidity
function BASE_CURRENCY() external view returns (address)
```

Returns the base currency address

_Address 0x0 is reserved for USD as base currency._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Returns the base currency address. |

### BASE_CURRENCY_UNIT

```solidity
function BASE_CURRENCY_UNIT() external view returns (uint256)
```

Returns the base currency unit

_1 ether for ETH, 1e8 for USD._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | Returns the base currency unit. |

### getAssetPrice

```solidity
function getAssetPrice(address asset) external view returns (uint256)
```

Returns the asset price in the base currency

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The price of the asset |

## IPriceOracleSentinel

Defines the basic interface for the PriceOracleSentinel

### SequencerOracleUpdated

```solidity
event SequencerOracleUpdated(address newSequencerOracle)
```

_Emitted after the sequencer oracle is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSequencerOracle | address | The new sequencer oracle |

### GracePeriodUpdated

```solidity
event GracePeriodUpdated(uint256 newGracePeriod)
```

_Emitted after the grace period is updated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newGracePeriod | uint256 | The new grace period value |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

Returns the PoolAddressesProvider

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### isBorrowAllowed

```solidity
function isBorrowAllowed() external view returns (bool)
```

Returns true if the `borrow` operation is allowed.

_Operation not allowed when PriceOracle is down or grace period not passed._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the `borrow` operation is allowed, false otherwise. |

### isLiquidationAllowed

```solidity
function isLiquidationAllowed() external view returns (bool)
```

Returns true if the `liquidation` operation is allowed.

_Operation not allowed when PriceOracle is down or grace period not passed._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the `liquidation` operation is allowed, false otherwise. |

### setSequencerOracle

```solidity
function setSequencerOracle(address newSequencerOracle) external
```

Updates the address of the sequencer oracle

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSequencerOracle | address | The address of the new Sequencer Oracle to use |

### setGracePeriod

```solidity
function setGracePeriod(uint256 newGracePeriod) external
```

Updates the duration of the grace period

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newGracePeriod | uint256 | The value of the new grace period duration |

### getSequencerOracle

```solidity
function getSequencerOracle() external view returns (address)
```

Returns the SequencerOracle

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the sequencer oracle contract |

### getGracePeriod

```solidity
function getGracePeriod() external view returns (uint256)
```

Returns the grace period

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The duration of the grace period |

## IReserveInterestRateStrategy

Interface for the calculation of the interest rates

### calculateInterestRates

```solidity
function calculateInterestRates(struct DataTypes.CalculateInterestRatesParams params) external view returns (uint256, uint256, uint256)
```

Calculates the interest rates depending on the reserve's state and configurations

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct DataTypes.CalculateInterestRatesParams | The parameters needed to calculate interest rates |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | liquidityRate The liquidity rate expressed in rays |
| [1] | uint256 | stableBorrowRate The stable borrow rate expressed in rays |
| [2] | uint256 | variableBorrowRate The variable borrow rate expressed in rays |

## IScaledBalanceToken

Defines the basic interface for a scaled-balance token.

### Mint

```solidity
event Mint(address caller, address onBehalfOf, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the mint action_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted tokens |
| value | uint256 | The scaled-up amount being minted (based on user entered amount and balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'onBehalfOf' |
| index | uint256 | The next liquidity index of the reserve |

### Burn

```solidity
event Burn(address from, address target, uint256 value, uint256 balanceIncrease, uint256 index)
```

_Emitted after the burn action
If the burn function does not involve a transfer of the underlying asset, the target defaults to zero address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the tokens will be burned |
| target | address | The address that will receive the underlying, if any |
| value | uint256 | The scaled-up amount being burned (user entered amount - balance increase from interest) |
| balanceIncrease | uint256 | The increase in scaled-up balance since the last action of 'from' |
| index | uint256 | The next liquidity index of the reserve |

### scaledBalanceOf

```solidity
function scaledBalanceOf(address user) external view returns (uint256)
```

Returns the scaled balance of the user.

_The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
at the moment of the update_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user whose balance is calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |

### getScaledUserBalanceAndSupply

```solidity
function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256)
```

Returns the scaled balance of the user and the scaled total supply.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |
| [1] | uint256 | The scaled total supply |

### scaledTotalSupply

```solidity
function scaledTotalSupply() external view returns (uint256)
```

Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total supply |

### getPreviousIndex

```solidity
function getPreviousIndex(address user) external view returns (uint256)
```

Returns last index interest was accrued to the user's balance

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The last index interest was accrued to the user's balance, expressed in ray |

## IStableDebtToken

Defines the interface for the stable debt token

_It does not inherit from IERC20 to save in code size_

### Mint

```solidity
event Mint(address user, address onBehalfOf, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 newRate, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is minted_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user who triggered the minting |
| onBehalfOf | address | The recipient of stable debt tokens |
| amount | uint256 | The amount minted (user entered amount + balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of the user 'onBehalfOf' |
| newRate | uint256 | The rate of the debt after the minting |
| avgStableRate | uint256 | The next average stable rate after the minting |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### Burn

```solidity
event Burn(address from, uint256 amount, uint256 currentBalance, uint256 balanceIncrease, uint256 avgStableRate, uint256 newTotalSupply)
```

_Emitted when new stable debt is burned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount being burned (user entered amount - balance increase from interest) |
| currentBalance | uint256 | The balance of the user based on the previous balance and balance increase from interest |
| balanceIncrease | uint256 | The increase in balance since the last action of 'from' |
| avgStableRate | uint256 | The next average stable rate after the burning |
| newTotalSupply | uint256 | The next total supply of the stable debt token after the action |

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 rate) external returns (bool, uint256, uint256)
```

Mints debt token to the `onBehalfOf` address.

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt tokens to mint |
| rate | uint256 | The rate of the debt being minted |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if it is the first borrow, false otherwise |
| [1] | uint256 | The total stable debt |
| [2] | uint256 | The average stable borrow rate |

### burn

```solidity
function burn(address from, uint256 amount) external returns (uint256, uint256)
```

Burns debt of `user`

_The resulting rate is the weighted average between the rate of the new debt
and the rate of the previous debt
In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest the user earned_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount of debt tokens getting burned |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total stable debt |
| [1] | uint256 | The average stable borrow rate |

### getAverageStableRate

```solidity
function getAverageStableRate() external view returns (uint256)
```

Returns the average rate of all the stable rate loans.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The average stable rate |

### getUserStableRate

```solidity
function getUserStableRate(address user) external view returns (uint256)
```

Returns the stable rate of the user debt

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable rate of the user |

### getUserLastUpdated

```solidity
function getUserLastUpdated(address user) external view returns (uint40)
```

Returns the timestamp of the last update of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getSupplyData

```solidity
function getSupplyData() external view returns (uint256, uint256, uint256, uint40)
```

Returns the principal, the total supply, the average stable rate and the timestamp for the last update

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The principal |
| [1] | uint256 | The total supply |
| [2] | uint256 | The average stable rate |
| [3] | uint40 | The timestamp of the last update |

### getTotalSupplyLastUpdated

```solidity
function getTotalSupplyLastUpdated() external view returns (uint40)
```

Returns the timestamp of the last update of the total supply

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint40 | The timestamp |

### getTotalSupplyAndAvgRate

```solidity
function getTotalSupplyAndAvgRate() external view returns (uint256, uint256)
```

Returns the total supply and the average stable rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total supply |
| [1] | uint256 | The average rate |

### principalBalanceOf

```solidity
function principalBalanceOf(address user) external view returns (uint256)
```

Returns the principal debt balance of the user

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt balance of the user since the last burn/mint action |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this stableDebtToken (E.g. WETH for stableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

## IVariableDebtToken

Defines the basic interface for a variable debt token.

### mint

```solidity
function mint(address user, address onBehalfOf, uint256 amount, uint256 index) external returns (bool, uint256)
```

Mints debt token to the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address receiving the borrowed underlying, being the delegatee in case of credit delegate, or same as `onBehalfOf` otherwise |
| onBehalfOf | address | The address receiving the debt tokens |
| amount | uint256 | The amount of debt being minted |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the previous balance of the user is 0, false otherwise |
| [1] | uint256 | The scaled total debt of the reserve |

### burn

```solidity
function burn(address from, uint256 amount, uint256 index) external returns (uint256)
```

Burns user variable debt

_In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the debt will be burned |
| amount | uint256 | The amount getting burned |
| index | uint256 | The variable debt index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total debt of the reserve |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this debtToken (E.g. WETH for variableDebtWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

## VersionedInitializable

Helper contract to implement initializer functions. To use it, replace
the constructor with a function that has the `initializer` modifier.

_WARNING: Unlike constructors, initializer functions must be manually
invoked. This applies both to deploying an Initializable contract, as well
as extending an Initializable contract via inheritance.
WARNING: When used with inheritance, manual care must be taken to not invoke
a parent initializer twice, or ensure that all initializers are idempotent,
because this is not dealt with automatically as with constructors._

### initializer

```solidity
modifier initializer()
```

_Modifier to use in the initializer function of a contract._

### getRevision

```solidity
function getRevision() internal pure virtual returns (uint256)
```

Returns the revision number of the contract

_Needs to be defined in the inherited class as a constant._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The revision number |

## ReserveConfiguration

Implements the bitmap logic to handle the reserve configuration

### LTV_MASK

```solidity
uint256 LTV_MASK
```

### LIQUIDATION_THRESHOLD_MASK

```solidity
uint256 LIQUIDATION_THRESHOLD_MASK
```

### LIQUIDATION_BONUS_MASK

```solidity
uint256 LIQUIDATION_BONUS_MASK
```

### DECIMALS_MASK

```solidity
uint256 DECIMALS_MASK
```

### ACTIVE_MASK

```solidity
uint256 ACTIVE_MASK
```

### FROZEN_MASK

```solidity
uint256 FROZEN_MASK
```

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### STABLE_BORROWING_MASK

```solidity
uint256 STABLE_BORROWING_MASK
```

### PAUSED_MASK

```solidity
uint256 PAUSED_MASK
```

### BORROWABLE_IN_ISOLATION_MASK

```solidity
uint256 BORROWABLE_IN_ISOLATION_MASK
```

### SILOED_BORROWING_MASK

```solidity
uint256 SILOED_BORROWING_MASK
```

### FLASHLOAN_ENABLED_MASK

```solidity
uint256 FLASHLOAN_ENABLED_MASK
```

### RESERVE_FACTOR_MASK

```solidity
uint256 RESERVE_FACTOR_MASK
```

### BORROW_CAP_MASK

```solidity
uint256 BORROW_CAP_MASK
```

### SUPPLY_CAP_MASK

```solidity
uint256 SUPPLY_CAP_MASK
```

### LIQUIDATION_PROTOCOL_FEE_MASK

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_MASK
```

### EMODE_CATEGORY_MASK

```solidity
uint256 EMODE_CATEGORY_MASK
```

### UNBACKED_MINT_CAP_MASK

```solidity
uint256 UNBACKED_MINT_CAP_MASK
```

### DEBT_CEILING_MASK

```solidity
uint256 DEBT_CEILING_MASK
```

### LIQUIDATION_THRESHOLD_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_THRESHOLD_START_BIT_POSITION
```

_For the LTV, the start bit is 0 (up to 15), hence no bitshifting is needed_

### LIQUIDATION_BONUS_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_BONUS_START_BIT_POSITION
```

### RESERVE_DECIMALS_START_BIT_POSITION

```solidity
uint256 RESERVE_DECIMALS_START_BIT_POSITION
```

### IS_ACTIVE_START_BIT_POSITION

```solidity
uint256 IS_ACTIVE_START_BIT_POSITION
```

### IS_FROZEN_START_BIT_POSITION

```solidity
uint256 IS_FROZEN_START_BIT_POSITION
```

### BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 BORROWING_ENABLED_START_BIT_POSITION
```

### STABLE_BORROWING_ENABLED_START_BIT_POSITION

```solidity
uint256 STABLE_BORROWING_ENABLED_START_BIT_POSITION
```

### IS_PAUSED_START_BIT_POSITION

```solidity
uint256 IS_PAUSED_START_BIT_POSITION
```

### BORROWABLE_IN_ISOLATION_START_BIT_POSITION

```solidity
uint256 BORROWABLE_IN_ISOLATION_START_BIT_POSITION
```

### SILOED_BORROWING_START_BIT_POSITION

```solidity
uint256 SILOED_BORROWING_START_BIT_POSITION
```

### FLASHLOAN_ENABLED_START_BIT_POSITION

```solidity
uint256 FLASHLOAN_ENABLED_START_BIT_POSITION
```

### RESERVE_FACTOR_START_BIT_POSITION

```solidity
uint256 RESERVE_FACTOR_START_BIT_POSITION
```

### BORROW_CAP_START_BIT_POSITION

```solidity
uint256 BORROW_CAP_START_BIT_POSITION
```

### SUPPLY_CAP_START_BIT_POSITION

```solidity
uint256 SUPPLY_CAP_START_BIT_POSITION
```

### LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION

```solidity
uint256 LIQUIDATION_PROTOCOL_FEE_START_BIT_POSITION
```

### EMODE_CATEGORY_START_BIT_POSITION

```solidity
uint256 EMODE_CATEGORY_START_BIT_POSITION
```

### UNBACKED_MINT_CAP_START_BIT_POSITION

```solidity
uint256 UNBACKED_MINT_CAP_START_BIT_POSITION
```

### DEBT_CEILING_START_BIT_POSITION

```solidity
uint256 DEBT_CEILING_START_BIT_POSITION
```

### MAX_VALID_LTV

```solidity
uint256 MAX_VALID_LTV
```

### MAX_VALID_LIQUIDATION_THRESHOLD

```solidity
uint256 MAX_VALID_LIQUIDATION_THRESHOLD
```

### MAX_VALID_LIQUIDATION_BONUS

```solidity
uint256 MAX_VALID_LIQUIDATION_BONUS
```

### MAX_VALID_DECIMALS

```solidity
uint256 MAX_VALID_DECIMALS
```

### MAX_VALID_RESERVE_FACTOR

```solidity
uint256 MAX_VALID_RESERVE_FACTOR
```

### MAX_VALID_BORROW_CAP

```solidity
uint256 MAX_VALID_BORROW_CAP
```

### MAX_VALID_SUPPLY_CAP

```solidity
uint256 MAX_VALID_SUPPLY_CAP
```

### MAX_VALID_LIQUIDATION_PROTOCOL_FEE

```solidity
uint256 MAX_VALID_LIQUIDATION_PROTOCOL_FEE
```

### MAX_VALID_EMODE_CATEGORY

```solidity
uint256 MAX_VALID_EMODE_CATEGORY
```

### MAX_VALID_UNBACKED_MINT_CAP

```solidity
uint256 MAX_VALID_UNBACKED_MINT_CAP
```

### MAX_VALID_DEBT_CEILING

```solidity
uint256 MAX_VALID_DEBT_CEILING
```

### DEBT_CEILING_DECIMALS

```solidity
uint256 DEBT_CEILING_DECIMALS
```

### MAX_RESERVES_COUNT

```solidity
uint16 MAX_RESERVES_COUNT
```

### setLtv

```solidity
function setLtv(struct DataTypes.ReserveConfigurationMap self, uint256 ltv) internal pure
```

Sets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| ltv | uint256 | The new ltv |

### getLtv

```solidity
function getLtv(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the Loan to Value of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The loan to value |

### setLiquidationThreshold

```solidity
function setLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self, uint256 threshold) internal pure
```

Sets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| threshold | uint256 | The new liquidation threshold |

### getLiquidationThreshold

```solidity
function getLiquidationThreshold(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation threshold of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation threshold |

### setLiquidationBonus

```solidity
function setLiquidationBonus(struct DataTypes.ReserveConfigurationMap self, uint256 bonus) internal pure
```

Sets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| bonus | uint256 | The new liquidation bonus |

### getLiquidationBonus

```solidity
function getLiquidationBonus(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the liquidation bonus of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation bonus |

### setDecimals

```solidity
function setDecimals(struct DataTypes.ReserveConfigurationMap self, uint256 decimals) internal pure
```

Sets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| decimals | uint256 | The decimals |

### getDecimals

```solidity
function getDecimals(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the decimals of the underlying asset of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The decimals of the asset |

### setActive

```solidity
function setActive(struct DataTypes.ReserveConfigurationMap self, bool active) internal pure
```

Sets the active state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| active | bool | The active state |

### getActive

```solidity
function getActive(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the active state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The active state |

### setFrozen

```solidity
function setFrozen(struct DataTypes.ReserveConfigurationMap self, bool frozen) internal pure
```

Sets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| frozen | bool | The frozen state |

### getFrozen

```solidity
function getFrozen(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the frozen state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The frozen state |

### setPaused

```solidity
function setPaused(struct DataTypes.ReserveConfigurationMap self, bool paused) internal pure
```

Sets the paused state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| paused | bool | The paused state |

### getPaused

```solidity
function getPaused(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the paused state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The paused state |

### setBorrowableInIsolation

```solidity
function setBorrowableInIsolation(struct DataTypes.ReserveConfigurationMap self, bool borrowable) internal pure
```

Sets the borrowable in isolation flag for the reserve.

_When this flag is set to true, the asset will be borrowable against isolated collaterals and the borrowed
amount will be accumulated in the isolated collateral's total debt exposure.
Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
consistency in the debt ceiling calculations._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| borrowable | bool | True if the asset is borrowable |

### getBorrowableInIsolation

```solidity
function getBorrowableInIsolation(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the borrowable in isolation flag for the reserve.

_If the returned flag is true, the asset is borrowable against isolated collateral. Assets borrowed with
isolated collateral is accounted for in the isolated collateral's total debt exposure.
Only assets of the same family (eg USD stablecoins) should be borrowable in isolation mode to keep
consistency in the debt ceiling calculations._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The borrowable in isolation flag |

### setSiloedBorrowing

```solidity
function setSiloedBorrowing(struct DataTypes.ReserveConfigurationMap self, bool siloed) internal pure
```

Sets the siloed borrowing flag for the reserve.

_When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| siloed | bool | True if the asset is siloed |

### getSiloedBorrowing

```solidity
function getSiloedBorrowing(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the siloed borrowing flag for the reserve.

_When this flag is set to true, users borrowing this asset will not be allowed to borrow any other asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The siloed borrowing flag |

### setBorrowingEnabled

```solidity
function setBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self, bool enabled) internal pure
```

Enables or disables borrowing on the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| enabled | bool | True if the borrowing needs to be enabled, false otherwise |

### getBorrowingEnabled

```solidity
function getBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the borrowing state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The borrowing state |

### setStableRateBorrowingEnabled

```solidity
function setStableRateBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self, bool enabled) internal pure
```

Enables or disables stable rate borrowing on the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| enabled | bool | True if the stable rate borrowing needs to be enabled, false otherwise |

### getStableRateBorrowingEnabled

```solidity
function getStableRateBorrowingEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the stable rate borrowing state of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The stable rate borrowing state |

### setReserveFactor

```solidity
function setReserveFactor(struct DataTypes.ReserveConfigurationMap self, uint256 reserveFactor) internal pure
```

Sets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| reserveFactor | uint256 | The reserve factor |

### getReserveFactor

```solidity
function getReserveFactor(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the reserve factor of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve factor |

### setBorrowCap

```solidity
function setBorrowCap(struct DataTypes.ReserveConfigurationMap self, uint256 borrowCap) internal pure
```

Sets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| borrowCap | uint256 | The borrow cap |

### getBorrowCap

```solidity
function getBorrowCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the borrow cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The borrow cap |

### setSupplyCap

```solidity
function setSupplyCap(struct DataTypes.ReserveConfigurationMap self, uint256 supplyCap) internal pure
```

Sets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| supplyCap | uint256 | The supply cap |

### getSupplyCap

```solidity
function getSupplyCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the supply cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The supply cap |

### setDebtCeiling

```solidity
function setDebtCeiling(struct DataTypes.ReserveConfigurationMap self, uint256 ceiling) internal pure
```

Sets the debt ceiling in isolation mode for the asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| ceiling | uint256 | The maximum debt ceiling for the asset |

### getDebtCeiling

```solidity
function getDebtCeiling(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

Gets the debt ceiling for the asset if the asset is in isolation mode

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The debt ceiling (0 = isolation mode disabled) |

### setLiquidationProtocolFee

```solidity
function setLiquidationProtocolFee(struct DataTypes.ReserveConfigurationMap self, uint256 liquidationProtocolFee) internal pure
```

Sets the liquidation protocol fee of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| liquidationProtocolFee | uint256 | The liquidation protocol fee |

### getLiquidationProtocolFee

```solidity
function getLiquidationProtocolFee(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the liquidation protocol fee_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The liquidation protocol fee |

### setUnbackedMintCap

```solidity
function setUnbackedMintCap(struct DataTypes.ReserveConfigurationMap self, uint256 unbackedMintCap) internal pure
```

Sets the unbacked mint cap of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| unbackedMintCap | uint256 | The unbacked mint cap |

### getUnbackedMintCap

```solidity
function getUnbackedMintCap(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the unbacked mint cap of the reserve_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The unbacked mint cap |

### setEModeCategory

```solidity
function setEModeCategory(struct DataTypes.ReserveConfigurationMap self, uint256 category) internal pure
```

Sets the eMode asset category

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| category | uint256 | The asset category when the user selects the eMode |

### getEModeCategory

```solidity
function getEModeCategory(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256)
```

_Gets the eMode asset category_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode category for the asset |

### setFlashLoanEnabled

```solidity
function setFlashLoanEnabled(struct DataTypes.ReserveConfigurationMap self, bool flashLoanEnabled) internal pure
```

Sets the flashloanable flag for the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| flashLoanEnabled | bool | True if the asset is flashloanable, false otherwise |

### getFlashLoanEnabled

```solidity
function getFlashLoanEnabled(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool)
```

Gets the flashloanable flag for the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The flashloanable flag |

### getFlags

```solidity
function getFlags(struct DataTypes.ReserveConfigurationMap self) internal pure returns (bool, bool, bool, bool, bool)
```

Gets the configuration flags of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | The state flag representing active |
| [1] | bool | The state flag representing frozen |
| [2] | bool | The state flag representing borrowing enabled |
| [3] | bool | The state flag representing stableRateBorrowing enabled |
| [4] | bool | The state flag representing paused |

### getParams

```solidity
function getParams(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256, uint256, uint256, uint256, uint256)
```

Gets the configuration parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing ltv |
| [1] | uint256 | The state param representing liquidation threshold |
| [2] | uint256 | The state param representing liquidation bonus |
| [3] | uint256 | The state param representing reserve decimals |
| [4] | uint256 | The state param representing reserve factor |
| [5] | uint256 | The state param representing eMode category |

### getCaps

```solidity
function getCaps(struct DataTypes.ReserveConfigurationMap self) internal pure returns (uint256, uint256)
```

Gets the caps parameters of the reserve from storage

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The state param representing borrow cap |
| [1] | uint256 | The state param representing supply cap. |

## UserConfiguration

Implements the bitmap logic to handle the user configuration

### BORROWING_MASK

```solidity
uint256 BORROWING_MASK
```

### COLLATERAL_MASK

```solidity
uint256 COLLATERAL_MASK
```

### setBorrowing

```solidity
function setBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool borrowing) internal
```

Sets if the user is borrowing the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| borrowing | bool | True if the user is borrowing the reserve, false otherwise |

### setUsingAsCollateral

```solidity
function setUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex, bool usingAsCollateral) internal
```

Sets if the user is using as collateral the reserve identified by reserveIndex

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |
| usingAsCollateral | bool | True if the user is using the reserve as collateral, false otherwise |

### isUsingAsCollateralOrBorrowing

```solidity
function isUsingAsCollateralOrBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Returns if a user has been using the reserve for borrowing or as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing or as collateral, false otherwise |

### isBorrowing

```solidity
function isBorrowing(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve for borrowing

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve for borrowing, false otherwise |

### isUsingAsCollateral

```solidity
function isUsingAsCollateral(struct DataTypes.UserConfigurationMap self, uint256 reserveIndex) internal pure returns (bool)
```

Validate a user has been using the reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reserveIndex | uint256 | The index of the reserve in the bitmap |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been using a reserve as collateral, false otherwise |

### isUsingAsCollateralOne

```solidity
function isUsingAsCollateralOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying only one reserve as collateral

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isUsingAsCollateralAny

```solidity
function isUsingAsCollateralAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been supplying any reserve as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral any reserve, false otherwise |

### isBorrowingOne

```solidity
function isBorrowingOne(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing only one asset

_this uses a simple trick - if a number is a power of two (only one bit set) then n & (n - 1) == 0_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been supplying as collateral one reserve, false otherwise |

### isBorrowingAny

```solidity
function isBorrowingAny(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has been borrowing from any reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has been borrowing any reserve, false otherwise |

### isEmpty

```solidity
function isEmpty(struct DataTypes.UserConfigurationMap self) internal pure returns (bool)
```

Checks if a user has not been using any reserve for borrowing or supply

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has not been borrowing or supplying any reserve, false otherwise |

### getIsolationModeState

```solidity
function getIsolationModeState(struct DataTypes.UserConfigurationMap self, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList) internal view returns (bool, address, uint256)
```

Returns the Isolation Mode state of the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user is in isolation mode, false otherwise |
| [1] | address | The address of the only asset used as collateral |
| [2] | uint256 | The debt ceiling of the reserve |

### getSiloedBorrowingState

```solidity
function getSiloedBorrowingState(struct DataTypes.UserConfigurationMap self, mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList) internal view returns (bool, address)
```

Returns the siloed borrowing state for the user

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The data of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The reserve list |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the user has borrowed a siloed asset, false otherwise |
| [1] | address | The address of the only borrowed asset |

### _getFirstAssetIdByMask

```solidity
function _getFirstAssetIdByMask(struct DataTypes.UserConfigurationMap self, uint256 mask) internal pure returns (uint256)
```

Returns the address of the first asset flagged in the bitmap given the corresponding bitmask

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| self | struct DataTypes.UserConfigurationMap | The configuration object |
| mask | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The index of the first asset flagged in the bitmap once the corresponding mask is applied |

## Errors

Defines the error messages emitted by the different contracts of the Aave protocol

### CALLER_NOT_POOL_ADMIN

```solidity
string CALLER_NOT_POOL_ADMIN
```

### CALLER_NOT_EMERGENCY_ADMIN

```solidity
string CALLER_NOT_EMERGENCY_ADMIN
```

### CALLER_NOT_POOL_OR_EMERGENCY_ADMIN

```solidity
string CALLER_NOT_POOL_OR_EMERGENCY_ADMIN
```

### CALLER_NOT_RISK_OR_POOL_ADMIN

```solidity
string CALLER_NOT_RISK_OR_POOL_ADMIN
```

### CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN

```solidity
string CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN
```

### CALLER_NOT_BRIDGE

```solidity
string CALLER_NOT_BRIDGE
```

### ADDRESSES_PROVIDER_NOT_REGISTERED

```solidity
string ADDRESSES_PROVIDER_NOT_REGISTERED
```

### INVALID_ADDRESSES_PROVIDER_ID

```solidity
string INVALID_ADDRESSES_PROVIDER_ID
```

### NOT_CONTRACT

```solidity
string NOT_CONTRACT
```

### CALLER_NOT_POOL_CONFIGURATOR

```solidity
string CALLER_NOT_POOL_CONFIGURATOR
```

### CALLER_NOT_ATOKEN

```solidity
string CALLER_NOT_ATOKEN
```

### INVALID_ADDRESSES_PROVIDER

```solidity
string INVALID_ADDRESSES_PROVIDER
```

### INVALID_FLASHLOAN_EXECUTOR_RETURN

```solidity
string INVALID_FLASHLOAN_EXECUTOR_RETURN
```

### RESERVE_ALREADY_ADDED

```solidity
string RESERVE_ALREADY_ADDED
```

### NO_MORE_RESERVES_ALLOWED

```solidity
string NO_MORE_RESERVES_ALLOWED
```

### EMODE_CATEGORY_RESERVED

```solidity
string EMODE_CATEGORY_RESERVED
```

### INVALID_EMODE_CATEGORY_ASSIGNMENT

```solidity
string INVALID_EMODE_CATEGORY_ASSIGNMENT
```

### RESERVE_LIQUIDITY_NOT_ZERO

```solidity
string RESERVE_LIQUIDITY_NOT_ZERO
```

### FLASHLOAN_PREMIUM_INVALID

```solidity
string FLASHLOAN_PREMIUM_INVALID
```

### INVALID_RESERVE_PARAMS

```solidity
string INVALID_RESERVE_PARAMS
```

### INVALID_EMODE_CATEGORY_PARAMS

```solidity
string INVALID_EMODE_CATEGORY_PARAMS
```

### BRIDGE_PROTOCOL_FEE_INVALID

```solidity
string BRIDGE_PROTOCOL_FEE_INVALID
```

### CALLER_MUST_BE_POOL

```solidity
string CALLER_MUST_BE_POOL
```

### INVALID_MINT_AMOUNT

```solidity
string INVALID_MINT_AMOUNT
```

### INVALID_BURN_AMOUNT

```solidity
string INVALID_BURN_AMOUNT
```

### INVALID_AMOUNT

```solidity
string INVALID_AMOUNT
```

### RESERVE_INACTIVE

```solidity
string RESERVE_INACTIVE
```

### RESERVE_FROZEN

```solidity
string RESERVE_FROZEN
```

### RESERVE_PAUSED

```solidity
string RESERVE_PAUSED
```

### BORROWING_NOT_ENABLED

```solidity
string BORROWING_NOT_ENABLED
```

### STABLE_BORROWING_NOT_ENABLED

```solidity
string STABLE_BORROWING_NOT_ENABLED
```

### NOT_ENOUGH_AVAILABLE_USER_BALANCE

```solidity
string NOT_ENOUGH_AVAILABLE_USER_BALANCE
```

### INVALID_INTEREST_RATE_MODE_SELECTED

```solidity
string INVALID_INTEREST_RATE_MODE_SELECTED
```

### COLLATERAL_BALANCE_IS_ZERO

```solidity
string COLLATERAL_BALANCE_IS_ZERO
```

### HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD

```solidity
string HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD
```

### COLLATERAL_CANNOT_COVER_NEW_BORROW

```solidity
string COLLATERAL_CANNOT_COVER_NEW_BORROW
```

### COLLATERAL_SAME_AS_BORROWING_CURRENCY

```solidity
string COLLATERAL_SAME_AS_BORROWING_CURRENCY
```

### AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE

```solidity
string AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE
```

### NO_DEBT_OF_SELECTED_TYPE

```solidity
string NO_DEBT_OF_SELECTED_TYPE
```

### NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF

```solidity
string NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF
```

### NO_OUTSTANDING_STABLE_DEBT

```solidity
string NO_OUTSTANDING_STABLE_DEBT
```

### NO_OUTSTANDING_VARIABLE_DEBT

```solidity
string NO_OUTSTANDING_VARIABLE_DEBT
```

### UNDERLYING_BALANCE_ZERO

```solidity
string UNDERLYING_BALANCE_ZERO
```

### INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET

```solidity
string INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET
```

### HEALTH_FACTOR_NOT_BELOW_THRESHOLD

```solidity
string HEALTH_FACTOR_NOT_BELOW_THRESHOLD
```

### COLLATERAL_CANNOT_BE_LIQUIDATED

```solidity
string COLLATERAL_CANNOT_BE_LIQUIDATED
```

### SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER

```solidity
string SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER
```

### INCONSISTENT_FLASHLOAN_PARAMS

```solidity
string INCONSISTENT_FLASHLOAN_PARAMS
```

### BORROW_CAP_EXCEEDED

```solidity
string BORROW_CAP_EXCEEDED
```

### SUPPLY_CAP_EXCEEDED

```solidity
string SUPPLY_CAP_EXCEEDED
```

### UNBACKED_MINT_CAP_EXCEEDED

```solidity
string UNBACKED_MINT_CAP_EXCEEDED
```

### DEBT_CEILING_EXCEEDED

```solidity
string DEBT_CEILING_EXCEEDED
```

### UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO

```solidity
string UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO
```

### STABLE_DEBT_NOT_ZERO

```solidity
string STABLE_DEBT_NOT_ZERO
```

### VARIABLE_DEBT_SUPPLY_NOT_ZERO

```solidity
string VARIABLE_DEBT_SUPPLY_NOT_ZERO
```

### LTV_VALIDATION_FAILED

```solidity
string LTV_VALIDATION_FAILED
```

### INCONSISTENT_EMODE_CATEGORY

```solidity
string INCONSISTENT_EMODE_CATEGORY
```

### PRICE_ORACLE_SENTINEL_CHECK_FAILED

```solidity
string PRICE_ORACLE_SENTINEL_CHECK_FAILED
```

### ASSET_NOT_BORROWABLE_IN_ISOLATION

```solidity
string ASSET_NOT_BORROWABLE_IN_ISOLATION
```

### RESERVE_ALREADY_INITIALIZED

```solidity
string RESERVE_ALREADY_INITIALIZED
```

### USER_IN_ISOLATION_MODE_OR_LTV_ZERO

```solidity
string USER_IN_ISOLATION_MODE_OR_LTV_ZERO
```

### INVALID_LTV

```solidity
string INVALID_LTV
```

### INVALID_LIQ_THRESHOLD

```solidity
string INVALID_LIQ_THRESHOLD
```

### INVALID_LIQ_BONUS

```solidity
string INVALID_LIQ_BONUS
```

### INVALID_DECIMALS

```solidity
string INVALID_DECIMALS
```

### INVALID_RESERVE_FACTOR

```solidity
string INVALID_RESERVE_FACTOR
```

### INVALID_BORROW_CAP

```solidity
string INVALID_BORROW_CAP
```

### INVALID_SUPPLY_CAP

```solidity
string INVALID_SUPPLY_CAP
```

### INVALID_LIQUIDATION_PROTOCOL_FEE

```solidity
string INVALID_LIQUIDATION_PROTOCOL_FEE
```

### INVALID_EMODE_CATEGORY

```solidity
string INVALID_EMODE_CATEGORY
```

### INVALID_UNBACKED_MINT_CAP

```solidity
string INVALID_UNBACKED_MINT_CAP
```

### INVALID_DEBT_CEILING

```solidity
string INVALID_DEBT_CEILING
```

### INVALID_RESERVE_INDEX

```solidity
string INVALID_RESERVE_INDEX
```

### ACL_ADMIN_CANNOT_BE_ZERO

```solidity
string ACL_ADMIN_CANNOT_BE_ZERO
```

### INCONSISTENT_PARAMS_LENGTH

```solidity
string INCONSISTENT_PARAMS_LENGTH
```

### ZERO_ADDRESS_NOT_VALID

```solidity
string ZERO_ADDRESS_NOT_VALID
```

### INVALID_EXPIRATION

```solidity
string INVALID_EXPIRATION
```

### INVALID_SIGNATURE

```solidity
string INVALID_SIGNATURE
```

### OPERATION_NOT_SUPPORTED

```solidity
string OPERATION_NOT_SUPPORTED
```

### DEBT_CEILING_NOT_ZERO

```solidity
string DEBT_CEILING_NOT_ZERO
```

### ASSET_NOT_LISTED

```solidity
string ASSET_NOT_LISTED
```

### INVALID_OPTIMAL_USAGE_RATIO

```solidity
string INVALID_OPTIMAL_USAGE_RATIO
```

### INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO

```solidity
string INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO
```

### UNDERLYING_CANNOT_BE_RESCUED

```solidity
string UNDERLYING_CANNOT_BE_RESCUED
```

### ADDRESSES_PROVIDER_ALREADY_ADDED

```solidity
string ADDRESSES_PROVIDER_ALREADY_ADDED
```

### POOL_ADDRESSES_DO_NOT_MATCH

```solidity
string POOL_ADDRESSES_DO_NOT_MATCH
```

### STABLE_BORROWING_ENABLED

```solidity
string STABLE_BORROWING_ENABLED
```

### SILOED_BORROWING_VIOLATION

```solidity
string SILOED_BORROWING_VIOLATION
```

### RESERVE_DEBT_NOT_ZERO

```solidity
string RESERVE_DEBT_NOT_ZERO
```

### FLASHLOAN_DISABLED

```solidity
string FLASHLOAN_DISABLED
```

## Helpers

### getUserCurrentDebt

```solidity
function getUserCurrentDebt(address user, struct DataTypes.ReserveCache reserveCache) internal view returns (uint256, uint256)
```

Fetches the user current stable and variable debt balances

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |
| reserveCache | struct DataTypes.ReserveCache | The reserve cache data object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The stable debt balance |
| [1] | uint256 | The variable debt balance |

## BlastLogic

Implements the logic for updating blast logic

### compoundYield

```solidity
function compoundYield(mapping(address => struct DataTypes.ReserveData) reservesData, address asset) external
```

## BorrowLogic

Implements the base logic for all the actions related to borrowing

### Borrow

```solidity
event Borrow(address reserve, address user, address onBehalfOf, uint256 amount, enum DataTypes.InterestRateMode interestRateMode, uint256 borrowRate, uint16 referralCode)
```

### Repay

```solidity
event Repay(address reserve, address user, address repayer, uint256 amount, bool useATokens)
```

### RebalanceStableBorrowRate

```solidity
event RebalanceStableBorrowRate(address reserve, address user)
```

### SwapBorrowRateMode

```solidity
event SwapBorrowRateMode(address reserve, address user, enum DataTypes.InterestRateMode interestRateMode)
```

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### executeBorrow

```solidity
function executeBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteBorrowParams params) public
```

Implements the borrow feature. Borrowing allows users that provided collateral to draw liquidity from the
Aave protocol proportionally to their collateralization power. For isolated positions, it also increases the
isolated debt.

_Emits the `Borrow()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteBorrowParams | The additional parameters needed to execute the borrow function |

### executeRepay

```solidity
function executeRepay(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteRepayParams params) external returns (uint256)
```

Implements the repay feature. Repaying transfers the underlying back to the aToken and clears the
equivalent amount of debt for the user by burning the corresponding debt token. For isolated positions, it also
reduces the isolated debt.

_Emits the `Repay()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteRepayParams | The additional parameters needed to execute the repay function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount being repaid |

### executeRebalanceStableBorrowRate

```solidity
function executeRebalanceStableBorrowRate(struct DataTypes.ReserveData reserve, address asset, address user) external
```

Implements the rebalance stable borrow rate feature. In case of liquidity crunches on the protocol, stable
rate borrows might need to be rebalanced to bring back equilibrium between the borrow and supply APYs.

_The rules that define if a position can be rebalanced are implemented in `ValidationLogic.validateRebalanceStableBorrowRate()`
Emits the `RebalanceStableBorrowRate()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the reserve of the asset being repaid |
| asset | address | The asset of the position being rebalanced |
| user | address | The user being rebalanced |

### executeSwapBorrowRateMode

```solidity
function executeSwapBorrowRateMode(struct DataTypes.ReserveData reserve, struct DataTypes.UserConfigurationMap userConfig, address asset, enum DataTypes.InterestRateMode interestRateMode) external
```

Implements the swap borrow rate feature. Borrowers can swap from variable to stable positions at any time.

_Emits the `Swap()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The of the reserve of the asset being repaid |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| asset | address | The asset of the position being swapped |
| interestRateMode | enum DataTypes.InterestRateMode | The current interest rate mode of the position being swapped |

## BridgeLogic

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

### MintUnbacked

```solidity
event MintUnbacked(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

### BackUnbacked

```solidity
event BackUnbacked(address reserve, address backer, uint256 amount, uint256 fee)
```

### executeMintUnbacked

```solidity
function executeMintUnbacked(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external
```

Mint unbacked aTokens to a user and updates the unbacked for the reserve.

_Essentially a supply without transferring the underlying.
Emits the `MintUnbacked` event
Emits the `ReserveUsedAsCollateralEnabled` if asset is set as collateral_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| asset | address | The address of the underlying asset to mint aTokens of |
| amount | uint256 | The amount to mint |
| onBehalfOf | address | The address that will receive the aTokens |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### executeBackUnbacked

```solidity
function executeBackUnbacked(struct DataTypes.ReserveData reserve, address asset, uint256 amount, uint256 fee, uint256 protocolFeeBps) external returns (uint256)
```

Back the current unbacked with `amount` and pay `fee`.

_It is not possible to back more than the existing unbacked amount of the reserve
Emits the `BackUnbacked` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve to back unbacked for |
| asset | address | The address of the underlying asset to repay |
| amount | uint256 | The amount to back |
| fee | uint256 | The amount paid in fees |
| protocolFeeBps | uint256 | The fraction of fees in basis points paid to the protocol |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The backed amount |

## EModeLogic

Implements the base logic for all the actions related to the eMode

### UserEModeSet

```solidity
event UserEModeSet(address user, uint8 categoryId)
```

### executeSetUserEMode

```solidity
function executeSetUserEMode(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, mapping(address => uint8) usersEModeCategory, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteSetUserEModeParams params) external
```

Updates the user efficiency mode category

_Will revert if user is borrowing non-compatible asset or change will drop HF < HEALTH_FACTOR_LIQUIDATION_THRESHOLD
Emits the `UserEModeSet` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| usersEModeCategory | mapping(address &#x3D;&gt; uint8) | The state of all users efficiency mode category |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteSetUserEModeParams | The additional parameters needed to execute the setUserEMode function |

### getEModeConfiguration

```solidity
function getEModeConfiguration(struct DataTypes.EModeCategory category, contract IPriceOracleGetter oracle) internal view returns (uint256, uint256, uint256)
```

Gets the eMode configuration and calculates the eMode asset price if a custom oracle is configured

_The eMode asset price returned is 0 if no oracle is specified_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| category | struct DataTypes.EModeCategory | The user eMode category |
| oracle | contract IPriceOracleGetter | The price oracle |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode ltv |
| [1] | uint256 | The eMode liquidation threshold |
| [2] | uint256 | The eMode asset price |

### isInEModeCategory

```solidity
function isInEModeCategory(uint256 eModeUserCategory, uint256 eModeAssetCategory) internal pure returns (bool)
```

Checks if eMode is active for a user and if yes, if the asset belongs to the eMode category chosen

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| eModeUserCategory | uint256 | The user eMode category |
| eModeAssetCategory | uint256 | The asset eMode category |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if eMode is active and the asset belongs to the eMode category chosen by the user, false otherwise |

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

## GenericLogic

Implements protocol-level logic to calculate and validate the state of a user

### CalculateUserAccountDataVars

```solidity
struct CalculateUserAccountDataVars {
  uint256 assetPrice;
  uint256 assetUnit;
  uint256 userBalanceInBaseCurrency;
  uint256 decimals;
  uint256 ltv;
  uint256 liquidationThreshold;
  uint256 i;
  uint256 healthFactor;
  uint256 totalCollateralInBaseCurrency;
  uint256 totalDebtInBaseCurrency;
  uint256 avgLtv;
  uint256 avgLiquidationThreshold;
  uint256 eModeAssetPrice;
  uint256 eModeLtv;
  uint256 eModeLiqThreshold;
  uint256 eModeAssetCategory;
  address currentReserveAddress;
  bool hasZeroLtvCollateral;
  bool isInEModeCategory;
}
```

### calculateUserAccountData

```solidity
function calculateUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.CalculateUserAccountDataParams params) internal view returns (uint256, uint256, uint256, uint256, uint256, bool)
```

Calculates the user data across the reserves.

_It includes the total liquidity/collateral/borrow balances in the base currency used by the price feed,
the average Loan To Value, the average Liquidation Ratio, and the Health factor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional parameters needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total collateral of the user in the base currency used by the price feed |
| [1] | uint256 | The total debt of the user in the base currency used by the price feed |
| [2] | uint256 | The average ltv of the user |
| [3] | uint256 | The average liquidation threshold of the user |
| [4] | uint256 | The health factor of the user |
| [5] | bool | True if the ltv is zero, false otherwise |

### calculateAvailableBorrows

```solidity
function calculateAvailableBorrows(uint256 totalCollateralInBaseCurrency, uint256 totalDebtInBaseCurrency, uint256 ltv) internal pure returns (uint256)
```

Calculates the maximum amount that can be borrowed depending on the available collateral, the total debt
and the average Loan To Value

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralInBaseCurrency | uint256 | The total collateral in the base currency used by the price feed |
| totalDebtInBaseCurrency | uint256 | The total borrow balance in the base currency used by the price feed |
| ltv | uint256 | The average loan to value |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The amount available to borrow in the base currency of the used by the price feed |

## IsolationModeLogic

Implements the base logic for handling repayments for assets borrowed in isolation mode

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### updateIsolatedDebtIfIsolated

```solidity
function updateIsolatedDebtIfIsolated(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveCache reserveCache, uint256 repayAmount) internal
```

updated the isolated debt whenever a position collateralized by an isolated asset is repaid or liquidated

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| repayAmount | uint256 | The amount being repaid |

## LiquidationLogic

Implements actions involving management of collateral in the protocol, the main one being the liquidations

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

### LiquidationCall

```solidity
event LiquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, uint256 liquidatedCollateralAmount, address liquidator, bool receiveAToken)
```

### DEFAULT_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 DEFAULT_LIQUIDATION_CLOSE_FACTOR
```

_Default percentage of borrower's debt to be repaid in a liquidation.
Percentage applied when the users health factor is above `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 0.5e4 results in 50.00%_

### MAX_LIQUIDATION_CLOSE_FACTOR

```solidity
uint256 MAX_LIQUIDATION_CLOSE_FACTOR
```

_Maximum percentage of borrower's debt to be repaid in a liquidation
Percentage applied when the users health factor is below `CLOSE_FACTOR_HF_THRESHOLD`
Expressed in bps, a value of 1e4 results in 100.00%_

### CLOSE_FACTOR_HF_THRESHOLD

```solidity
uint256 CLOSE_FACTOR_HF_THRESHOLD
```

_This constant represents below which health factor value it is possible to liquidate
an amount of debt corresponding to `MAX_LIQUIDATION_CLOSE_FACTOR`.
A value of 0.95e18 results in 0.95_

### LiquidationCallLocalVars

```solidity
struct LiquidationCallLocalVars {
  uint256 userCollateralBalance;
  uint256 userVariableDebt;
  uint256 userTotalDebt;
  uint256 actualDebtToLiquidate;
  uint256 actualCollateralToLiquidate;
  uint256 liquidationBonus;
  uint256 healthFactor;
  uint256 liquidationProtocolFeeAmount;
  address collateralPriceSource;
  address debtPriceSource;
  contract IAToken collateralAToken;
  struct DataTypes.ReserveCache debtReserveCache;
}
```

### executeLiquidationCall

```solidity
function executeLiquidationCall(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(address => struct DataTypes.UserConfigurationMap) usersConfig, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.ExecuteLiquidationCallParams params) external
```

Function to liquidate a position if its Health Factor drops below 1. The caller (liquidator)
covers `debtToCover` amount of debt of the user getting liquidated, and receives
a proportional amount of the `collateralAsset` plus a bonus to cover market risk

_Emits the `LiquidationCall()` event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| usersConfig | mapping(address &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |

### _burnCollateralATokens

```solidity
function _burnCollateralATokens(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the collateral aTokens and transfers the underlying to the liquidator.

_The function also updates the state and the interest rate of the collateral reserve._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | The executeLiquidationCall() function local vars |

### _liquidateATokens

```solidity
function _liquidateATokens(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(address => struct DataTypes.UserConfigurationMap) usersConfig, struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Liquidates the user aTokens by transferring them to the liquidator.

_The function also checks the state of the liquidator and activates the aToken as collateral
       as in standard transfers if the isolation mode constraints are respected._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| usersConfig | mapping(address &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | The executeLiquidationCall() function local vars |

### _burnDebtTokens

```solidity
function _burnDebtTokens(struct DataTypes.ExecuteLiquidationCallParams params, struct LiquidationLogic.LiquidationCallLocalVars vars) internal
```

Burns the debt tokens of the user up to the amount being repaid by the liquidator.

_The function alters the `debtReserveCache` state in `vars` to update the debt related data._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| vars | struct LiquidationLogic.LiquidationCallLocalVars | the executeLiquidationCall() function local vars |

### _calculateDebt

```solidity
function _calculateDebt(struct DataTypes.ReserveCache debtReserveCache, struct DataTypes.ExecuteLiquidationCallParams params, uint256 healthFactor) internal view returns (uint256, uint256, uint256)
```

Calculates the total debt of the user and the actual amount to liquidate depending on the health factor
and corresponding close factor.

_If the Health Factor is below CLOSE_FACTOR_HF_THRESHOLD, the close factor is increased to MAX_LIQUIDATION_CLOSE_FACTOR_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| debtReserveCache | struct DataTypes.ReserveCache | The reserve cache data object of the debt reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |
| healthFactor | uint256 | The health factor of the position |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The variable debt of the user |
| [1] | uint256 | The total debt of the user |
| [2] | uint256 | The actual debt to liquidate as a function of the closeFactor |

### _getConfigurationData

```solidity
function _getConfigurationData(mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.ReserveData collateralReserve, struct DataTypes.ExecuteLiquidationCallParams params) internal view returns (contract IAToken, address, address, uint256)
```

Returns the configuration data for the debt and the collateral reserves.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| params | struct DataTypes.ExecuteLiquidationCallParams | The additional parameters needed to execute the liquidation function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IAToken | The collateral aToken |
| [1] | address | The address to use as price source for the collateral |
| [2] | address | The address to use as price source for the debt |
| [3] | uint256 | The liquidation bonus to apply to the collateral |

### AvailableCollateralToLiquidateLocalVars

```solidity
struct AvailableCollateralToLiquidateLocalVars {
  uint256 collateralPrice;
  uint256 debtAssetPrice;
  uint256 maxCollateralToLiquidate;
  uint256 baseCollateral;
  uint256 bonusCollateral;
  uint256 debtAssetDecimals;
  uint256 collateralDecimals;
  uint256 collateralAssetUnit;
  uint256 debtAssetUnit;
  uint256 collateralAmount;
  uint256 debtAmountNeeded;
  uint256 liquidationProtocolFeePercentage;
  uint256 liquidationProtocolFee;
}
```

### _calculateAvailableCollateralToLiquidate

```solidity
function _calculateAvailableCollateralToLiquidate(struct DataTypes.ReserveData collateralReserve, struct DataTypes.ReserveCache debtReserveCache, address collateralAsset, address debtAsset, uint256 debtToCover, uint256 userCollateralBalance, uint256 liquidationBonus, contract IPriceOracleGetter oracle) internal view returns (uint256, uint256, uint256)
```

Calculates how much of a specific collateral can be liquidated, given
a certain amount of debt asset.

_This function needs to be called after all the checks to validate the liquidation have been performed,
  otherwise it might fail._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralReserve | struct DataTypes.ReserveData | The data of the collateral reserve |
| debtReserveCache | struct DataTypes.ReserveCache | The cached data of the debt reserve |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| userCollateralBalance | uint256 | The collateral balance for the specific `collateralAsset` of the user being liquidated |
| liquidationBonus | uint256 | The collateral bonus percentage to receive as result of the liquidation |
| oracle | contract IPriceOracleGetter |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The maximum amount that is possible to liquidate given all the liquidation constraints (user balance, close factor) |
| [1] | uint256 | The amount to repay with the liquidation |
| [2] | uint256 | The fee taken from the liquidation bonus amount to be paid to the protocol |

## PoolLogic

Implements the logic for Pool specific functions

### MintedToTreasury

```solidity
event MintedToTreasury(address reserve, uint256 amountMinted)
```

### IsolationModeTotalDebtUpdated

```solidity
event IsolationModeTotalDebtUpdated(address asset, uint256 totalDebt)
```

### executeInitReserve

```solidity
function executeInitReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.InitReserveParams params) external returns (bool)
```

Initialize an asset reserve and add the reserve to the list of reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| params | struct DataTypes.InitReserveParams | Additional parameters needed for initiation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true if appended, false if inserted at existing empty spot |

### executeRescueTokens

```solidity
function executeRescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

### executeMintToTreasury

```solidity
function executeMintToTreasury(mapping(address => struct DataTypes.ReserveData) reservesData, address[] assets) external
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### executeResetIsolationModeTotalDebt

```solidity
function executeResetIsolationModeTotalDebt(mapping(address => struct DataTypes.ReserveData) reservesData, address asset) external
```

Resets the isolation mode total debt of the given asset to zero

_It requires the given asset has zero debt ceiling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| asset | address | The address of the underlying asset to reset the isolationModeTotalDebt |

### executeDropReserve

```solidity
function executeDropReserve(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, address asset) external
```

Drop a reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| asset | address | The address of the underlying asset of the reserve |

### executeGetUserAccountData

```solidity
function executeGetUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.CalculateUserAccountDataParams params) external view returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional params needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

## ReserveLogic

Implements the logic to update the reserves state

### ReserveDataUpdated

```solidity
event ReserveDataUpdated(address reserve, uint256 liquidityRate, uint256 stableBorrowRate, uint256 variableBorrowRate, uint256 liquidityIndex, uint256 variableBorrowIndex)
```

### getNormalizedIncome

```solidity
function getNormalizedIncome(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized income for the reserve.

_A value of 1e27 means there is no income. As time passes, the income is accrued
A value of 2*1e27 means for each unit of asset one unit of income has been accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized income, expressed in ray |

### getNormalizedDebt

```solidity
function getNormalizedDebt(struct DataTypes.ReserveData reserve) internal view returns (uint256)
```

Returns the ongoing normalized variable debt for the reserve.

_A value of 1e27 means there is no debt. As time passes, the debt is accrued
A value of 2*1e27 means that for each unit of debt, one unit worth of interest has been accumulated_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The normalized variable debt, expressed in ray |

### updateState

```solidity
function updateState(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the liquidity cumulative index and the variable borrow index.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### cumulateToLiquidityIndex

```solidity
function cumulateToLiquidityIndex(struct DataTypes.ReserveData reserve, uint256 totalLiquidity, uint256 amount) internal returns (uint256)
```

Accumulates a predefined amount of asset to the reserve as a fixed, instantaneous income. Used for example
to accumulate the flashloan fee to the reserve, and spread it between all the suppliers.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| totalLiquidity | uint256 | The total liquidity available in the reserve |
| amount | uint256 | The amount to accumulate |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The next liquidity index of the reserve |

### init

```solidity
function init(struct DataTypes.ReserveData reserve, address aTokenAddress, address stableDebtTokenAddress, address variableDebtTokenAddress, address interestRateStrategyAddress) internal
```

Initializes a reserve.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |
| aTokenAddress | address | The address of the overlying atoken contract |
| stableDebtTokenAddress | address | The address of the overlying stable debt token contract |
| variableDebtTokenAddress | address | The address of the overlying variable debt token contract |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### UpdateInterestRatesLocalVars

```solidity
struct UpdateInterestRatesLocalVars {
  uint256 nextLiquidityRate;
  uint256 nextStableRate;
  uint256 nextVariableRate;
  uint256 totalVariableDebt;
}
```

### updateInterestRates

```solidity
function updateInterestRates(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, address reserveAddress, uint256 liquidityAdded, uint256 liquidityTaken) internal
```

Updates the reserve current stable borrow rate, the current variable borrow rate and the current liquidity rate.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |
| reserveAddress | address | The address of the reserve to be updated |
| liquidityAdded | uint256 | The amount of liquidity added to the protocol (supply or repay) in the previous action |
| liquidityTaken | uint256 | The amount of liquidity taken from the protocol (redeem or borrow) |

### AccrueToTreasuryLocalVars

```solidity
struct AccrueToTreasuryLocalVars {
  uint256 prevTotalStableDebt;
  uint256 prevTotalVariableDebt;
  uint256 currTotalVariableDebt;
  uint256 cumulatedStableInterest;
  uint256 totalDebtAccrued;
  uint256 amountToMint;
}
```

### _accrueToTreasury

```solidity
function _accrueToTreasury(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Mints part of the repaid interest to the reserve treasury as a function of the reserve factor for the
specific asset.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The caching layer for the reserve data |

### _updateIndexes

```solidity
function _updateIndexes(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache) internal
```

Updates the reserve indexes and the timestamp of the update.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve reserve to be updated |
| reserveCache | struct DataTypes.ReserveCache | The cache layer holding the cached protocol data |

### cache

```solidity
function cache(struct DataTypes.ReserveData reserve) internal view returns (struct DataTypes.ReserveCache)
```

Creates a cache object to avoid repeated storage reads and external contract calls when updating state and
interest rates.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object for which the cache will be filled |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveCache | The cache object |

## SupplyLogic

Implements the base logic for supply/withdraw

### ReserveUsedAsCollateralEnabled

```solidity
event ReserveUsedAsCollateralEnabled(address reserve, address user)
```

### ReserveUsedAsCollateralDisabled

```solidity
event ReserveUsedAsCollateralDisabled(address reserve, address user)
```

### Withdraw

```solidity
event Withdraw(address reserve, address user, address to, uint256 amount)
```

### Supply

```solidity
event Supply(address reserve, address user, address onBehalfOf, uint256 amount, uint16 referralCode)
```

### executeSupply

```solidity
function executeSupply(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteSupplyParams params) external
```

Implements the supply feature. Through `supply()`, users supply assets to the Aave protocol.

_Emits the `Supply()` event.
In the first supply action, `ReserveUsedAsCollateralEnabled()` is emitted, if the asset can be enabled as
collateral._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteSupplyParams | The additional parameters needed to execute the supply function |

### executeWithdraw

```solidity
function executeWithdraw(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ExecuteWithdrawParams params) external returns (uint256)
```

Implements the withdraw feature. Through `withdraw()`, users redeem their aTokens for the underlying asset
previously supplied in the Aave protocol.

_Emits the `Withdraw()` event.
If the user withdraws everything, `ReserveUsedAsCollateralDisabled()` is emitted._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping that tracks the supplied/borrowed assets |
| params | struct DataTypes.ExecuteWithdrawParams | The additional parameters needed to execute the withdraw function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The actual amount withdrawn |

### executeFinalizeTransfer

```solidity
function executeFinalizeTransfer(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, mapping(address => struct DataTypes.UserConfigurationMap) usersConfig, struct DataTypes.FinalizeTransferParams params) external
```

Validates a transfer of aTokens. The sender is subjected to health factor validation to avoid
collateralization constraints violation.

_Emits the `ReserveUsedAsCollateralEnabled()` event for the `to` account, if the asset is being activated as
collateral.
In case the `from` user transfers everything, `ReserveUsedAsCollateralDisabled()` is emitted for `from`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| usersConfig | mapping(address &#x3D;&gt; struct DataTypes.UserConfigurationMap) | The users configuration mapping that track the supplied/borrowed assets |
| params | struct DataTypes.FinalizeTransferParams | The additional parameters needed to execute the finalizeTransfer function |

### executeUseReserveAsCollateral

```solidity
function executeUseReserveAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address asset, bool useAsCollateral, uint256 reservesCount, address priceOracle, uint8 userEModeCategory) external
```

Executes the 'set as collateral' feature. A user can choose to activate or deactivate an asset as
collateral at any point in time. Deactivating an asset as collateral is subjected to the usual health factor
checks to ensure collateralization.

_Emits the `ReserveUsedAsCollateralEnabled()` event if the asset can be activated as collateral.
In case the asset is being deactivated as collateral, `ReserveUsedAsCollateralDisabled()` is emitted._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The users configuration mapping that track the supplied/borrowed assets |
| asset | address | The address of the asset being configured as collateral |
| useAsCollateral | bool | True if the user wants to set the asset as collateral, false otherwise |
| reservesCount | uint256 | The number of initialized reserves |
| priceOracle | address | The address of the price oracle |
| userEModeCategory | uint8 | The eMode category chosen by the user |

## ValidationLogic

Implements functions to validate the different actions of the protocol

### REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD

```solidity
uint256 REBALANCE_UP_LIQUIDITY_RATE_THRESHOLD
```

### MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 MINIMUM_HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

### HEALTH_FACTOR_LIQUIDATION_THRESHOLD

```solidity
uint256 HEALTH_FACTOR_LIQUIDATION_THRESHOLD
```

_Minimum health factor to consider a user position healthy
A value of 1e18 results in 1_

### ISOLATED_COLLATERAL_SUPPLIER_ROLE

```solidity
bytes32 ISOLATED_COLLATERAL_SUPPLIER_ROLE
```

_Role identifier for the role allowed to supply isolated reserves as collateral_

### validateSupply

```solidity
function validateSupply(struct DataTypes.ReserveCache reserveCache, struct DataTypes.ReserveData reserve, uint256 amount) internal view
```

Validates a supply action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| reserve | struct DataTypes.ReserveData |  |
| amount | uint256 | The amount to be supplied |

### validateWithdraw

```solidity
function validateWithdraw(struct DataTypes.ReserveCache reserveCache, uint256 amount, uint256 userBalance) internal pure
```

Validates a withdraw action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amount | uint256 | The amount to be withdrawn |
| userBalance | uint256 | The balance of the user |

### ValidateBorrowLocalVars

```solidity
struct ValidateBorrowLocalVars {
  uint256 currentLtv;
  uint256 collateralNeededInBaseCurrency;
  uint256 userCollateralInBaseCurrency;
  uint256 userDebtInBaseCurrency;
  uint256 availableLiquidity;
  uint256 healthFactor;
  uint256 totalDebt;
  uint256 totalSupplyVariableDebt;
  uint256 reserveDecimals;
  uint256 borrowCap;
  uint256 amountInBaseCurrency;
  uint256 assetUnit;
  address eModePriceSource;
  address siloedBorrowingAddress;
  bool isActive;
  bool isFrozen;
  bool isPaused;
  bool borrowingEnabled;
  bool stableRateBorrowingEnabled;
  bool siloedBorrowingEnabled;
}
```

### validateBorrow

```solidity
function validateBorrow(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.ValidateBorrowParams params) internal view
```

Validates a borrow action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.ValidateBorrowParams | Additional params needed for the validation |

### validateRepay

```solidity
function validateRepay(struct DataTypes.ReserveCache reserveCache, uint256 amountSent, enum DataTypes.InterestRateMode interestRateMode, address onBehalfOf, uint256 stableDebt, uint256 variableDebt) internal view
```

Validates a repay action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| amountSent | uint256 | The amount sent for the repayment. Can be an actual value or uint(-1) |
| interestRateMode | enum DataTypes.InterestRateMode | The interest rate mode of the debt being repaid |
| onBehalfOf | address | The address of the user msg.sender is repaying for |
| stableDebt | uint256 | The borrow balance of the user |
| variableDebt | uint256 | The borrow balance of the user |

### validateSwapRateMode

```solidity
function validateSwapRateMode(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, struct DataTypes.UserConfigurationMap userConfig, uint256 stableDebt, uint256 variableDebt, enum DataTypes.InterestRateMode currentRateMode) internal view
```

Validates a swap of borrow rate mode.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve state on which the user is swapping the rate |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| userConfig | struct DataTypes.UserConfigurationMap | The user reserves configuration |
| stableDebt | uint256 | The stable debt of the user |
| variableDebt | uint256 | The variable debt of the user |
| currentRateMode | enum DataTypes.InterestRateMode | The rate mode of the debt being swapped |

### validateRebalanceStableBorrowRate

```solidity
function validateRebalanceStableBorrowRate(struct DataTypes.ReserveData reserve, struct DataTypes.ReserveCache reserveCache, address reserveAddress) internal view
```

Validates a stable borrow rate rebalance action.

_Rebalancing is accepted when depositors are earning <= 90% of their earnings in pure supply/demand market (variable rate only)
For this to be the case, there has to be quite large stable debt with an interest rate below the current variable rate._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve state on which the user is getting rebalanced |
| reserveCache | struct DataTypes.ReserveCache | The cached state of the reserve |
| reserveAddress | address | The address of the reserve |

### validateSetUseReserveAsCollateral

```solidity
function validateSetUseReserveAsCollateral(struct DataTypes.ReserveCache reserveCache, uint256 userBalance) internal pure
```

Validates the action of setting an asset as collateral.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserveCache | struct DataTypes.ReserveCache | The cached data of the reserve |
| userBalance | uint256 | The balance of the user |

### validateFlashloan

```solidity
function validateFlashloan(mapping(address => struct DataTypes.ReserveData) reservesData, address[] assets, uint256[] amounts) internal view
```

Validates a flashloan action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| assets | address[] | The assets being flash-borrowed |
| amounts | uint256[] | The amounts for each asset being borrowed |

### validateFlashloanSimple

```solidity
function validateFlashloanSimple(struct DataTypes.ReserveData reserve) internal view
```

Validates a flashloan action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The state of the reserve |

### ValidateLiquidationCallLocalVars

```solidity
struct ValidateLiquidationCallLocalVars {
  bool collateralReserveActive;
  bool collateralReservePaused;
  bool principalReserveActive;
  bool principalReservePaused;
  bool isCollateralEnabled;
}
```

### validateLiquidationCall

```solidity
function validateLiquidationCall(struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveData collateralReserve, struct DataTypes.ValidateLiquidationCallParams params) internal view
```

Validates the liquidation action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| userConfig | struct DataTypes.UserConfigurationMap | The user configuration mapping |
| collateralReserve | struct DataTypes.ReserveData | The reserve data of the collateral |
| params | struct DataTypes.ValidateLiquidationCallParams | Additional parameters needed for the validation |

### validateHealthFactor

```solidity
function validateHealthFactor(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address user, uint8 userEModeCategory, uint256 reservesCount, address oracle) internal view returns (uint256, bool)
```

Validates the health factor of a user.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| user | address | The user to validate health factor of |
| userEModeCategory | uint8 | The users active efficiency mode category |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |

### validateHFAndLtv

```solidity
function validateHFAndLtv(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, address asset, address from, uint256 reservesCount, address oracle, uint8 userEModeCategory) internal view
```

Validates the health factor of a user and the ltv of the asset being withdrawn.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | The state of the user for the specific reserve |
| asset | address | The asset for which the ltv will be validated |
| from | address | The user from which the aTokens are being transferred |
| reservesCount | uint256 | The number of available reserves |
| oracle | address | The price oracle |
| userEModeCategory | uint8 | The users active efficiency mode category |

### validateTransfer

```solidity
function validateTransfer(struct DataTypes.ReserveData reserve) internal view
```

Validates a transfer action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reserve | struct DataTypes.ReserveData | The reserve object |

### validateDropReserve

```solidity
function validateDropReserve(mapping(uint256 => address) reservesList, struct DataTypes.ReserveData reserve, address asset) internal view
```

Validates a drop reserve action.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| reserve | struct DataTypes.ReserveData | The reserve object |
| asset | address | The address of the reserve's underlying asset |

### validateSetUserEMode

```solidity
function validateSetUserEMode(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.UserConfigurationMap userConfig, uint256 reservesCount, uint8 categoryId) internal view
```

Validates the action of setting efficiency mode.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | a mapping storing configurations for all efficiency mode categories |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reservesCount | uint256 | The total number of valid reserves |
| categoryId | uint8 | The id of the category |

### validateUseAsCollateral

```solidity
function validateUseAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveConfigurationMap reserveConfig) internal view returns (bool)
```

Validates the action of activating the asset as collateral.

_Only possible if the asset has non-zero LTV and the user is not in isolation mode_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reserveConfig | struct DataTypes.ReserveConfigurationMap | The reserve configuration |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the asset can be activated as collateral, false otherwise |

### validateAutomaticUseAsCollateral

```solidity
function validateAutomaticUseAsCollateral(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, struct DataTypes.UserConfigurationMap userConfig, struct DataTypes.ReserveConfigurationMap reserveConfig, address aTokenAddress) internal view returns (bool)
```

Validates if an asset should be automatically activated as collateral in the following actions: supply,
transfer, mint unbacked, and liquidate

_This is used to ensure that isolated assets are not enabled as collateral automatically_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| userConfig | struct DataTypes.UserConfigurationMap | the user configuration |
| reserveConfig | struct DataTypes.ReserveConfigurationMap | The reserve configuration |
| aTokenAddress | address |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the asset can be activated as collateral, false otherwise |

## MathUtils

Provides functions to perform linear and compounded interest calculations

### SECONDS_PER_YEAR

```solidity
uint256 SECONDS_PER_YEAR
```

_Ignoring leap years_

### calculateLinearInterest

```solidity
function calculateLinearInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Function to calculate the interest accumulated using a linear interest rate formula_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate linearly accumulated during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp, uint256 currentTimestamp) internal pure returns (uint256)
```

_Function to calculate the interest using a compounded interest rate formula
To avoid expensive exponentiation, the calculation is performed using a binomial approximation:

 (1+x)^n = 1+n*x+[n/2*(n-1)]*x^2+[n/6*(n-1)*(n-2)*x^3...

The approximation slightly underpays liquidity providers and undercharges borrowers, with the advantage of great
gas cost reductions. The whitepaper contains reference to the approximation and a table showing the margin of
error per different time periods_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate, in ray |
| lastUpdateTimestamp | uint40 | The timestamp of the last update of the interest |
| currentTimestamp | uint256 |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded during the timeDelta, in ray |

### calculateCompoundedInterest

```solidity
function calculateCompoundedInterest(uint256 rate, uint40 lastUpdateTimestamp) internal view returns (uint256)
```

_Calculates the compounded interest between the timestamp of the last update and the current block timestamp_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| rate | uint256 | The interest rate (in ray) |
| lastUpdateTimestamp | uint40 | The timestamp from which the interest accumulation needs to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The interest rate compounded between lastUpdateTimestamp and current block timestamp, in ray |

## PercentageMath

Provides functions to perform percentage calculations

_Percentages are defined by default with 2 decimals of precision (100.00). The precision is indicated by PERCENTAGE_FACTOR
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### PERCENTAGE_FACTOR

```solidity
uint256 PERCENTAGE_FACTOR
```

### HALF_PERCENTAGE_FACTOR

```solidity
uint256 HALF_PERCENTAGE_FACTOR
```

### percentMul

```solidity
function percentMul(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage multiplication

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentmul percentage |

### percentDiv

```solidity
function percentDiv(uint256 value, uint256 percentage) internal pure returns (uint256 result)
```

Executes a percentage division

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The value of which the percentage needs to be calculated |
| percentage | uint256 | The percentage of the value to be calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| result | uint256 | value percentdiv percentage |

## WadRayMath

Provides functions to perform calculations with Wad and Ray units

_Provides mul and div function for wads (decimal numbers with 18 digits of precision) and rays (decimal numbers
with 27 digits of precision)
Operations are rounded. If a value is >=.5, will be rounded up, otherwise rounded down._

### WAD

```solidity
uint256 WAD
```

### HALF_WAD

```solidity
uint256 HALF_WAD
```

### RAY

```solidity
uint256 RAY
```

### HALF_RAY

```solidity
uint256 HALF_RAY
```

### WAD_RAY_RATIO

```solidity
uint256 WAD_RAY_RATIO
```

### wadMul

```solidity
function wadMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Multiplies two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a*b, in wad |

### wadDiv

```solidity
function wadDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

_Divides two wad, rounding half up to the nearest wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |
| b | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a/b, in wad |

### rayMul

```solidity
function rayMul(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Multiplies two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raymul b |

### rayDiv

```solidity
function rayDiv(uint256 a, uint256 b) internal pure returns (uint256 c)
```

Divides two ray, rounding half up to the nearest ray

_assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |
| b | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| c | uint256 | = a raydiv b |

### rayToWad

```solidity
function rayToWad(uint256 a) internal pure returns (uint256 b)
```

_Casts ray down to wad
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Ray |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted to wad, rounded half up to the nearest wad |

### wadToRay

```solidity
function wadToRay(uint256 a) internal pure returns (uint256 b)
```

_Converts wad up to ray
assembly optimized for improved gas savings, see https://twitter.com/transmissions11/status/1451131036377571328_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| a | uint256 | Wad |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| b | uint256 | = a converted in ray |

## DataTypes

### ReserveData

```solidity
struct ReserveData {
  struct DataTypes.ReserveConfigurationMap configuration;
  uint128 liquidityIndex;
  uint128 currentLiquidityRate;
  uint128 variableBorrowIndex;
  uint128 currentVariableBorrowRate;
  uint128 currentStableBorrowRate;
  uint40 lastUpdateTimestamp;
  uint16 id;
  address aTokenAddress;
  address stableDebtTokenAddress;
  address variableDebtTokenAddress;
  address interestRateStrategyAddress;
  uint128 accruedToTreasury;
  uint128 unbacked;
  uint128 isolationModeTotalDebt;
}
```

### ReserveConfigurationMap

```solidity
struct ReserveConfigurationMap {
  uint256 data;
}
```

### UserConfigurationMap

```solidity
struct UserConfigurationMap {
  uint256 data;
}
```

### EModeCategory

```solidity
struct EModeCategory {
  uint16 ltv;
  uint16 liquidationThreshold;
  uint16 liquidationBonus;
  address priceSource;
  string label;
}
```

### InterestRateMode

```solidity
enum InterestRateMode {
  NONE,
  STABLE,
  VARIABLE
}
```

### ReserveCache

```solidity
struct ReserveCache {
  uint256 currScaledVariableDebt;
  uint256 nextScaledVariableDebt;
  uint256 currPrincipalStableDebt;
  uint256 currAvgStableBorrowRate;
  uint256 currTotalStableDebt;
  uint256 nextAvgStableBorrowRate;
  uint256 nextTotalStableDebt;
  uint256 currLiquidityIndex;
  uint256 nextLiquidityIndex;
  uint256 currVariableBorrowIndex;
  uint256 nextVariableBorrowIndex;
  uint256 currLiquidityRate;
  uint256 currVariableBorrowRate;
  uint256 reserveFactor;
  struct DataTypes.ReserveConfigurationMap reserveConfiguration;
  address aTokenAddress;
  address stableDebtTokenAddress;
  address variableDebtTokenAddress;
  uint40 reserveLastUpdateTimestamp;
  uint40 stableDebtLastUpdateTimestamp;
}
```

### ExecuteLiquidationCallParams

```solidity
struct ExecuteLiquidationCallParams {
  uint256 reservesCount;
  uint256 debtToCover;
  address collateralAsset;
  address debtAsset;
  address user;
  bool receiveAToken;
  address priceOracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
}
```

### ExecuteSupplyParams

```solidity
struct ExecuteSupplyParams {
  address asset;
  uint256 amount;
  address onBehalfOf;
  uint16 referralCode;
}
```

### ExecuteBorrowParams

```solidity
struct ExecuteBorrowParams {
  address asset;
  address user;
  address onBehalfOf;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  uint16 referralCode;
  bool releaseUnderlying;
  uint256 maxStableRateBorrowSizePercent;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
}
```

### ExecuteRepayParams

```solidity
struct ExecuteRepayParams {
  address asset;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  address onBehalfOf;
  bool useATokens;
}
```

### ExecuteWithdrawParams

```solidity
struct ExecuteWithdrawParams {
  address asset;
  uint256 amount;
  address to;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
}
```

### ExecuteSetUserEModeParams

```solidity
struct ExecuteSetUserEModeParams {
  uint256 reservesCount;
  address oracle;
  uint8 categoryId;
}
```

### FinalizeTransferParams

```solidity
struct FinalizeTransferParams {
  address asset;
  address from;
  address to;
  uint256 amount;
  uint256 balanceFromBefore;
  uint256 balanceToBefore;
  uint256 reservesCount;
  address oracle;
  uint8 fromEModeCategory;
}
```

### FlashloanParams

```solidity
struct FlashloanParams {
  address receiverAddress;
  address[] assets;
  uint256[] amounts;
  uint256[] interestRateModes;
  address onBehalfOf;
  bytes params;
  uint16 referralCode;
  uint256 flashLoanPremiumToProtocol;
  uint256 flashLoanPremiumTotal;
  uint256 maxStableRateBorrowSizePercent;
  uint256 reservesCount;
  address addressesProvider;
  address pool;
  uint8 userEModeCategory;
  bool isAuthorizedFlashBorrower;
}
```

### FlashloanSimpleParams

```solidity
struct FlashloanSimpleParams {
  address receiverAddress;
  address asset;
  uint256 amount;
  bytes params;
  uint16 referralCode;
  uint256 flashLoanPremiumToProtocol;
  uint256 flashLoanPremiumTotal;
}
```

### FlashLoanRepaymentParams

```solidity
struct FlashLoanRepaymentParams {
  uint256 amount;
  uint256 totalPremium;
  uint256 flashLoanPremiumToProtocol;
  address asset;
  address receiverAddress;
  uint16 referralCode;
}
```

### CalculateUserAccountDataParams

```solidity
struct CalculateUserAccountDataParams {
  struct DataTypes.UserConfigurationMap userConfig;
  uint256 reservesCount;
  address user;
  address oracle;
  uint8 userEModeCategory;
}
```

### ValidateBorrowParams

```solidity
struct ValidateBorrowParams {
  struct DataTypes.ReserveCache reserveCache;
  struct DataTypes.UserConfigurationMap userConfig;
  address asset;
  address userAddress;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  uint256 maxStableLoanPercent;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
  bool isolationModeActive;
  address isolationModeCollateralAddress;
  uint256 isolationModeDebtCeiling;
}
```

### ValidateLiquidationCallParams

```solidity
struct ValidateLiquidationCallParams {
  struct DataTypes.ReserveCache debtReserveCache;
  uint256 totalDebt;
  uint256 healthFactor;
  address priceOracleSentinel;
}
```

### CalculateInterestRatesParams

```solidity
struct CalculateInterestRatesParams {
  uint256 unbacked;
  uint256 liquidityAdded;
  uint256 liquidityTaken;
  uint256 totalStableDebt;
  uint256 totalVariableDebt;
  uint256 averageStableBorrowRate;
  uint256 reserveFactor;
  address reserve;
  address aToken;
}
```

### InitReserveParams

```solidity
struct InitReserveParams {
  address asset;
  address aTokenAddress;
  address stableDebtAddress;
  address variableDebtAddress;
  address interestRateStrategyAddress;
  uint16 reservesCount;
  uint16 maxNumberReserves;
}
```

## BlastPool

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) public
```

### init

```solidity
function init(contract IPoolAddressesProvider provider) external virtual
```

### claimGas

```solidity
function claimGas(address whom, address to) external
```

### claimERC20yields

```solidity
function claimERC20yields(address token, address dest) external
```

### compoundYields

```solidity
function compoundYields(address reserve) external
```

## Pool

Main point of interaction with an Aave protocol's market
- Users can:
  # Supply
  # Withdraw
  # Borrow
  # Repay
  # Swap their loans between variable and stable rate
  # Enable/disable their supplied assets as collateral rebalance stable rate borrow positions
  # Liquidate positions
  # Execute Flash Loans

_To be covered by a proxy contract, owned by the PoolAddressesProvider of the specific market
All admin functions are callable by the PoolConfigurator contract defined also in the
  PoolAddressesProvider_

### POOL_REVISION

```solidity
uint256 POOL_REVISION
```

### ADDRESSES_PROVIDER

```solidity
contract IPoolAddressesProvider ADDRESSES_PROVIDER
```

Returns the PoolAddressesProvider connected to this contract

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |

### onlyPoolConfigurator

```solidity
modifier onlyPoolConfigurator()
```

_Only pool configurator can call functions marked by this modifier._

### onlyPoolAdmin

```solidity
modifier onlyPoolAdmin()
```

_Only pool admin can call functions marked by this modifier._

### onlyBridge

```solidity
modifier onlyBridge()
```

_Only bridge can call functions marked by this modifier._

### _onlyPoolConfigurator

```solidity
function _onlyPoolConfigurator() internal view virtual
```

### _onlyPoolAdmin

```solidity
function _onlyPoolAdmin() internal view virtual
```

### _onlyBridge

```solidity
function _onlyBridge() internal view virtual
```

### getRevision

```solidity
function getRevision() internal pure virtual returns (uint256)
```

Returns the revision number of the contract

_Needs to be defined in the inherited class as a constant._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The revision number |

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | contract IPoolAddressesProvider | The address of the PoolAddressesProvider contract |

### initialize

```solidity
function initialize(contract IPoolAddressesProvider provider) public virtual
```

Initializes the Pool.

_Function is invoked by the proxy contract when the Pool contract is added to the
PoolAddressesProvider of the market.
Caching the address of the PoolAddressesProvider in order to reduce gas consumption on subsequent operations_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| provider | contract IPoolAddressesProvider | The address of the PoolAddressesProvider |

### mintUnbacked

```solidity
function mintUnbacked(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external virtual
```

Mints an `amount` of aTokens to the `onBehalfOf`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to mint |
| amount | uint256 | The amount to mint |
| onBehalfOf | address | The address that will receive the aTokens |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### backUnbacked

```solidity
function backUnbacked(address asset, uint256 amount, uint256 fee) external virtual returns (uint256)
```

Back the current unbacked underlying with `amount` and pay `fee`.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to back |
| amount | uint256 | The amount to back |
| fee | uint256 | The amount paid in fees |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The backed amount |

### supply

```solidity
function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) public virtual
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### supplyWithPermit

```solidity
function supplyWithPermit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode, uint256 deadline, uint8 permitV, bytes32 permitR, bytes32 permitS) public virtual
```

Supply with transfer approval of asset to be supplied done via permit function
see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| deadline | uint256 | The deadline timestamp that the permit is valid |
| permitV | uint8 | The V parameter of ERC712 permit sig |
| permitR | bytes32 | The R parameter of ERC712 permit sig |
| permitS | bytes32 | The S parameter of ERC712 permit sig |

### withdraw

```solidity
function withdraw(address asset, uint256 amount, address to) public virtual returns (uint256)
```

Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to withdraw |
| amount | uint256 | The underlying amount to be withdrawn   - Send the value type(uint256).max in order to withdraw the whole aToken balance |
| to | address | The address that will receive the underlying, same as msg.sender if the user   wants to receive it on his own wallet, or a different address if the beneficiary is a   different wallet |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount withdrawn |

### borrow

```solidity
function borrow(address asset, uint256 amount, uint256 interestRateMode, uint16 referralCode, address onBehalfOf) public virtual
```

Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
already supplied enough collateral, or he was given enough allowance by a credit delegator on the
corresponding debt token (StableDebtToken or VariableDebtToken)
- E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
  and 100 stable/variable debt tokens, depending on the `interestRateMode`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to borrow |
| amount | uint256 | The amount to be borrowed |
| interestRateMode | uint256 | The interest rate mode at which the user wants to borrow: 1 for Stable, 2 for Variable |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |
| onBehalfOf | address | The address of the user who will receive the debt. Should be the address of the borrower itself calling the function if he wants to borrow against his own collateral, or the address of the credit delegator if he has been given credit delegation allowance |

### repay

```solidity
function repay(address asset, uint256 amount, uint256 interestRateMode, address onBehalfOf) public virtual returns (uint256)
```

Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
- E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### repayWithPermit

```solidity
function repayWithPermit(address asset, uint256 amount, uint256 interestRateMode, address onBehalfOf, uint256 deadline, uint8 permitV, bytes32 permitR, bytes32 permitS) public virtual returns (uint256)
```

Repay with transfer approval of asset to be repaid done via permit function
see: https://eips.ethereum.org/EIPS/eip-2612 and https://eips.ethereum.org/EIPS/eip-713

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |
| onBehalfOf | address | Address of the user who will get his debt reduced/removed. Should be the address of the user calling the function if he wants to reduce/remove his own debt, or the address of any other other borrower whose debt should be removed |
| deadline | uint256 | The deadline timestamp that the permit is valid |
| permitV | uint8 | The V parameter of ERC712 permit sig |
| permitR | bytes32 | The R parameter of ERC712 permit sig |
| permitS | bytes32 | The S parameter of ERC712 permit sig |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### repayWithATokens

```solidity
function repayWithATokens(address asset, uint256 amount, uint256 interestRateMode) public virtual returns (uint256)
```

Repays a borrowed `amount` on a specific reserve using the reserve aTokens, burning the
equivalent debt tokens
- E.g. User repays 100 USDC using 100 aUSDC, burning 100 variable/stable debt tokens

_Passing uint256.max as amount will clean up any residual aToken dust balance, if the user aToken
balance is not enough to cover the whole debt_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the borrowed underlying asset previously borrowed |
| amount | uint256 | The amount to repay - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode` |
| interestRateMode | uint256 | The interest rate mode at of the debt the user wants to repay: 1 for Stable, 2 for Variable |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The final amount repaid |

### swapBorrowRateMode

```solidity
function swapBorrowRateMode(address asset, uint256 interestRateMode) public virtual
```

Allows a borrower to swap his debt between stable and variable mode, or vice versa

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset borrowed |
| interestRateMode | uint256 | The current interest rate mode of the position being swapped: 1 for Stable, 2 for Variable |

### rebalanceStableBorrowRate

```solidity
function rebalanceStableBorrowRate(address asset, address user) public virtual
```

Rebalances the stable interest rate of a user to the current stable rate defined on the reserve.
- Users can be rebalanced if the following conditions are satisfied:
    1. Usage ratio is above 95%
    2. the current supply APY is below REBALANCE_UP_THRESHOLD * maxVariableBorrowRate, which means that too
       much has been borrowed at a stable rate and suppliers are not earning enough

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset borrowed |
| user | address | The address of the user to be rebalanced |

### setUserUseReserveAsCollateral

```solidity
function setUserUseReserveAsCollateral(address asset, bool useAsCollateral) public virtual
```

Allows suppliers to enable/disable a specific supplied asset as collateral

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset supplied |
| useAsCollateral | bool | True if the user wants to use the supply as collateral, false otherwise |

### liquidationCall

```solidity
function liquidationCall(address collateralAsset, address debtAsset, address user, uint256 debtToCover, bool receiveAToken) public virtual
```

Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
- The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
  a proportionally amount of the `collateralAsset` plus a bonus to cover market risk

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| collateralAsset | address | The address of the underlying asset used as collateral, to receive as result of the liquidation |
| debtAsset | address | The address of the underlying borrowed asset to be repaid with the liquidation |
| user | address | The address of the borrower getting liquidated |
| debtToCover | uint256 | The debt amount of borrowed `asset` the liquidator wants to cover |
| receiveAToken | bool | True if the liquidators wants to receive the collateral aTokens, `false` if he wants to receive the underlying collateral asset directly |

### flashLoan

```solidity
function flashLoan(address receiverAddress, address[] assets, uint256[] amounts, uint256[] interestRateModes, address onBehalfOf, bytes params, uint16 referralCode) public virtual
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanReceiver interface |
| assets | address[] | The addresses of the assets being flash-borrowed |
| amounts | uint256[] | The amounts of the assets being flash-borrowed |
| interestRateModes | uint256[] | Types of the debt to open if the flash loan is not returned:   0 -> Don't open any debt, just revert if funds can't be transferred from the receiver   1 -> Open debt at stable rate for the value of the amount flash-borrowed to the `onBehalfOf` address   2 -> Open debt at variable rate for the value of the amount flash-borrowed to the `onBehalfOf` address |
| onBehalfOf | address | The address  that will receive the debt in the case of using on `modes` 1 or 2 |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### flashLoanSimple

```solidity
function flashLoanSimple(address receiverAddress, address asset, uint256 amount, bytes params, uint16 referralCode) public virtual
```

Allows smartcontracts to access the liquidity of the pool within one transaction,
as long as the amount taken plus a fee is returned.

_IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
into consideration. For further details please visit https://docs.aave.com/developers/_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| receiverAddress | address | The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface |
| asset | address | The address of the asset being flash-borrowed |
| amount | uint256 | The amount of the asset being flash-borrowed |
| params | bytes | Variadic packed params to pass to the receiver as extra information |
| referralCode | uint16 | The code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

### mintToTreasury

```solidity
function mintToTreasury(address[] assets) external virtual
```

Mints the assets accrued through the reserve factor to the treasury in the form of aTokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The list of reserves for which the minting needs to be executed |

### getReserveData

```solidity
function getReserveData(address asset) external view virtual returns (struct DataTypes.ReserveData)
```

Returns the state and configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveData | The state and configuration data of the reserve |

### getUserAccountData

```solidity
function getUserAccountData(address user) external view virtual returns (uint256 totalCollateralBase, uint256 totalDebtBase, uint256 availableBorrowsBase, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor)
```

Returns the user account data across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralBase | uint256 | The total collateral of the user in the base currency used by the price feed |
| totalDebtBase | uint256 | The total debt of the user in the base currency used by the price feed |
| availableBorrowsBase | uint256 | The borrowing power left of the user in the base currency used by the price feed |
| currentLiquidationThreshold | uint256 | The liquidation threshold of the user |
| ltv | uint256 | The loan to value of The user |
| healthFactor | uint256 | The current health factor of the user |

### getConfiguration

```solidity
function getConfiguration(address asset) external view virtual returns (struct DataTypes.ReserveConfigurationMap)
```

Returns the configuration of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.ReserveConfigurationMap | The configuration of the reserve |

### getUserConfiguration

```solidity
function getUserConfiguration(address user) external view virtual returns (struct DataTypes.UserConfigurationMap)
```

Returns the configuration of the user across all the reserves

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user address |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.UserConfigurationMap | The configuration of the user |

### getReserveNormalizedIncome

```solidity
function getReserveNormalizedIncome(address asset) external view virtual returns (uint256)
```

Returns the normalized income of the reserve

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve's normalized income |

### getReserveNormalizedVariableDebt

```solidity
function getReserveNormalizedVariableDebt(address asset) external view virtual returns (uint256)
```

Returns the normalized variable debt per unit of asset

_WARNING: This function is intended to be used primarily by the protocol itself to get a
"dynamic" variable index based on time, current stored index and virtual rate at the current
moment (approx. a borrower would get if opening a position). This means that is always used in
combination with variable debt supply/balances.
If using this function externally, consider that is possible to have an increasing normalized
variable debt that is not equivalent to how the variable debt index would be updated in storage
(e.g. only updates with non-zero variable debt supply)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The reserve normalized variable debt |

### getReservesList

```solidity
function getReservesList() external view virtual returns (address[])
```

Returns the list of the underlying assets of all the initialized reserves

_It does not include dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The addresses of the underlying assets of the initialized reserves |

### getReservesCount

```solidity
function getReservesCount() external view virtual returns (uint256)
```

Returns the number of initialized reserves

_It includes dropped reserves_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The count |

### getReserveAddressById

```solidity
function getReserveAddressById(uint16 id) external view returns (address)
```

Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint16 | The id of the reserve as stored in the DataTypes.ReserveData struct |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the reserve associated with id |

### MAX_STABLE_RATE_BORROW_SIZE_PERCENT

```solidity
function MAX_STABLE_RATE_BORROW_SIZE_PERCENT() public view virtual returns (uint256)
```

Returns the percentage of available liquidity that can be borrowed at once at stable rate

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The percentage of available liquidity to borrow, expressed in bps |

### BRIDGE_PROTOCOL_FEE

```solidity
function BRIDGE_PROTOCOL_FEE() public view virtual returns (uint256)
```

Returns the part of the bridge fees sent to protocol

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The bridge fee sent to the protocol treasury |

### FLASHLOAN_PREMIUM_TOTAL

```solidity
function FLASHLOAN_PREMIUM_TOTAL() public view virtual returns (uint128)
```

Returns the total fee on flash loans

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint128 | The total fee on flashloans |

### FLASHLOAN_PREMIUM_TO_PROTOCOL

```solidity
function FLASHLOAN_PREMIUM_TO_PROTOCOL() public view virtual returns (uint128)
```

Returns the part of the flashloan fees sent to protocol

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint128 | The flashloan fee sent to the protocol treasury |

### MAX_NUMBER_RESERVES

```solidity
function MAX_NUMBER_RESERVES() public view virtual returns (uint16)
```

Returns the maximum number of reserves supported to be listed in this Pool

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint16 | The maximum number of reserves supported |

### finalizeTransfer

```solidity
function finalizeTransfer(address asset, address from, address to, uint256 amount, uint256 balanceFromBefore, uint256 balanceToBefore) external virtual
```

Validates and finalizes an aToken transfer

_Only callable by the overlying aToken of the `asset`_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the aToken |
| from | address | The user from which the aTokens are transferred |
| to | address | The user receiving the aTokens |
| amount | uint256 | The amount being transferred/withdrawn |
| balanceFromBefore | uint256 | The aToken balance of the `from` user before the transfer |
| balanceToBefore | uint256 | The aToken balance of the `to` user before the transfer |

### initReserve

```solidity
function initReserve(address asset, address aTokenAddress, address stableDebtAddress, address variableDebtAddress, address interestRateStrategyAddress) external virtual
```

Initializes a reserve, activating it, assigning an aToken and debt tokens and an
interest rate strategy

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| aTokenAddress | address | The address of the aToken that will be assigned to the reserve |
| stableDebtAddress | address | The address of the StableDebtToken that will be assigned to the reserve |
| variableDebtAddress | address | The address of the VariableDebtToken that will be assigned to the reserve |
| interestRateStrategyAddress | address | The address of the interest rate strategy contract |

### dropReserve

```solidity
function dropReserve(address asset) external virtual
```

Drop a reserve

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |

### setReserveInterestRateStrategyAddress

```solidity
function setReserveInterestRateStrategyAddress(address asset, address rateStrategyAddress) external virtual
```

Updates the address of the interest rate strategy contract

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| rateStrategyAddress | address | The address of the interest rate strategy contract |

### setConfiguration

```solidity
function setConfiguration(address asset, struct DataTypes.ReserveConfigurationMap configuration) external virtual
```

Sets the configuration bitmap of the reserve as a whole

_Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset of the reserve |
| configuration | struct DataTypes.ReserveConfigurationMap | The new configuration bitmap |

### updateBridgeProtocolFee

```solidity
function updateBridgeProtocolFee(uint256 protocolFee) external virtual
```

Updates the protocol fee on the bridging

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| protocolFee | uint256 |  |

### updateFlashloanPremiums

```solidity
function updateFlashloanPremiums(uint128 flashLoanPremiumTotal, uint128 flashLoanPremiumToProtocol) external virtual
```

Updates flash loan premiums. Flash loan premium consists of two parts:
- A part is sent to aToken holders as extra, one time accumulated interest
- A part is collected by the protocol treasury

_The total premium is calculated on the total borrowed amount
The premium to protocol is calculated on the total premium, being a percentage of `flashLoanPremiumTotal`
Only callable by the PoolConfigurator contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| flashLoanPremiumTotal | uint128 | The total premium, expressed in bps |
| flashLoanPremiumToProtocol | uint128 | The part of the premium sent to the protocol treasury, expressed in bps |

### configureEModeCategory

```solidity
function configureEModeCategory(uint8 id, struct DataTypes.EModeCategory category) external virtual
```

Configures a new category for the eMode.

_In eMode, the protocol allows very high borrowing power to borrow assets of the same category.
The category 0 is reserved as it's the default for volatile assets_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint8 | The id of the category |
| category | struct DataTypes.EModeCategory |  |

### getEModeCategoryData

```solidity
function getEModeCategoryData(uint8 id) external view virtual returns (struct DataTypes.EModeCategory)
```

Returns the data of an eMode category

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint8 | The id of the category |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | struct DataTypes.EModeCategory | The configuration data of the category |

### setUserEMode

```solidity
function setUserEMode(uint8 categoryId) external virtual
```

Allows a user to use the protocol in eMode

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| categoryId | uint8 | The id of the category |

### getUserEMode

```solidity
function getUserEMode(address user) external view virtual returns (uint256)
```

Returns the eMode the user is using

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The eMode id |

### resetIsolationModeTotalDebt

```solidity
function resetIsolationModeTotalDebt(address asset) external virtual
```

Resets the isolation mode total debt of the given asset to zero

_It requires the given asset has zero debt ceiling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to reset the isolationModeTotalDebt |

### rescueTokens

```solidity
function rescueTokens(address token, address to, uint256 amount) external virtual
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

### deposit

```solidity
function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external virtual
```

Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
- E.g. User supplies 100 USDC and gets in return 100 aUSDC

_Deprecated: maintained for compatibility purposes_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the underlying asset to supply |
| amount | uint256 | The amount to be supplied |
| onBehalfOf | address | The address that will receive the aTokens, same as msg.sender if the user   wants to receive them on his own wallet, or a different address if the beneficiary of aTokens   is a different wallet |
| referralCode | uint16 | Code used to register the integrator originating the operation, for potential rewards.   0 if the action is executed directly by the user, without any middle-man |

## PoolStorage

Contract used as storage of the Pool contract.

_It defines the storage layout of the Pool contract._

### _reserves

```solidity
mapping(address => struct DataTypes.ReserveData) _reserves
```

### _usersConfig

```solidity
mapping(address => struct DataTypes.UserConfigurationMap) _usersConfig
```

### _reservesList

```solidity
mapping(uint256 => address) _reservesList
```

### _eModeCategories

```solidity
mapping(uint8 => struct DataTypes.EModeCategory) _eModeCategories
```

### _usersEModeCategory

```solidity
mapping(address => uint8) _usersEModeCategory
```

### _bridgeProtocolFee

```solidity
uint256 _bridgeProtocolFee
```

### _flashLoanPremiumTotal

```solidity
uint128 _flashLoanPremiumTotal
```

### _flashLoanPremiumToProtocol

```solidity
uint128 _flashLoanPremiumToProtocol
```

### _maxStableRateBorrowSizePercent

```solidity
uint64 _maxStableRateBorrowSizePercent
```

### _reservesCount

```solidity
uint16 _reservesCount
```

## AToken

Implementation of the interest bearing token for the Aave protocol

### PERMIT_TYPEHASH

```solidity
bytes32 PERMIT_TYPEHASH
```

### ATOKEN_REVISION

```solidity
uint256 ATOKEN_REVISION
```

### _treasury

```solidity
address _treasury
```

### _underlyingAsset

```solidity
address _underlyingAsset
```

### getRevision

```solidity
function getRevision() internal pure virtual returns (uint256)
```

Returns the revision number of the contract

_Needs to be defined in the inherited class as a constant._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The revision number |

### constructor

```solidity
constructor(contract IPool pool) public
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The address of the Pool contract |

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

### mint

```solidity
function mint(address caller, address onBehalfOf, uint256 amount, uint256 index) external virtual returns (bool)
```

Mints `amount` aTokens to `user`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the minted aTokens |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` if the the previous balance of the user was 0 |

### burn

```solidity
function burn(address from, address receiverOfUnderlying, uint256 amount, uint256 index) external virtual
```

Burns aTokens from `user` and sends the equivalent amount of underlying to `receiverOfUnderlying`

_In some instances, the mint event could be emitted from a burn transaction
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address from which the aTokens will be burned |
| receiverOfUnderlying | address | The address that will receive the underlying |
| amount | uint256 | The amount being burned |
| index | uint256 | The next liquidity index of the reserve |

### mintToTreasury

```solidity
function mintToTreasury(uint256 amount, uint256 index) external virtual
```

Mints aTokens to the reserve treasury

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

### transferOnLiquidation

```solidity
function transferOnLiquidation(address from, address to, uint256 value) external virtual
```

Transfers aTokens in the event of a borrow being liquidated, in case the liquidators reclaims the aToken

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address getting liquidated, current owner of the aTokens |
| to | address | The recipient |
| value | uint256 | The amount of tokens getting transferred |

### balanceOf

```solidity
function balanceOf(address user) public view virtual returns (uint256)
```

_Returns the amount of tokens owned by `account`._

### totalSupply

```solidity
function totalSupply() public view virtual returns (uint256)
```

_Returns the amount of tokens in existence._

### RESERVE_TREASURY_ADDRESS

```solidity
function RESERVE_TREASURY_ADDRESS() external view returns (address)
```

Returns the address of the Aave treasury, receiving the fees on this aToken.

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | Address of the Aave treasury |

### UNDERLYING_ASSET_ADDRESS

```solidity
function UNDERLYING_ASSET_ADDRESS() external view returns (address)
```

Returns the address of the underlying asset of this aToken (E.g. WETH for aWETH)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the underlying asset |

### transferUnderlyingTo

```solidity
function transferUnderlyingTo(address target, uint256 amount) external virtual
```

Transfers the underlying asset to `target`.

_Used by the Pool to transfer assets in borrow(), withdraw() and flashLoan()_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| target | address | The recipient of the underlying |
| amount | uint256 | The amount getting transferred |

### handleRepayment

```solidity
function handleRepayment(address user, address onBehalfOf, uint256 amount) external virtual
```

Handles the underlying received by the aToken after the transfer has been completed.

_The default implementation is empty as with standard ERC20 tokens, nothing needs to be done after the
transfer is concluded. However in the future there may be aTokens that allow for example to stake the underlying
to receive LM rewards. In that case, `handleRepayment()` would perform the staking of the underlying asset._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user executing the repayment |
| onBehalfOf | address | The address of the user who will get his debt reduced/removed |
| amount | uint256 | The amount getting repaid |

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

### _transfer

```solidity
function _transfer(address from, address to, uint256 amount, bool validate) internal virtual
```

Transfers the aTokens between two users. Validates the transfer
(ie checks for valid HF after the transfer) if required

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The source address |
| to | address | The destination address |
| amount | uint256 | The amount getting transferred |
| validate | bool | True if the transfer needs to be validated, false otherwise |

### _transfer

```solidity
function _transfer(address from, address to, uint128 amount) internal virtual
```

Overrides the parent _transfer to force validated transfer() and transferFrom()

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The source address |
| to | address | The destination address |
| amount | uint128 | The amount getting transferred |

### DOMAIN_SEPARATOR

```solidity
function DOMAIN_SEPARATOR() public view returns (bytes32)
```

_Overrides the base function to fully implement IAToken
see `EIP712Base.DOMAIN_SEPARATOR()` for more detailed documentation_

### nonces

```solidity
function nonces(address owner) public view returns (uint256)
```

_Overrides the base function to fully implement IAToken
see `EIP712Base.nonces()` for more detailed documentation_

### _EIP712BaseId

```solidity
function _EIP712BaseId() internal view returns (string)
```

Returns the user readable name of signing domain (e.g. token name)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The name of the signing domain |

### rescueTokens

```solidity
function rescueTokens(address token, address to, uint256 amount) external
```

Rescue and transfer tokens locked in this contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the token |
| to | address | The address of the recipient |
| amount | uint256 | The amount of token to transfer |

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

## EIP712Base

Base contract implementation of EIP712.

### EIP712_REVISION

```solidity
bytes EIP712_REVISION
```

### EIP712_DOMAIN

```solidity
bytes32 EIP712_DOMAIN
```

### _nonces

```solidity
mapping(address => uint256) _nonces
```

### _domainSeparator

```solidity
bytes32 _domainSeparator
```

### _chainId

```solidity
uint256 _chainId
```

### constructor

```solidity
constructor() internal
```

_Constructor._

### DOMAIN_SEPARATOR

```solidity
function DOMAIN_SEPARATOR() public view virtual returns (bytes32)
```

Get the domain separator for the token

_Return cached value if chainId matches cache, otherwise recomputes separator_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator of the token at current chain |

### nonces

```solidity
function nonces(address owner) public view virtual returns (uint256)
```

Returns the nonce value for address specified as parameter

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The address for which the nonce is being returned |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The nonce value for the input address` |

### _calculateDomainSeparator

```solidity
function _calculateDomainSeparator() internal view returns (bytes32)
```

Compute the current domain separator

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator for the token |

### _EIP712BaseId

```solidity
function _EIP712BaseId() internal view virtual returns (string)
```

Returns the user readable name of signing domain (e.g. token name)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The name of the signing domain |

## IncentivizedERC20

Basic ERC20 implementation

### onlyPoolAdmin

```solidity
modifier onlyPoolAdmin()
```

_Only pool admin can call functions marked by this modifier._

### onlyPool

```solidity
modifier onlyPool()
```

_Only pool can call functions marked by this modifier._

### UserState

```solidity
struct UserState {
  uint128 balance;
  uint128 additionalData;
}
```

### _userState

```solidity
mapping(address => struct IncentivizedERC20.UserState) _userState
```

### _totalSupply

```solidity
uint256 _totalSupply
```

### _incentivesController

```solidity
contract IAaveIncentivesController _incentivesController
```

### _addressesProvider

```solidity
contract IPoolAddressesProvider _addressesProvider
```

### POOL

```solidity
contract IPool POOL
```

### constructor

```solidity
constructor(contract IPool pool, string name, string symbol, uint8 decimals) internal
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The reference to the main Pool contract |
| name | string | The name of the token |
| symbol | string | The symbol of the token |
| decimals | uint8 | The number of decimals of the token |

### name

```solidity
function name() public view returns (string)
```

### symbol

```solidity
function symbol() external view returns (string)
```

### decimals

```solidity
function decimals() external view returns (uint8)
```

### totalSupply

```solidity
function totalSupply() public view virtual returns (uint256)
```

_Returns the amount of tokens in existence._

### balanceOf

```solidity
function balanceOf(address account) public view virtual returns (uint256)
```

_Returns the amount of tokens owned by `account`._

### getIncentivesController

```solidity
function getIncentivesController() external view virtual returns (contract IAaveIncentivesController)
```

Returns the address of the Incentives Controller contract

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract IAaveIncentivesController | The address of the Incentives Controller |

### setIncentivesController

```solidity
function setIncentivesController(contract IAaveIncentivesController controller) external
```

Sets a new Incentives Controller

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| controller | contract IAaveIncentivesController | the new Incentives controller |

### transfer

```solidity
function transfer(address recipient, uint256 amount) external virtual returns (bool)
```

_Moves `amount` tokens from the caller's account to `recipient`.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### allowance

```solidity
function allowance(address owner, address spender) external view virtual returns (uint256)
```

_Returns the remaining number of tokens that `spender` will be
allowed to spend on behalf of `owner` through {transferFrom}. This is
zero by default.

This value changes when {approve} or {transferFrom} are called._

### approve

```solidity
function approve(address spender, uint256 amount) external virtual returns (bool)
```

_Sets `amount` as the allowance of `spender` over the caller's tokens.

Returns a boolean value indicating whether the operation succeeded.

IMPORTANT: Beware that changing an allowance with this method brings the risk
that someone may use both the old and the new allowance by unfortunate
transaction ordering. One possible solution to mitigate this race
condition is to first reduce the spender's allowance to 0 and set the
desired value afterwards:
https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

Emits an {Approval} event._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) external virtual returns (bool)
```

_Moves `amount` tokens from `sender` to `recipient` using the
allowance mechanism. `amount` is then deducted from the caller's
allowance.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### increaseAllowance

```solidity
function increaseAllowance(address spender, uint256 addedValue) external virtual returns (bool)
```

Increases the allowance of spender to spend _msgSender() tokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | The user allowed to spend on behalf of _msgSender() |
| addedValue | uint256 | The amount being added to the allowance |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` |

### decreaseAllowance

```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) external virtual returns (bool)
```

Decreases the allowance of spender to spend _msgSender() tokens

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | The user allowed to spend on behalf of _msgSender() |
| subtractedValue | uint256 | The amount being subtracted to the allowance |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` |

### _transfer

```solidity
function _transfer(address sender, address recipient, uint128 amount) internal virtual
```

Transfers tokens between two users and apply incentives if defined.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | The source address |
| recipient | address | The destination address |
| amount | uint128 | The amount getting transferred |

### _approve

```solidity
function _approve(address owner, address spender, uint256 amount) internal virtual
```

Approve `spender` to use `amount` of `owner`s balance

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The address owning the tokens |
| spender | address | The address approved for spending |
| amount | uint256 | The amount of tokens to approve spending of |

### _setName

```solidity
function _setName(string newName) internal
```

Update the name of the token

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newName | string | The new name for the token |

### _setSymbol

```solidity
function _setSymbol(string newSymbol) internal
```

Update the symbol for the token

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSymbol | string | The new symbol for the token |

### _setDecimals

```solidity
function _setDecimals(uint8 newDecimals) internal
```

Update the number of decimals for the token

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newDecimals | uint8 | The new number of decimals for the token |

## MintableIncentivizedERC20

Implements mint and burn functions for IncentivizedERC20

### constructor

```solidity
constructor(contract IPool pool, string name, string symbol, uint8 decimals) internal
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The reference to the main Pool contract |
| name | string | The name of the token |
| symbol | string | The symbol of the token |
| decimals | uint8 | The number of decimals of the token |

### _mint

```solidity
function _mint(address account, uint128 amount) internal virtual
```

Mints tokens to an account and apply incentives if defined

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The address receiving tokens |
| amount | uint128 | The amount of tokens to mint |

### _burn

```solidity
function _burn(address account, uint128 amount) internal virtual
```

Burns tokens from an account and apply incentives if defined

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The account whose tokens are burnt |
| amount | uint128 | The amount of tokens to burn |

## ScaledBalanceTokenBase

Basic ERC20 implementation of scaled balance token

### constructor

```solidity
constructor(contract IPool pool, string name, string symbol, uint8 decimals) internal
```

_Constructor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | contract IPool | The reference to the main Pool contract |
| name | string | The name of the token |
| symbol | string | The symbol of the token |
| decimals | uint8 | The number of decimals of the token |

### scaledBalanceOf

```solidity
function scaledBalanceOf(address user) external view returns (uint256)
```

Returns the scaled balance of the user.

_The scaled balance is the sum of all the updated stored balance divided by the reserve's liquidity index
at the moment of the update_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user whose balance is calculated |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |

### getScaledUserBalanceAndSupply

```solidity
function getScaledUserBalanceAndSupply(address user) external view returns (uint256, uint256)
```

Returns the scaled balance of the user and the scaled total supply.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled balance of the user |
| [1] | uint256 | The scaled total supply |

### scaledTotalSupply

```solidity
function scaledTotalSupply() public view virtual returns (uint256)
```

Returns the scaled total supply of the scaled balance token. Represents sum(debt/index)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The scaled total supply |

### getPreviousIndex

```solidity
function getPreviousIndex(address user) external view virtual returns (uint256)
```

Returns last index interest was accrued to the user's balance

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The last index interest was accrued to the user's balance, expressed in ray |

### _mintScaled

```solidity
function _mintScaled(address caller, address onBehalfOf, uint256 amount, uint256 index) internal returns (bool)
```

Implements the basic logic to mint a scaled balance token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The address performing the mint |
| onBehalfOf | address | The address of the user that will receive the scaled tokens |
| amount | uint256 | The amount of tokens getting minted |
| index | uint256 | The next liquidity index of the reserve |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | `true` if the the previous balance of the user was 0 |

### _burnScaled

```solidity
function _burnScaled(address user, address target, uint256 amount, uint256 index) internal
```

Implements the basic logic to burn a scaled balance token.

_In some instances, a burn transaction will emit a mint event
if the amount to burn is less than the interest that the user accrued_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The user which debt is burnt |
| target | address | The address that will receive the underlying, if any |
| amount | uint256 | The amount getting burned |
| index | uint256 | The variable debt index of the reserve |

### _transfer

```solidity
function _transfer(address sender, address recipient, uint256 amount, uint256 index) internal
```

Implements the basic logic to transfer scaled balance tokens between two users

_It emits a mint event with the interest accrued per user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | The source address |
| recipient | address | The destination address |
| amount | uint256 | The amount getting transferred |
| index | uint256 | The next liquidity index of the reserve |

