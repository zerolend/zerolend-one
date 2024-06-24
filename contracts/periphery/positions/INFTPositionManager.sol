// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

// ███████╗███████╗██████╗  ██████╗
// ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
//   ███╔╝ █████╗  ██████╔╝██║   ██║
//  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
// ███████╗███████╗██║  ██║╚██████╔╝
// ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

// Website: https://zerolend.xyz
// Discord: https://discord.gg/zerolend
// Twitter: https://twitter.com/zerolendxyz
// Telegram: https://t.me/zerolendxyz

interface INFTPositionManager {
  /**
   * @notice Error indicating that the caller is not the owner or approved operator of the token ID.
   */
  error NotTokenIdOwner();

  /**
   * @notice Error indicating that a zero address was provided, which is not allowed.
   */
  error ZeroAddressNotAllowed();

  /**
   * @notice Error indicating that a zero value was provided, which is not allowed.
   */
  error ZeroValueNotAllowed();

  /**
   * @notice Error indicating a mismatch in balance.
   */
  error BalanceMisMatch();

  /**
   * @notice Error indicating that the position is not cleared.
   */
  error PositionNotCleared();

  /**
   * @notice Error indicating that pool is not register in pool factory.
   */
  error NotPool();

  /**
   *
   * @param asset The address of the asset that we want to borrow.
   * @param tokenId  The ID of the position token.
   * @param amount The amount of the asset that we want to borrow.
   */
  event BorrowIncreased(address indexed asset, uint256 indexed amount, uint256 indexed tokenId);

  /**
   *
   * @param asset The address of the asset that we want to withdraw
   * @param amount The amount of asset that we want to withdraw
   * @param tokenId The ID of the NFT.
   *
   */

  event Withdrawal(address indexed asset, uint256 indexed amount, uint256 tokenId);

  /**
   *
   * @param asset The address of the asset that we want to repay.
   * @param tokenId The ID of the NFT.
   * @param amount The amount of asset that we want to repay
   */
  event Repay(address indexed asset, uint256 indexed tokenId, uint256 indexed amount);

  /**
   * @notice Emitted when liquidity is increased for a specific position token.
   * @param asset The address of the asset for which liquidity was increased.
   * @param tokenId The ID of the position token.
   * @param amount The amount of the asset that was added to the position.
   */
  event LiquidityIncreased(address indexed asset, uint256 indexed tokenId, uint256 indexed amount);

  /**
   * @notice Parameters required for minting a new position token.
   * @param asset The address of the asset to be supplied.
   * @param pool The address of the pool where the asset will be supplied.
   * @param amount The amount of the asset to be supplied.
   */
  struct MintParams {
    address asset;
    address pool;
    uint256 amount;
  }

  /**
   * @notice Parameters required for handling liquidity operations.
   * @param asset The address of the asset involved in the operation.
   * @param pool The address of the pool where the operation is being performed.
   * @param user The address of the user performing the operation.
   * @param amount The amount of the asset involved in the operation.
   * @param tokenId The ID of the position token related to the operation.
   */
  struct LiquidityParams {
    address asset;
    address pool;
    uint256 amount;
    uint256 tokenId;
  }

  /**
   * @notice Structure representing an asset in a user's position.
   * @param asset The address of the asset.
   * @param balance The balance of the asset in the position.
   * @param debt The debt of the asset in the position.
   */
  struct Asset {
    address asset;
    uint256 balance;
    uint256 debt;
  }

  /**
   * @notice Structure representing a user's position, including assets, pool, and operator.
   * @param assets An array of assets held in the position.
   * @param pool The address of the pool associated with the position.
   * @param operator The address of the operator managing the position.
   */
  struct Position {
    Asset[] assets;
    address pool;
    address operator;
  }

  /**
   * @notice Parameters required for various asset operations (add liquidity, borrow, repay, withdraw) against a position.
   * @param asset The address of the asset involved in the operation.
   * @param amount The amount of the asset involved in the operation.
   * @param tokenId The ID of the position token involved in the operation.
   */
  struct AssetOperationParams {
    address asset;
    uint256 amount;
    uint256 tokenId;
  }
}
