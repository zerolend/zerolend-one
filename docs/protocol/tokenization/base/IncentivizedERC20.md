# Solidity API

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

