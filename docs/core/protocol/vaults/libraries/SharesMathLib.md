# Solidity API

## SharesMathLib

Shares management library.

_This implementation mitigates share price manipulations, using OpenZeppelin's method of virtual shares:
https://docs.openzeppelin.com/contracts/4.x/erc4626#inflation-attack._

### VIRTUAL_SHARES

```solidity
uint256 VIRTUAL_SHARES
```

_The number of virtual shares has been chosen low enough to prevent overflows, and high enough to ensure
high precision computations.
Virtual shares can never be redeemed for the assets they are entitled to, but it is assumed the share price
stays low enough not to inflate these assets to a significant value.
Warning: The assets to which virtual borrow shares are entitled behave like unrealizable bad debt._

### VIRTUAL_ASSETS

```solidity
uint256 VIRTUAL_ASSETS
```

_A number of virtual assets of 1 enforces a conversion rate between shares and assets when a market is
empty._

### toSharesDown

```solidity
function toSharesDown(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256)
```

_Calculates the value of `assets` quoted in shares, rounding down._

### toAssetsDown

```solidity
function toAssetsDown(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256)
```

_Calculates the value of `shares` quoted in assets, rounding down._

### toSharesUp

```solidity
function toSharesUp(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256)
```

_Calculates the value of `assets` quoted in shares, rounding up._

### toAssetsUp

```solidity
function toAssetsUp(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256)
```

_Calculates the value of `shares` quoted in assets, rounding up._

