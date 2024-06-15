# Solidity API

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

