# Solidity API

## NFTPositionManager

_Manages the minting and burning of NFT positions, which represent liquidity positions in a pool._

### positions

```solidity
mapping(uint256 => struct INFTPositionManager.Position) positions
```

Mapping from token ID to the Position struct representing the details of the liquidity position.

### isAuthorizedForToken

```solidity
modifier isAuthorizedForToken(uint256 tokenId)
```

_Modifier to check if the caller is authorized (owner or approved operator) for the given token ID._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token to check authorization for. |

### constructor

```solidity
constructor() public
```

_Constructor to disable initializers._

### initialize

```solidity
function initialize() external
```

Initializes the NFTPositionManager contract.

### mint

```solidity
function mint(struct INFTPositionManager.MintParams params) external returns (uint256 tokenId)
```

Mints a new NFT representing a liquidity position.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.MintParams | The parameters required for minting the position, including the pool, token, amount, and recipient. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the newly minted token. |

### increaseLiquidity

```solidity
function increaseLiquidity(struct INFTPositionManager.AddLiquidityParams params) external
```

Allow User to increase liquidity in the postion

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.AddLiquidityParams | The parameters required for increase liquidity the position, including the token, amount, and recipient and asset. |

### borrow

```solidity
function borrow(struct INFTPositionManager.BorrowParams params) external
```

Allow user to borrow the underlying assets

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.BorrowParams | The params required for borrow the position which includes tokenId, market and amount |

### withdraw

```solidity
function withdraw(struct INFTPositionManager.WithdrawParams params) external
```

Allow user to withdraw their underlying assets.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.WithdrawParams | The parameters required for withdrawing from the position, including tokenId, asset, and amount. |

### burn

```solidity
function burn(uint256 tokenId) external
```

Burns a token, removing it from existence.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token to burn. |

### repay

```solidity
function repay(struct INFTPositionManager.RepayParams params) external
```

Allow user to repay thier debt.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.RepayParams | The params required for repaying the position which includes tokenId, asset and amount. |

