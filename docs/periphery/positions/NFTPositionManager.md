# Solidity API

## NFTPositionManager

_Manages the minting and burning of NFT positions, which represent liquidity positions in a pool._

### factory

```solidity
contract IFactory factory
```

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

### isPool

```solidity
modifier isPool(address pool)
```

@dev Modifier to check if the caller is pool or not.
 @param pool Address of the pool.

### constructor

```solidity
constructor() public
```

_Constructor to disable initializers._

### initialize

```solidity
function initialize(address _factory) external
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
| params | struct INFTPositionManager.MintParams | The parameters required for minting the position, including the pool,token and amount. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the newly minted token. |

### increaseLiquidity

```solidity
function increaseLiquidity(struct INFTPositionManager.LiquidityParams params) external
```

Allow User to increase liquidity in the postion

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.LiquidityParams | The parameters required for increase liquidity the position, including the token, pool, amount and asset. |

### borrow

```solidity
function borrow(struct INFTPositionManager.AssetOperationParams params) external
```

Allow user to borrow the underlying assets

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.AssetOperationParams | The params required for borrow the position which includes tokenId, market and amount |

### withdraw

```solidity
function withdraw(struct INFTPositionManager.AssetOperationParams params) external
```

Allow user to withdraw their underlying assets.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.AssetOperationParams | The parameters required for withdrawing from the position, including tokenId, asset, and amount. |

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
function repay(struct INFTPositionManager.AssetOperationParams params) external
```

Allow user to repay thier debt.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INFTPositionManager.AssetOperationParams | The params required for repaying the position which includes tokenId, asset and amount. |

### getPosition

```solidity
function getPosition(uint256 tokenId) public view returns (struct INFTPositionManager.Asset[] assets, bool isBurnAllowed)
```

Retrieves the details of a position identified by the given token ID.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the position token. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | struct INFTPositionManager.Asset[] | An array of Asset structs representing the balances and debts of the position's assets. |
| isBurnAllowed | bool |  |

