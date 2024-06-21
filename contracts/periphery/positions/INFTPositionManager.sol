// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

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
   * @notice Error indicating that the provided address is invalid and not present in the debt market.
   */
  error InvalidAssetAddress();

  /**
   * @notice Error indicating a mismatch in balance.
   */
  error BalanceMisMatch();

  /**
   * @notice Error indicating that the position is not cleared.
   */
  error PositionNotCleared();

  /**
   * @notice Emitted when an NFT is minted.
   * @param recipient The address that received the minted NFT.
   * @param tokenId The ID of the minted NFT.
   */
  event NFTMinted(address indexed recipient, uint256 indexed tokenId);

  /**
   * @notice Emitted when an NFT is burned.
   * @param tokenId The ID of the burned NFT.
   */
  event NFTBurned(uint256 indexed tokenId);

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
   * @param recipient The address of the recipient who will receive the position token.
   * @param pool The address of the pool where the asset will be supplied.
   * @param amount The amount of the asset to be supplied.
   */
  struct MintParams {
    address asset;
    address recipient;
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
    address user;
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
   * @notice Parameters required for increasing liquidity in a position.
   * @param asset The address of the asset to be added.
   * @param amount The amount of the asset to be added.
   * @param tokenId The ID of the position token to be updated.
   */
  struct AddLiquidityParams {
    address asset;
    uint256 amount;
    uint256 tokenId;
  }

  /**
   * @notice Parameters required for borrowing an asset against a position.
   * @param asset The address of the asset to be borrowed.
   * @param amount The amount of the asset to be borrowed.
   * @param tokenId The ID of the position token against which the asset is being borrowed.
   */
  struct BorrowParams {
    address asset;
    uint256 amount;
    uint256 tokenId;
  }

  /**
   * @notice Parameters required for repaying a borrowed asset against a position.
   * @param asset The address of the asset to be repaid.
   * @param amount The amount of the asset to be repaid.
   * @param tokenId The ID of the position token against which the asset is being repaid.
   */
  struct RepayParams {
    address asset;
    uint256 amount;
    uint256 tokenId;
  }

  /**
   * @notice Parameters required for withdrawing an asset from a position.
   * @param asset The address of the asset to be withdrawn.
   * @param user The address of the user who will receive the withdrawn asset.
   * @param amount The amount of the asset to be withdrawn.
   * @param tokenId The ID of the position token from which the asset is being withdrawn.
   */
  struct WithdrawParams {
    address asset;
    address user;
    uint256 amount;
    uint256 tokenId;
  }

  /**
   * @notice Enum representing the type of operation being performed.
   * @dev Can be either Supply or Borrow.
   */
  enum OperationType {
    Supply,
    Borrow
  }

  /**
   * @notice Enum representing the action to perform on a position.
   * @dev Can be either Add or Subtract.
   */
  enum ActionType {
    Add,
    Subtract
  }
}
